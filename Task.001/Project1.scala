// Importing the Scala Source
import scala.io.Source

// Import the mutable Tree Map to sort the output map.

import scala.collection.mutable.TreeMap

// Name the object WORDCOUNT
object WORDCOUNT {
  def main(args: Array[String]): Unit = {
    
 // Load the text File

    val input = Source.fromFile("Shakespeare.txt").mkString

// define a function countWords

 def countWords(text: String) = {

// Create an empty map and sort the result using the String characters
    val counts = TreeMap.empty[String, Int]
// Clean the text file and store it in rawWord
    for (rawWord <- input.split("\\W+")) {

        val word = rawWord.toLowerCase
//
        val oldCount =

            if (counts.contains(word)) counts(word)
            
            else 0

        counts += (word -> (oldCount +1))

    }

    counts

    val sortCount = for ((k,v) <- counts) yield (v,k)

    println(sortCount)



 }
   countWords(input)

    }
}