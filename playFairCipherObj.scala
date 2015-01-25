/**
 * @author upisa01
 *
 */
package playFairCipherPack
import java.util.Scanner
import scala.io.Source
import java.io._
import java.lang.{ StringBuilder => JavaStringBuilder }

object playFairCipherObj {
  
  private val maxKeyLeng = 12
  private val minKeyLeng = 4
  private val toEncodfilename = "src\\playFairCipherPack\\toEncod.txt"
  private var toEncod: String = ""   
   
  def main(arg: Array[String]) {
    
   

    /* 
    var toEncod2: String = "bnmbnm bnm sdfasf MMMM EEEE ,." 
    toEncod2 = toEncod2.toLowerCase().replaceAll("[^a-z]", "");//no white space 
     
    // http://www.tutorialspoint.com/scala/scala_file_io.htm
    val writer = new PrintWriter(new File("src\\playFairCipherPack\\test.txt"))
    writer.write("Hello Scala")
    writer.close()

    println("Following is the content read:")
    Source.fromFile("src\\playFairCipherPack\\test.txt").foreach {
      print
    }*/

    print("Choose 1 encode and ENTER\nChoose 2 decode and ENTER\nChoose 3 quit and ENTER \n")
    validInputChoice()


  }

  def encode() {
    validKeyword()
    //
    if (!(isTxtOk(toEncodfilename).equals("false"))) {
      println("This is text for encode")
      toEncod = (isTxtOk(toEncodfilename).replaceAll("\n", " ") )
      toEncod = toEncod.toLowerCase().replaceAll("[^a-z ]", "")// white ok
      println(toEncod);println(toEncod.replaceAll("[^a-z]", ""))
    } else { println("Sorry") }
  }

  def decode() {
    validKeyword()
    print("dencode ")
  }

  def isTxtOk(fileName: String): String = {
    var s = ""
    try {
      for (line <- Source.fromFile(toEncodfilename).getLines) {
        s += line + "\n"
        // println(line)
      }
    } catch {
      case e: FileNotFoundException => println("Couldn't find that file. I can not encode.")
      case e: IOException => println("Got an IOException! I can not encode.")
    }
    if (s != "")  s else "false"
  }

  def validKeyword() {
    var vld = false
    do {
      val keyWord = readLine("Type your keyword between 4 and 12 character no number \n>")
      def isOnlyChars(keyWord: String) = keyWord.matches("^[a-zA-Z]*$")
      def isLessMaxKeyLeng(keyWord: String) = if (keyWord.length() <= maxKeyLeng) true else false
      def isOkMinKeyLeng(keyWord: String) = if (keyWord.length() >= minKeyLeng) true else false
      if (isLessMaxKeyLeng(keyWord) && isOnlyChars(keyWord) && isOkMinKeyLeng(keyWord)) { vld = true }
    } while (!vld)
  }

  def validInputChoice() {
    var vld = false
    while (vld == false) {
      try {
        val n = readInt()
        if (n >= 1 && n <= 2) {
          vld == true
          if (n == 1) {
            encode()
          } else { decode() }
        } else if (n == 3) {
          print("Quit")
          return
        } else (print("invalid input use 1 or 2 or 3 \n"))

      } catch {
        case ex: Exception => print("invalid input use 1 or 2 or 3\n")
      }
    }
  }

}
