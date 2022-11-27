import boto3

def remove_ami():
  my_ami = ec2.describe_images(Owners=['self'])

  for ami in my_ami['Images']:
    ami_id = ami['ImageId']
    ec2.deregister_image(ImageId=ami_id)

if __name__ == '__main__':
  ec2 = boto3.client("ec2", region_name='ap-southeast-1')
  remove_ami