from pyspark import SparkContext
from pyspark.streaming import StreamingContext
from pyspark.streaming.kafka import KafkaUtils
from pyspark.sql import SparkSession
import json



if __name__== "__main__":

      # Create Session
        sc = SparkContext("local[*]", )
        ssc = StreamingContext(sc,12)
        
        ss = SparkSession.builder.enableHiveSupport().getOrCreate()
        kafkaStream = KafkaUtils.createStream(ssc, "localhost:2181","twitter", {"tweets" :1 }) 

        # Parse the Tweets
        parsed = kafkaStream.map(lambda y: json.loads(y[1])).filter(lambda y: y.get("lang") ==  "en") \
                                                              .map(lambda y: (y.get("id"),y.get("text")))

        #Custom function: process parsed tweets as df &append to hive

        def process(rdd):
            if not rdd.isEmpty():
                    global ss
                    df = ss.createDataFrame(rdd, schema=["id", "text"])
                    df.show()
                      #df.write.saveAsTable(name ="tweets_db.tweets_tbl", format="hive", mode="append")

        # Write parsed tweets to Hive
        parsed.foreachRDD(process)


        # start Streaming Context
        ssc.start()

        # stop streaming context (auto)
        ssc.awaitTermination()