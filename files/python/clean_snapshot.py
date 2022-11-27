import boto3

def remove_snapshot():
  ec2 = boto3.resource("ec2")
  snapshots = ec2.snapshots.filter(OwnerIds=['self'])

  for snapshot in snapshots:
    snapshot.delete()

if __name__ == '__main__':
  ec2 = boto3.resource("ec2", region_name="ap-southeast-1")
  remove_snapshot