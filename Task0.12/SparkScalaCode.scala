import org.apache.spark._

object WordCount{
        def main(args:Array[String]){
                val conf = new SparkConf()
                conf.set("spark.master", "local")
                conf.set("spark.app.name", "app1")
                val sc = new SparkContext(conf)
                var map = sc.textFile("/home/user/Shakespeare.txt").flatMap(line => line.split(" ")).map(word => (word,1));
                var counts = map.reduceByKey(_ + _);
                counts.saveAsTextFile("/home/user/ScalaSparkoutput/");
            
                sc.stop()
                }
}
