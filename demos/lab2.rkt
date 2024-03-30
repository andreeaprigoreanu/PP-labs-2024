#lang racket/gui

(require (lib "trace.ss"))


; rec stiva
(define (list-sum-stack L)
  (if (null? L)
      0
      (+ (car L) (list-sum-stack (cdr L)))))

; (trace list-sum-stack)


; rec coada
(define (list-sum-tail-helper L acc)
  (if (null? L)
      acc
      (list-sum-tail-helper (cdr L) (+ acc (car L)))))

(define (list-sum-tail L)
  (list-sum-tail-helper L 0))

; (trace list-sum-tail)

(define (rev-helper L acc)
  (if (null? L)
      acc
      (rev-helper (cdr L) (cons (car L) acc))))
  
(define (rev L)
  (rev-helper L '()))

(define (find-elem L elem)
  (cond
    [(null? L) #f]
    [(= (car L) elem) #t]
    [else (find-elem (cdr L) elem)]))
;---------------------------------------------------------
; construirea rezultatului stiva vs coada
; stiva

(define (add5-stack L)
  (if (null? L)
      '()
      (cons (+ 5 (car L)) (add5-stack (cdr L)))))

(add5-stack '(1 2 3 4))    

; coada

(define (add5-tail L [acc '()])
  (if (null? L)
      acc
      (add5-tail (cdr L) (cons (+ 5 (car L)) acc))))


; (add5-tail '(1 2 3 4) '())    ; rezultat gresit: '(9 8 7 6)

; solutie 1: inversarea rezultatului final
(define (add5-tail-1 L acc)
  (if (null? L)
      (reverse acc)
      (add5-tail-1 (cdr L) (cons (+ 5 (car L)) acc))))
; solutie 2: utilizarea append (ineficientă)
(define (add5-tail-2 L acc)
  (if (null? L)
      acc
      (add5-tail-2 (cdr L) (append acc (list (+ 5 (car L)))))))

;--------------------------------------------------------
(define (my-member-2 L x)
  (cond [(null? L) #f]
        [(equal? (car L) x) #t]
        [else (my-member (cdr L) x)]))
