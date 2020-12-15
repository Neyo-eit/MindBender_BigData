import org.apache.spark.sql.functions._
import org.apache.spark.sql.SparkSession
import org.apache.spark.sql._
import org.apache.spark.sql.streaming._
import org.apache.spark.sql.types._
import com.mongodb.spark._
import org.bson.Document
import com.mongodb.spark.sql._


object StreamHandler {
       def main(args: Array[String]) {






               // initialize Spark

               val spark = SparkSession
                          .builder
                          .appName("CovidTracking")
                          .master("local[*]")
                          .getOrCreate()
  
               
               import spark.implicits._

               // read from Kafka and
              // Subscribe to the topic "Covid"
              val streamingInputDF = spark
              .readStream
              .format("kafka")
              .option("kafka.bootstrap.servers", "localhost:9092,localhost:9093,localhost:9094")
              .option("subscribe", "Covid")
              .option("startingOffsets", "earliest")
              .load()   
              
               val defStructure =  StructType(List(
                  StructField("Active Cases_text", StringType, true),
                  StructField("Country_text", StringType, true),
                  StructField("Last Update", StringType, true),
                  StructField("New Cases_text", StringType, true),
                  StructField("New Deaths_text", StringType, true),
                  StructField("Total Cases_text", StringType, true),
                  StructField("Total Deaths_text", StringType, true),
                  StructField("Total Recovered_text", StringType, true)
                ))
                
               val DF =streamingInputDF.selectExpr("CAST(value AS STRING)").as[(String)]

               val lines = DF.select($"value" cast "string" as "json")
               .select(from_json($"json", defStructure) as "data")
               .select("data.*")
                
                

               val DFa = lines
                .writeStream
                .format("console")
                .outputMode("update").start()
              
              
                  DFa.awaitTermination()

     }

  }