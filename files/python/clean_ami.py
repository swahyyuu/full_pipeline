import boto3

ec2 = boto3.client("ec2")
my_ami = ec2.describe_images(Owners=['self'])

for ami in my_ami['Images']:
  ami_id = ami['ImageId']
  ec2.deregister_image(ImageId=ami_id)