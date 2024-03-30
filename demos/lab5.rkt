#lang racket
(require (lib "trace.ss"))

;-------------------------------------------------
; evaluare lenesa in Racket
; var 1 - inchideri functionale

(define sum1
  (lambda (x y)
    (lambda () (+ x y))))

; (sum1 1 2)   ; => procedure
; ((sum1 1 2)) ; fortarea rezultatului

; var 2 - promisiuni

(define sum2
  (lambda (x y)
    (delay (+ x y))))

; (sum2 1 2)         ; => promisiune
; (force (sum2 1 2)) ; fortarea rezultatului

(define x (delay (+ 1 2)))
; x
; (force x)
; x
;(promise-forced? x)
;(+ (force x) 2)

;-------------------------------------------------
; FLUXURI

; 1, 1, 1, 1....
; var 1 - inchideri functionale
(define ones-stream1
  (cons 1 (lambda () ones-stream1)))

; var 2 - promisiuni
(define ones-stream2
  (cons 1 (delay ones-stream2)))

(define (my-take1 stream n)
  (if (zero? n)
      '()
      (cons (car stream) (my-take1 ((cdr stream)) (sub1 n)))))

(define (my-take2 stream n)
  (if (zero? n)
      '()
      (cons (car stream) (my-take2 (force (cdr stream)) (sub1 n)))))

; Interfata fluxuri
; cons       -> stream-cons
; car        -> stream-first
; cdr        -> stream-rest
; null/'()   -> empty-stream
; null?      -> stream-empty?
; map/filter -> stream-map/stream-filter


;; primește un flux și obține o listă cu primele n elemente din flux
(define (stream-take s n)
  (cond ((zero? n) '())
        ((stream-empty? s) '())
        (else (cons (stream-first s)
                    (stream-take (stream-rest s) (- n 1))))))

(define ones-stream3
  (stream-cons 1 ones-stream3))

; (stream-take ones-stream3 4)

; 1, -1, 1, -1...
(define (alternating x)
    (stream-cons x
                 (alternating (- x))))
(define alternating-ones (alternating 1))

; naturals stream

(define (get-naturals k)
  (stream-cons k (get-naturals (add1 k))))

(define naturals (get-naturals 0))

; stream-map
; (1 2 4 8 16 ...)
(define doubles
  (stream-cons 1 (stream-map (curry * 2) doubles)))

(define pyramids
  (stream-cons '(1)
               (stream-map (lambda (L) (append '(1) (map add1 L) '(1))) pyramids)))

; stream-filter
(define odd-naturals
  (stream-filter odd? naturals))

(define naturals2
  (stream-cons 0 (stream-map add1 naturals2)))
; (stream-take naturals2 3)

; stream-zip-with - vezi lab
