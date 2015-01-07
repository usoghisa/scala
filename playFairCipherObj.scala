package hello
import java.util.Scanner;
object HelloObj {
  def main(arg: Array[String]) {
    val maxKeyLeng = 12
    print("choose 1 encode\nchoose 2 decode\nchoose 3 quit. \n")
    validInputChoice()
   def kw(){
      val keyWord = readLine("Type your keyword no more than 12 character")
      def isOnlyChars(string: String) = string.matches("^[a-zA-Z]*$")
      def isLessMaxKeyLeng(keyWord: String) = if(keyWord.length() <= maxKeyLeng)true else false  
    }
    
    def encode() {
      kw()
      print("encode")
    }

    def decode() {
      kw()
      print("dencode ")
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
