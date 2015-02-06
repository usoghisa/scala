/**
 * @author upisa01
 *
 */
package playFairCipherPack
import java.util.Scanner
import scala.io.Source
import java.io._
import java.lang.{ StringBuilder => JavaStringBuilder }
import Array._
object playFairCipherObj {
  private var validateKey: String = ""
  private var cipher: String = ""
  val sz = 4
  private var cipherMatrix = ofDim[Char](sz + 1, sz + 1)
  private val maxKeyLeng = 6
  private val minKeyLeng = 4
  private val fileNameToEncode = "src\\playFairCipherPack\\toEncod.txt"
  private var toEncod: String = ""
  val alphabet = "abcdefghiklmnopqrstuvwxyz"

  def main(arg: Array[String]) {
    //print("Choose 1 encode and ENTER\nChoose 2 decode and ENTER\nChoose 3 quit and ENTER \n")
    // validInputChoice()
  }

  private def mkCipher2() {
    var cipherT = ("password" + alphabet).replaceAll("""\s+""", "").toList.distinct.mkString // make cipher
    print("cipherT.size is " + cipherT.size); println("The cipherT string is " + cipherT.mkString); println("Matrix is ")
    var c = 0
    for (i <- 0 to sz) {
      for (j <- 0 to sz) {
        cipherMatrix(i)(j) = cipherT(c);
        c = c + 1
      }
    }
    // Print two dimensional array
    for (i <- 0 to sz) {
      for (j <- 0 to sz) {
        print(cipherMatrix(i)(j) + " ");
      }
      println()
    }
    if (findChar('j') == (-1,-1)) print("sorry")else print(findChar('j')) 
  }
  
  mkCipher2()
  
  def findChar(p: Char): (Int,Int) = {
   var ltrCoo=(-1,-1)//Tuple
    for (i <- 0 to sz) {
      for (j <- 0 to sz) {
      if(cipherMatrix(i)(j)==p)  
      {  ltrCoo = (i,j)
    	  println("Find")
      }else{(-1, -1)} 
      }
    }
   print(ltrCoo._1 +" "+ ltrCoo._2 ) // Tuple2 = (i,j)
   return ((ltrCoo._1, ltrCoo._2))
  }

  //////////////////////////////////
  /**
   * Formats the output message for display as specified in
   * the assignment description.
   *
   * @param message The message to format.
   * @param count The number of characters seen so far
   * @return The message, in blocks of 5 characters separated by spaces, with newlines every 50 characters.
   */
  def fiveCharFormat(message: String, count: Int): String = {
    if (message.length > 0) {
      if (count % 50 == 0) {
        message.charAt(0) + System.getProperty("line.separator") + fiveCharFormat(message.substring(1), count + 1)
      } else if (count % 5 == 0) {
        message.charAt(0) + " " + fiveCharFormat(message.substring(1), count + 1)
      } else {
        message.charAt(0) + fiveCharFormat(message.substring(1), count + 1)
      }
    } else {
      message
    }
  }

  def encode() {
    validateKeyword()
    mkCipher()
    println("This your valid KeyWord.." + validateKey)
    if (!mkEncodeTxt().equals("FALSE")) print(fiveCharFormat(toEncod, toEncod.size)) else false
  }

  private def mkEncodeTxt(): String = {
    if (!(isTxtOk(fileNameToEncode).equals("false"))) {
      println("This is text for encode all j will be substiturte with i")
      toEncod = (isTxtOk(fileNameToEncode).replaceAll("\n", " "))
      toEncod = toEncod.toLowerCase().replaceAll("[^a-z ]", "") // preserve single whitespace
      println(toEncod);
      toEncod = toEncod.replaceAll("""\s+""", "") // white space yes ok
      toEncod = toEncod.replaceAll("j", "i")
      println(toEncod)
      println(toEncod.replaceAll("[^a-z]", "")) // white space no
      return toEncod
    } else { println("Sorry Error Occured"); return "FALSE" }
  }

  private def mkCipher() {
    cipher = (validateKey + alphabet).replaceAll("""\s+""", "").toList.distinct.mkString // make cifer
    print("Cipher.size is " + cipher.size); println("The Cipher string is " + cipher.mkString); println("Matrix is ")
    val sz = 4
    var c = 0
    var cipherMatrix = ofDim[Char](sz + 1, sz + 1)
    for (i <- 0 to sz) {
      for (j <- 0 to sz) {
        cipherMatrix(i)(j) = cipher(c);
        c = c + 1
      }
    }
    // Print two dimensional array
    for (i <- 0 to sz) {
      for (j <- 0 to sz) {
        print(cipherMatrix(i)(j) + " ");
      }
      println();
    }
  }

  def decode() {
    validateKeyword()
    print("dencode ")
  }

  def isTxtOk(fileName: String): String = {
    var s = ""
    try {
      for (line <- Source.fromFile(fileNameToEncode).getLines) {
        s += line + "\n"
        // println(line)
      }
    } catch {
      case e: FileNotFoundException => println("Couldn't find that file. I can not encode.")
      case e: IOException => println("Got an IOException! I can not encode.")
    }
    if (s != "") s else "false"
  }

  def validateKeyword() {
    var vld = false
    do {
      val keyWord = readLine("Type your keyword between 4 and 6 character \nNO NUMBER NO SPACE NO UPPERCASE NO DUPLICATE \nThe letter \"j\" will be substitute with  \"i\" \n>")
      def isOnlyChars(keyWord: String) = keyWord.matches("^[a-z]*$")
      def isLessMaxKeyLeng(keyWord: String) = if (keyWord.length() <= maxKeyLeng) true else false
      def isOkMinKeyLeng(keyWord: String) = if (keyWord.length() >= minKeyLeng) true else false
      def isNoDupLet(keyWord: String) = if (keyWord.toList == keyWord.toList.distinct) true else false
      if (isLessMaxKeyLeng(keyWord) &&
        isOnlyChars(keyWord) &&
        isOkMinKeyLeng(keyWord) &&
        isNoDupLet(keyWord)) { vld = true; validateKey = keyWord.replace("j", "i") }
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
