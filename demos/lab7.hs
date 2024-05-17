
import Data.List

------------------------------------------- LIST COMPREHENSIONS ----------------------------------------------
-- for generating new lists based on existing lists
-- simulates functionals

l1 = [x * x |x <- [1, 2, 4, 5, 7]]
l2 = [x * x |x <- [1, 2, 4, 5, 7], odd x]
l3 = [(x, y) |x <- [1, 2, 4, 5, 7], odd x, y <- [3, 4, 5]]

-- allows scopes
l4 = [(x, y, z) |x <- [1, 2, 4, 5, 7], odd x, y <- [3, 4, 5], let z = x + y, even z]

-- also on infitite lists
l5 = [x * x |x <- [1, 2 ..]]

-- nested list comprehensions
-- e.g. : keep even elements from list of lists
xxs = [[1,3,5,2,3,1,2,4,5],[1,2,3,4,5,6,7,8,9],[1,2,4,2,1,6,3,1,3,2,3,6]] -- -> [[2, 4..], 2, 4, ...]
l6 = [ [ x | x <- xs, even x] | xs <- xxs]
l7 = [ x | xs <- xxs, x <- xs, even x]

------------------------------------------- INFINITE LISTS ---------------------------------------------------
naturals1 = [0..]

naturals2 = iter 0
    where iter x = x : iter (x + 1)

-- Iterate
-- e.g. naturals
naturals3 = iterate (+1) 0
-- e.g. powers of 2
powsOfTwo = iterate (*2) 1

-- Repeat
ones = repeat 1

-- Cycle
cycleList = cycle [1, 2, 4]

-- Intersperse
-- 1, 2, 1, 2,...
onesTwos = intersperse 2 ones

-- ZipWith
list1 = zipWith (+) [1, 2..] [2, 4]

-- zipWith3
list2 = zipWith3 (\x y z -> x + y + z) [1, 2..] [2, 4 ..] [1, 3 ..]

-- Filter
evens = filter even [0 ..]

-- Map
squares = map (^2) [0 ..]

------------------------------------------ POINT-FREE PROGRAMMING --------------------------------------------
sum' :: [Integer] -> Integer
sum' xs = foldl (+) 0 xs

sum'' :: [Integer] -> Integer
sum'' = foldl (+) 0

-- exampleMap :: [Integer] -> [Integer]
-- exampleMap = 

-- flip --------------------------------------------------------------
-- :t flip -> inverseaza agrumentele functiei primite ca parametru
-- ex: 

flipMap = flip map [1, 2, 3]

-- FUNCTION APPLICATION ($) ------------------------------------------

{- 
    -- implicit left associative
    f a b c = (((f a) b) c)

    ($) :: (a -> b) -> a -> b
    f $ expr = f expr

-}

-- sqrt (4 + 3 + 2)
x1 = sqrt 4 + 3 + 2
x2 = sqrt (4 + 3 + 2)
x3 = sqrt $ 4 + 3 + 2


-- more complex expressions
-- wrongSum = sum filter (> 10) map (*2) [2..10]
sumList = sum (filter (> 10) (map (*2) [2..10]))
sumList' = sum $ filter (> 10) $ map (*2) [2..10]

-- FUNCTION COMPOSITION (.) ------------------------------------------
{-
    f . g (x) = f(g(x))

    (.) :: (b -> c) -> (a -> b) -> a -> c
    f . g = \x -> f (g x)

-}

-- \x -> 2 * x + 1 -> (+1) ((*2) x) -> (+1) . (*2)
compositionEx1 = map (\x -> (+ 1) ((* 2) x)) [1, 2, 3]
compositionEx2 = map ((+ 1) . (* 2)) [1, 2, 3]

compositionEx3 = ((+ 1) (sum (tail [5, 6, 7, 8])))
compositionEx4 = ((+1) . sum . tail) [5, 6, 7, 8]
compositionEx5 = (+ 1) $ sum $ tail [5, 6, 7, 8]

-- 2 * x + 1
f = (+ 1)
g = (* 2)
g1 x = f (g x)
g2 x = f $ g x
-- g3 x = f . g x
g4 x = (f . g) x
g5 x = f . g $ x
