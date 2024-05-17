-- Haskell: Intro

-- Functii
plus x y = x + y
plus' = \x y -> x + y
plus'' x = \y -> x + y
plus''' = \x -> \y -> x + y

-- fctie anonima: \ param1 param2... -> corp

-- Operatori ca functii
-- x = 1 + 2
-- sectiuni
-- _ + _
-- (2 +) -- \x -> (2 + x)
-- (+ 2) -- \x -> (x + 2)

-- (2 -) -- \x -> (2 - x)
-- (- 2) -- -2

-- (2 /) 3 -- 2 /3
-- (/ 2) 3 -- 3 / 2

-- Functii ca operatori
-- ``
-- max 2 3
-- 2 `max` 3

-- Tipuri elementare
x = 5
chr = 'a'
str = "hello"

-- Int vs Integer
-- 2^10000000

-- Int vs Integer
-- :t - operator pentru a verifica tipul unei expresii

----------------------------------------------------------
-- Liste
-- []
-- cons -> :

l1 = 1:[] -- cons 1 '()
l2 = 1:2:3:[]
l3 = [1, 2, 3]
l4 = [1, 4 .. 9]
l5 = [1, 3 ..]

-- !Stringurile sunt liste de Char

-- head, tail, last, init

-- null

-- ++, reverse, elem, takeWhile, dropWhile

-- listele sunt omogene
l6 = [1, 2, 3]
l7 = [[1], [2], [3]]

---------------------------------------------------------
-- Tuples
pair1 = (1, 3)
pair2 = (1, 'a')
-- fst, snd

tuple1 = (1 , 4, "hello", 5)

-- Functionale
-- map, filter, foldl, foldr
list1 = map (+ 2) [1, 2, 3, 4]
list2 = filter even [1, 2, 3, 4]

list3 = foldl (\acc x -> x:acc) [] [1, 2, 3, 4]
list4 = foldr (\x acc -> x:acc) [] [1, 2, 3, 4]

-- zip
list5 = zip [1, 2, 3] [4, 5, 6]

-- zipWith
list6 = zipWith (+) [1, 2, 3] [4, 5, 6]
myzip = zipWith (,)

-- tipuri functionale

-- Sintaxa functii

-- 0 -- cu 'if .. then .. else ..'
fact_else x = if x == 0 then 1 else x * fact_else (x - 1)

-- 1 ------------------------------------------- PATTERN MATCHING -------------------------------------------

-- factorial :: (Eq a, Num a) => a -> a
factorial 0 = 1
factorial n = n * factorial (n - 1)

length' :: (Num b) => [a] -> b
length' [] = 0
length' (_:xs) = 1 + length' xs

first :: (a, b, c) -> a
first (x, _, _) = x

-- tell :: (Show a) => [a] -> String

 
-- 2 ------------------------------------------------ GUARDS ------------------------------------------------
-- like Racket case

-- case expr 

factorial_guards :: (Num a, Eq a) => a -> a
factorial_guards n
    | n == 0 = 1
    | otherwise = n * factorial_guards (n - 1)


length_guards :: (Num b) => [a] -> b
length_guards l
    | null l = 0 -- l == []
    | otherwise = 1 + length_guards (tail l)

-- 3 ------------------------------------------------ CASE OF ------------------------------------------------

-- case expression of pattern -> result  
--                    pattern -> result
--                    pattern -> result  
--                    ...  

factorial_case :: (Num a, Eq a) => a -> a
factorial_case n = case n of
    0 -> 1
    _ -> n * factorial_case (n - 1)

length_case :: (Num b) => [a] -> b
length_case l = case l of
    []       -> 0
    _ -> 1 + length_case (tail l)


-- --------------------------------------------------- LET ---------------------------------------------------
-- let <bindings> in <expression>
-- letrec

myDef = let
            x = 3 + 2
            y = z + 1
            z = x
            s1 = "hello"
            s2 = "bye"
        in
            (x, y, z, s1 ++ s2)


-- -------------------------------------------------- WHERE --------------------------------------------------
-- same as let
myDefWhere = (x, y, z, s1 ++ s2)
    where 
        x = 3 + 2
        y = z + 1
        z = x
        s1 = "hello"
        s2 = "bye"

exFunc L = length' L
            where
                length' [] = 0
                length' (_:xs) = 1 + length' xs