import boto3
bucketname = 'bd-mindbenders2468' # replace with your bucket name
filename = 'testS3file.csv' # replace with your object key
s3 = boto3.resource('s3')
s3.Bucket(bucketname).download_file(filename, 'testS3file.csv')
