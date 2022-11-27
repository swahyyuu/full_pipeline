import boto3

def remove_ami():
  my_ami = ec2.describe_images(Owners=['self'])

  for ami in my_ami['Images']:
    ami_id = ami['ImageId']
    ec2.deregister_image(ImageId=ami_id)

def remove_snapshot():
  snapshots = ec2.snapshots.filter(OwnerIds=['self'])

  for snapshot in snapshots:
    snapshot.delete()    

if __name__ == '__main__':
  ec2 = boto3.client("ec2", region_name='ap-southeast-1')
  remove_ami
  ec2 = boto3.resource("ec2", region_name='ap-southeast-1')
  remove_snapshot