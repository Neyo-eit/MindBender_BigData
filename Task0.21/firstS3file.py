
if __name__=="__main__":
	bucket = 'bd-mindbenders2468'


	import boto3, os
	s3 = boto3.resource('s3')
	file = 'data_Hbase.csv'
	
	f = open(file)
	fil= f.read().encode('utf-8')
	s3.Bucket(bucket).put_object(Key='testS3file.csv' , Body=fil)

