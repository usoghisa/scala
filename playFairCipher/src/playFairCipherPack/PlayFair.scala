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

object PlayFair {
	private var validateKey: String = ""
			private var cipher: String = ""
			private val sz = 4
			private var cipherMatrix = ofDim[Char](sz + 1, sz + 1)
			private val maxKeyLeng = 6
			private val minKeyLeng = 4
			private val fileNameToEncode = "src\\playFairCipherPack\\toEncod.txt"
			private var toEncod: String = ""//clean text to be encoded
			private var encodedTXT: String = ""
			private val alphabet = "abcdefghiklmnopqrstuvwxyz"

			def main(arg: Array[String]) {
	print("YOU NEED toEncode.txt in this path src/playFairCipherPack/toEncod.txt \nChoose 1 encode and ENTER\nChoose 2 decode and ENTER\nChoose 3 quit and ENTER \n")
	validInputChoice()  
}
/**
 * encode or decode txt
 *
 * @param s message to ecode decode with an even number of char
 * @return The message as StringBuilder
 */
def encDecodeTxt(s:String): StringBuilder = {
		var encPair =('x','y')   
				var sb = new StringBuilder(s)
		var res = new StringBuilder("")
		//println("KKK"+sb+sb.size )
		//if (sb.size %2 > 0) sb.append("x") else null
		for(i <- 0 until sb.size-1 by 2) {
			encPair = encodeDecodePairLet(sb.charAt(i),sb.charAt(i+1))
					res.append(encPair._1)
					res.append(encPair._2)	    
		}

		return(res)
}
/**
 * encode or decode each pair of letter
 *
 * @param l1, l2 are single character
 * @return tuple of de/encoded char
 */
def encodeDecodePairLet(l1: Char,l2: Char):(Char,Char) = {    
	var c1 = (-1,-1)
			var c2 = (-1,-1)
			var temp = (-1,-1)
			var pair = (-1,-1,-1,-1)
			if (findChar(l1) == (-1,-1)) {print("sorry")}else{ c1 = findChar(l1); //print("okk");
			} 
	if (findChar(l2) == (-1,-1)) {print("sorry")}else{ c2 = findChar(l2);//print("okk");  
	} 
	temp = (c1._1, c1._2)
			c1=(c1._1,c2._2)
			c2=(c2._1,temp._2)
			pair=(c1._1,c1._2, c2._1,c2._2) 
			return(cipherMatrix(pair._1)(pair._2), cipherMatrix(pair._3)(pair._4))
}
/**
 * return coordinate of single char
 *
 * @param p single character
 * @return tuple of coordinate
 */
def findChar(p: Char): (Int,Int) = {
	var ltrCoo=(-1,-1)//Tuple
			for (i <- 0 to sz) {
				for (j <- 0 to sz) {
					if(cipherMatrix(i)(j)==p)  
					{  ltrCoo = (i,j)//println("Find "+p)
					}else{(-1, -1)} 
				}
			}
	//print(ltrCoo._1 +" "+ ltrCoo._2 ) // Tuple2 = (i,j)
	return (ltrCoo._1,ltrCoo._2)
}

/**
 * Formats the output message 
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

/**
 * encode the message using several method call, validate password to be encode, output matrix 
 * print encoded message 5 char formatted
 */
def encode() {
	var encodedTXTFiveChar=""
			validateKeyword()
			mkCipher()
			println("This your valid KeyWord.." + validateKey)
			
			if (!mkEncodeTxt().equals("FALSE")) {
				//print("%%%"+toEncod+"%%%"+fiveCharFormat(toEncod, toEncod.size))
				encodedTXT = encDecodeTxt(toEncod).toString
						encodedTXTFiveChar = fiveCharFormat(encodedTXT, encodedTXT.size)
						//println("KKK " + fiveCharFormat("123456", "123456".size))
						print("ENCODED TXT >"+ encodedTXTFiveChar)
						print("\nNOW TYPE 2 TO DECODE >")
						/// print("\nDECODED TXT >"+encDecodeTxt(str))
			}  
}
/**
 * prepare txt to be encode if char are odd add x at the end, print message no white space
 * 
 * @return message ready to be encoded 
 */
private def mkEncodeTxt(): String = {
  var tmp=""
		if (!(isTxtOk(fileNameToEncode).equals("false"))) {
			println("This is text for encode all j will be substiturte with i")
			toEncod = (isTxtOk(fileNameToEncode).replaceAll("\n", " "))
			toEncod = toEncod.toLowerCase().replaceAll("[^a-z ]", "") // preserve single whitespace
			//println(toEncod);
			toEncod = toEncod.replaceAll("""\s+""", "") // white space yes ok
			toEncod = toEncod.replaceAll("j", "i")
			//println("TXT to encode No white space >"+ toEncod.replaceAll("[^a-z]", "")) // white space no
			tmp =toEncod.replaceAll("[^a-z]", "")
			toEncod = if (tmp.size %2 > 0) tmp+"x" else tmp
			println("TXT to encode No white space >"+ toEncod)
			return toEncod
		} else {println("Sorry Error Occured"); return "FALSE" }
}
/**
 * Print the chipher matrix
 * 
 * @return message ready to be encoded 
 */
private def mkCipher() {
	var cipherT = (validateKey + alphabet).replaceAll("""\s+""", "").toList.distinct.mkString // make cifer
			// var cipherT = ("password" + alphabet).replaceAll("""\s+""", "").toList.distinct.mkString // make cipher
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
			}// find letter in chifer

}
/**
 * Check that a message is ready to decode if not print NOTHING TO DECODE
 * 
 */
def decode() {
	var decodedTXTFiveChar=""
			var decoded =""
			//validateKeyword()
			if (!encodedTXT.equals("") ){
				decoded  = encDecodeTxt(encodedTXT).toString
						decodedTXTFiveChar = fiveCharFormat(decoded , decoded.size)
						print("DECODED TXT >"+ decodedTXTFiveChar+"\n Enter 3 to close or 1 to restart")
						/// print("\nDECODED TXT >"+encDecodeTxt(str)) 
			}else print("NOTHING TO DECODE please enter 1 to encode TXT>"+ decodedTXTFiveChar+"\n Enter 3 to close or 1 to restart")
}
/**
 * Check if file with  message is avaiable return "false" if not trow exception
 * 
 */
def isTxtOk(fileName: String): String = {
		var s = ""
				try {
					for (line <- Source.fromFile(fileNameToEncode).getLines) {
						s += line + "\n"// println(line)
					}
				} catch {
				case e: FileNotFoundException => println("Couldn't find that file. I can not encode.")
				case e: IOException => println("Got an IOException! I can not encode.")
				}
		if (s != "") s else "false"
}
/**
 * Check if password entered by user is valid
 * 
 */
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
/**
 * Check if nuber entered by user is valid
 * 
 */
def validInputChoice() {
	var vld = false
			while (vld == false) {
				try {
					val n = readInt()
							if (n >= 1 && n <= 2) {
								vld == true
										if (n == 1) {encode()}
										else { decode() }
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














