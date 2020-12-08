import boto3 
import pydoop.hdfs as hdfs

bucket = "bd-mindbenders2468"

s3 = boto3.resource("s3")

file = hdfs.open("hdfs://master:9000/TweeeterData/FlumeData.1605125592849")
s3.Bucket(bucket).put_object(Key="hdfsToS3", Body=file)    

