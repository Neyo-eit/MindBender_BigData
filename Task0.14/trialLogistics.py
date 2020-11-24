from pyspark import SparkContext
from pyspark.streaming import StreamingContext
from pyspark.streaming.kafka import KafkaUtils
from pyspark.sql import SparkSession
import json



if __name__== "__main__":
      sc = SparkContext("local[*]", )
      ssc = StreamingContext(sc,12)
      
      ss = SparkSession.builder.appName(sc.appName).config("spark.sql.warehouse.dir", "/user/hive/warehouse") \
            .config("hive.metastore.uris", "thrift://localhost:9083").enableHiveSupport().getOrCreate()
            
      kafkaStream = KafkaUtils.createStream(ssc, "localhost:2181","Logistic", {"Logistics" : 1 }) 

      # Parse the Tweets
      parsed = kafkaStream.map(lambda y: json.loads(y[1]))
      data = parsed.flatMap(lambda y:y.get("data"))
      result = data.map(lambda y: (y.get("name"),y.get("code"), y.get("phone"), y.get("type"), y.get("picture"), y.get("name_cn")))

      
       
      def process(rdd):
            if not rdd.isEmpty():
                  global ss
                  df = ss.createDataFrame(rdd, schema=[ "name", "code", "phone", "type", "picture", "name_cn"])
                  df.show()
                  df.write.saveAsTable(name ="minitask.logistictable", format="hive", mode="overwrite")

      # # # Write parsed tweets to Hive
      result.foreachRDD(process)


      # start Streaming Context
      ssc.start()

      # stop streaming context (auto)
      ssc.awaitTermination()
