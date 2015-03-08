;;load to dr raket
#lang racket

(require racket/set)

(define (parts matrix row column number)
  (take (drop (car(take (drop matrix row)1))column)number))
  
(define mtrx '(
              (r 2 3 x 5 6 7 8 9) 
              (3 2 3 y 5 6 7 8 9)
              (3 2 3 z 5 6 7 8 3)
              (4 2 3 4 5 6 7 8 9)
              (5 2 3 4 5 6 7 8 9)
              (6 2 3 4 5 6 7 8 9)
              (7 2 3 a (set 1 5) 6 7 8 9)
              (8 2 3 b 5 6 7 8 9)
              (9 2 3 c 5 6 7 8 9)))

(flatten (list (parts mtrx 0 6 3)
               (parts mtrx 1 6 3)
               (parts mtrx 2 6 3)))

(define block(flatten(list 
                    (parts mtrx 0 0 3)
                    (parts mtrx 1 0 3)
                    (parts mtrx 2 0 3))))

;return single element parameterised
(define (sglEle mtrx r c n )
  (car(parts mtrx r c n)))
;return any block parameterised
(define(anyBlock mtrx r1 c1 n1 r2 c2 n2 r3 c3 n3)
               (flatten(list
                    (parts mtrx r1 c1 n1)
                    (parts mtrx r2 c2 n2)
                    (parts mtrx r3 c3 n3))))

;return any block parameterised
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



(sglEle mtrx 0 1 1 )
(number? (sglEle mtrx 0 0 1 ))
(= 0 (sglEle mtrx 1 0 1 ))


(define row1 (anyBlock mtrx 
          0 0 3 
          0 3 3 
          0 6 3 ))
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
row1
col1
(car(parts mtrx 2 8 1))
(car(parts mtrx 6 4 5)) ;r c n

