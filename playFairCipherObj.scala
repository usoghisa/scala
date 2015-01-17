package hello
import java.util.Scanner
import scala.io.Source
import java.io._


object HelloObj {
  def main(arg: Array[String]) {
    val maxKeyLeng = 12
    val minKeyLeng = 4

    // http://www.tutorialspoint.com/scala/scala_file_io.htm
    val writer = new PrintWriter(new File("src\\hello\\test.txt"))
    writer.write("Hello Scala")
    writer.close()

    println("Following is the content read:")
    Source.fromFile("src\\hello\\test.txt").foreach {
      print
    }

   
    val filename = "src\\hello\\uuu.txt"
    try {
      for (line <- Source.fromFile(filename).getLines) {
        println(line)
      }
    } catch {
      case e: FileNotFoundException => println("Couldn't find that file.")
      case e: IOException => println("Got an IOException!")
    }
     
    
    print("choose 1 encode\nchoose 2 decode\nchoose 3 quit. \n")
    validInputChoice()

    def encode() {
      validKeyword()
      ttt("uuu.txt")
      print("encode")
    }

    def decode() {
      validKeyword()
      print("dencode ")
    }

    def ttt(fileName: String){
      try {
         val f = new FileReader(fileName)
      } catch {
         case ex: FileNotFoundException => {
            println("Missing file exception")
         }
         case ex: IOException => {
            println("IO Exception")
         }
      } finally {
         println("Exiting finally...")
      }
    }

    def validKeyword() {
      var vld = false
      do {
        val keyWord = readLine("Type your keyword no between 4 12 character no number \n>")
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
          } else (print("invalid input \n"))

        } catch {
          case ex: Exception => print("invalid input \n")
        }
      }
    }

  }
}
