import boto3
import re 

def lambda_handler(event, context):
  ec2 = boto3.resource("ec2")
  regions = []

  for region in ec2.meta.client.describe_regions()['Regions']:
    regions.append(region['RegionName'])

  for region in regions:
    ec2 = boto3.resource("ec2", region_name=region)
    ec2_client = boto3.client("ec2")

    if (region == "ap-southeast-1"):
      print(f"Ec2 current Region is : {region}")

      ec2_instance = {"Name" : "tag:Name", "Values" : ["*terraform*"]}
      filtered_ec2 = ec2.instances.filter(Filters=[ec2_instance])

      regex = "(?:terraform)*"
      match_regex = re.findall(regex, ec2_instance["Values"][0])

      if (match_regex):
        for instance in filtered_ec2:
          ec2_client.start_instances(InstanceIds=[instance.id])
          
          instance_waiter = ec2_client.get_waiter('instance_running')
          instance_waiter.wait(InstanceIds=[instance.id])

          print("%s is now running" %instance.id)