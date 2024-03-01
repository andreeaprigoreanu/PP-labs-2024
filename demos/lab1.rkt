#lang racket

; (func arg1 arg2 arg3 ...) -> evaluare aplicativa = eager evaluation

; operatori aritm: +, -, *, /, modulo, quotient

; (max (+ 2 3) 4) -> (max 5 4) -> 5

; (2 + 5 * 3) * (4 - 10 / 2)
(* (+ 2 (* 5 3)) (- 4 (/ 10 2)))

; (/ 10 3)           => fractie
; (quotient 10 3)    => rezultat intreg 

; (3 + 2)

; LEGAREA VARIABILELOR
; sintaxa: (define nume expr)
(define n 10)
(define m (+ 2 3 4))
(define str "abc")
(define chr #\a)
(define sym 'lalala)
(define true #t)
(define false #f)

; (define n 12)

; definire functii: (define (function-name arg1 arg2 ...) corp)
(define (my-add1 x) (+ 1 x))

(define (my-add x y) (+ x y))

; functii anonime: (lambda (arg1 arg2 arg3...) corp)
(lambda (x) (+ 2 x))

((lambda (x) (+ 2 x)) 3)

(define prod (lambda (x y) (* x y)))

(define prod2
  (lambda (x)
    (lambda (y)
      (* x y))))

((prod2 2) 3)

; PERECHI
(define pair1 (cons 1 2))
(define pair2 (cons 1 (cons 2 3)))
; car, cdr - pentru accesarea elementelor

; LISTE
; lista vida: null sau '()
; cons
(define L1 (cons 1 null))
(define L2 (cons 2 L1))
(define L3 (cons 3 '(1 2 3 4)))

; list
(define L4 (list 2 3 4))
(define L5 (list '(2 3) '(3 4) 5))

; !!! list vs apostrof
(define L6 (list (+ 1 3) (* 2 3) 4))
(define L7 '((+ 1 3) (* 2 3) 4))
(define L8 '(cons 2 3))          ; (eval L8) => '(2 . 3)


; cum accesam elementele: car, cdr (first/rest)
(car L2)
(cdr L2)

; combinatii: cadr, cdar, cddr, caddr

; alte functii utile: null?, list?, length, member, reverse, append, take, drop ...
; muulte altele : check Racket Documentation


; op relationali: <, <=, >, >=, =     -> pentru numere
; !! compararea a doua liste: eq? vs equal?
; eq? - comp referinte
(eq? '(1 2 3) '(1 2 3))       ; #f
; equal? - comp valori
(equal? '(1 2 3) '(1 2 3))    ; #t

(define x 10)
(define y (+ 2 8))

; and / or
; and - evaluarea parametriilor se opreste cand se intalneste expresie evaluata la #f
(and (< 2 3) (> 5 7))
(and (< 2 3) (> 5 7) (/ 1 0))
(and 0 1)
; or - evaluarea parametriilor se opreste cand se intalneste expresie evaluata la #t
(or (> 5 7) (< 2 3) (/ 1 0))

; CONDITIONALE
; (if expr thenexpr elseexpr)
(define a 5)
(if (> a 5)
    "hello"
    (if (< a 5)
        "ok"
        "no"))

; (cond (conditie1 expresie1) (condite2 expr2) ... (else expr))
; else - optional
(cond [(> a 5) "hello"]
      [(< a 5) "ok"]
      [else "no"])


; !!!
(define (g x)
  (if (>= x 10)
      "hello"
      (/ 1 0)))


; ex de functii
; '(1 2 3 4) 3
(define (my-member L x)
  (if (null? L) #f
      (if (equal? (car L) x) #t
          (my-member (cdr L) x))))

(define (my-member-2 L x)
  (cond [(null? L) #f]
        [(equal? (car L) x) #t]
        [else (my-member (cdr L) x)]))