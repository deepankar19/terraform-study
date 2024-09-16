##How to automate backup on AWS S3...?

import boto3

S3=boto3.resource("S3")
def show_buckets(S3):
    for buck in S3.buckets.all():
        print(buck.name)

def create_buckect(S3,bucket_name,region):
    S3.create_bucket(Bucket=bucket_name,CreateBucketConfiguration={'LocationConstraint':region})
    print("Bucket created successfully")

def upload_backup(S3,file_name,bucket_name,key_name):
    data=open(file_name,'rb')
    S3.Bucket(bucket_name).put_object(Key=key_name,Body=data)
    print("Backup created successfully")

bucket_name="python-for-devops"
region="us-east-2"
file_name="/path/to/backup file/in the/local system"
upload_backup(S3,file_name,bucket_name,"my_backup.tar.gz")
