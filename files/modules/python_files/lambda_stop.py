import boto3
import re 

def lambda_handler(event, context):
  ec2 = boto3.resource("ec2")
  regions = []

  for region in ec2.meta.client.describe_regions()["Regions"]:
    regions.append(region["RegionName"])

  for region in regions:
    if(region == "ap-southeast-1"):
      print(f"Ec2 current Region is : {region}")

      ec2_instance = {"Name" : "instance-state-name", "Values" : ["running"]}

      instances = ec2.instances.filter(Filters=[ec2_instance])

      for instance in instances:
        instance.stop()
        print(f"The following Ec2 instance is on stopped state : {instance.id}\n")