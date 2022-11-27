import boto3

region="ap-southeast-1"
ec2_client = boto3.client("ec2", region_name=region)
ec2 = boto3.resource("ec2", region_name=region)

my_ami = ec2_client.describe_images(Owners=['self'])

for ami in my_ami['Images']:
  ami_id = ami['ImageId']
  ec2_client.deregister_image(ImageId=ami_id)

snapshots = ec2.snapshots.filter(OwnerIds=['self'])

for snapshot in snapshots:
  snapshot.delete()