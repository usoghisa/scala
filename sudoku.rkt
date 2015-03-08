;;load to dr raket
#lang racket
(require racket/set)
(define (parts matrix row column number)
  (take (drop (car(take (drop matrix row)1))column)number))

(define mtrx '(
              (0 2 3 0 5 6 0 8 9) 
              (3 0 3 0 5 0 7 8 9)
              (3 2 3 0 5 6 7 8 3)
              (4 2 3 4 5 6 7 8 9)
              (5 2 3 4 5 6 7 8 9)
              (6 2 3 4 5 6 7 8 9)
              (7 2 3 0 0 6 7 8 9)
              (8 2 3 0 5 6 7 8 9)
              (9 2 3 0 5 6 7 8 9)))

(flatten (list (parts mtrx 0 6 3)
               (parts mtrx 1 6 3)
               (parts mtrx 2 6 3)))

(define block(flatten(list 
                    (parts mtrx 0 0 3)
                    (parts mtrx 1 0 3)
                    (parts mtrx 2 0 3))))

;return single element parameterised
(define (pivot mtrx r c n )
  (car(parts mtrx r c n)))
;return any block parameterised
(define(anyBlock mtrx r1 c1 n1 r2 c2 n2 r3 c3 n3)
               (flatten(list
                    (parts mtrx r1 c1 n1)
                    (parts mtrx r2 c2 n2)
                    (parts mtrx r3 c3 n3))))

;return any anyColum parameterised
(define(anyColum mtrx 
                     r1 c1 n1 r2 c2 n2 r3 c3 n3
                     r4 c4 n4 r5 c5 n5 r6 c6 n6
                     r7 c7 n7 r8 c8 n8 r9 c9 n9)
               (flatten(list
                    (parts mtrx r1 c1 n1)
                    (parts mtrx r2 c2 n2)
                    (parts mtrx r3 c3 n3)
                    (parts mtrx r4 c4 n4)
                    (parts mtrx r5 c5 n5)
                    (parts mtrx r6 c6 n6)
                    (parts mtrx r7 c7 n7)
                    (parts mtrx r8 c8 n8)
                    (parts mtrx r9 c9 n9))))

(print "call pivot ret 2 " ) (pivot mtrx 0 1 1 )
(print "rtn #t #f is num  ret f " ) (number? (pivot mtrx 0 0 1 ))
(print "is 0  " )(= 0 (pivot mtrx 1 0 1 ))

(define (row a b c )
  (anyBlock mtrx 
          a 0 3 
          b 3 3 
          c 6 3 ))

(row 0 0 0)

(range 10)

(print "row " ) (row 0 0 0)
(print "row " ) (row 1 1 1)
(define col1 (anyColum mtrx 
          0 0 1 
          1 0 1 
          2 0 1 
          3 0 1 
          4 0 1 
          5 0 1
          6 0 1 
          7 0 1 
          8 0 1))
(print "col1 " ) col1
(print "row1 " )(row 0 0 0) 
(print "singlr ELE r2 c8 n1 ")(car(parts mtrx 2 8 1))
(print "rtn set 6 4 5 r c n ")(car(parts mtrx 6 4 5)) ;r c n


;(map (lambda (x) (= 0 x)) row1)
(define (changeZero row1)
(map (lambda (n)
        (cond ((= 0 n) '(set 1 2 3 4 5 6 7 8 9))
         ((> 0 n))
         (else n)))row1))

(define(changeAllZero i)
  (changeZero (row i i i))
  (+ i 1)
  (changeAllZero i))

(changeZero (row 0 0 0))

(print "r__________ " );(changeAllZero )

(print "r0 " )(changeZero (row 0 0 0))
(print "r1 " )(changeZero (row 1 1 1))
(print "r2 " )(changeZero (row 2 2 2))
(print "r3 " )(changeZero (row 3 3 3)) 
(print "r4 " )(changeZero (row 4 4 4))
(print "r5 " )(changeZero (row 5 5 5)) 
(print "r6 " )(changeZero (row 6 6 6))
(print "r7 " )(changeZero (row 7 7 7))
(print "r8 " )(changeZero (row 8 8 8))   



(let* ((x 3)
(y (+ x 1)))
(print "+x y")(+ x y))



;;func
(define (double x)
(* 2 x))
; conditional 
(define (my-max x y)
(if (> x y) x y))
(define (sign n)
   (cond ((> n 0) 1)
         ((< n 0) -1)
         (else 0)))(sign 10)
;fac
(define (std-factorial n)
  (if (zero? n)
      1
      (* n (std-factorial (- n 1)))))
; tail rec
(define (factorial n)
(acc-factorial n 1))
(define (acc-factorial n sofar)
(if (zero? n)
sofar
(acc-factorial (- n 1) (* sofar n))))
