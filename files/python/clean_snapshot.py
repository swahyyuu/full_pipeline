import boto3

ec2 = boto3.resource("ec2")
snapshots = ec2.snapshots.filter(OwnerIds=['self'])

for snapshot in snapshots:
  snapshot.delete()