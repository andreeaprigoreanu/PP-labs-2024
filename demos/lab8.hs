------------------------------------- DATA TYPES ---------------------------------------

------------------------------------ TYPE SYNONIMS -------------------------------------

-- type PhoneRecords = [(String, String)]

type Name = String
type PhoneNumber = String
type PhoneRecords = [(Name, PhoneNumber)]

phoneBook :: PhoneRecords
phoneBook = [("mary", "2345"), ("john", "2346")]

inPhoneBook :: Name -> PhoneNumber -> PhoneRecords -> Bool
inPhoneBook name pnumber pbook = elem (name,pnumber) pbook

type MyNonEmptyList a = [a]

myList :: MyNonEmptyList Int
myList = [1, 2, 4]

-- inPhoneBook "betty" "555-2938" phoneBook

------------------------------------- DATA ---------------------------------------

-- ENUMERATED---------------------------------------------------------------------

data Color = Black | White | Red | Blue | Yellow deriving Show

nonColor :: Color -> Bool
nonColor Black = True
nonColor White = True
nonColor _ = False

------------------------------

data Point = Point Float Float deriving Show

data Shape = Circle Point Float
            | Rectangle Point Point deriving Show

point1 = Point 1 2
point2 = Point 2 3
circle = Circle point1 2
rectangle = Rectangle point1 point2

surface :: Shape -> Float
surface (Circle _ r) = pi * r ^ 2
surface (Rectangle (Point x1 y1) (Point x2 y2)) = abs(x2 - x1) * abs(y2 - y1)

-- surface2 :: Circle -> Float

-- surface $ Circle (Point 10 20) 10
-- surface $ Rectangle (Point 0 0) (Point 100 100)

-- (?) surface :: Circle -> Float

-- RECORD SYNTAX (1) -------------------------------------------------------------

data Person = Person String String Int String deriving (Show)

somebody = Person "Buddy" "Finklestein" 43 "526-2928"

firstName :: Person -> String
firstName (Person firstname _ _ _) = firstname
  
lastName :: Person -> String
lastName (Person _ lastname _ _) = lastname
  
age :: Person -> Int
age (Person _ _ age _ ) = age
  
phoneNumber :: Person -> String
phoneNumber (Person _ _ _ number) = number


-- RECORD SYNTAX (2) -------------------------------------------------------------

data Person2 = Person2 { firstName2 :: String
                        , lastName2 :: String
                        , age2 :: Int
                        , phoneNumber2 :: String
                        } deriving (Show)

anotherGuy = Person2 "Guy" "Smith" 21 "732658930"

-- :t firstName2

-- firstName2 anotherGuy
-- lastName2 anotherGuy

someGuy = Person2 {firstName2 = "Buddy", 
                    lastName2 =  "Finklestein",
                    age2 = 43,
                    phoneNumber2 = "526-2928"}

changePhone :: Person2 -> String -> Person2
changePhone p new_phone = p {phoneNumber2 = new_phone}

-- changePhone someGuy "0475903"


------------------------------------- parametrized -------------------------------------

-- data Maybe a = Nothing | Just a

myHead :: [a] -> Maybe a
myHead [] = Nothing
myHead (x:xs) = Just x

-- x = myHead ['a', 'b', 'c']
-- y = myHead [True, False]
-- z = myHead [1, 2, 3]

myTail :: [a] -> Maybe [a]
myTail [] = Nothing
myTail (x:xs) = Just xs

------------------------------------- recursive ---------------------------------------
-- lista vida + cons 
data List a = EmptyList | Cons a (List a) deriving Show

l1 = Cons 5 (Cons 6 EmptyList)

{-
  listToTList transformă o listă Haskell intr-o List
-}
listToTList :: [a] -> List a
listToTList [] = EmptyList
listToTList (x : xs) = Cons x (listToTList xs)


---------------------------------------- newtype ---------------------------------------
-- un singur constructor - are un singur parametru
-- newtype Meters = MakeMeters Double deriving Show

newtype Natural = Natural {myNatural :: Integer} deriving Show

newtype Meter a = MakeMeter a deriving Show

newtype Meters = MakeMeters {getMeters :: Double} deriving Show
newtype Feet = MakeFeet {getFeet :: Double} deriving Show

-- Function to convert meters to feet
metersToFeet :: Meters -> Feet
metersToFeet (MakeMeters m) = MakeFeet (m * 3.28084)

--------------------------------------- alias (@) --------------------------------------
data Vector = MakeVector Float Float Float deriving Show

normalizeVector :: Vector -> Vector
normalizeVector vec@(MakeVector x y z) = MakeVector (x * invLen) (y * invLen) (z * invLen)
    where
        invLen = 1 / (lengthVector vec)
        lengthVector (MakeVector x y z) = sqrt (x ^ 2 + y ^ 2 + z ^ 2)

----------------------------------- BINARY SEARCH TREE --------------------------------

-- data BSTree a = EmptyTree | Node a (BSTree a) (BSTree a) deriving (Show)

-- singleton :: a -> BSTree a  
-- singleton x = Node x EmptyTree EmptyTree  

-- t1 = Node 5 (Node 3 (singleton 1) (singleton 4)) (Node 7 (singleton 6) (singleton 8))
-- t2 = Node 5 (singleton 3) (singleton 6)

-- -- inserts a node in Tree
-- treeInsert :: (Ord a) => a -> BSTree a -> BSTree a  
-- treeInsert x EmptyTree = singleton x  
-- treeInsert x (Node a left right)   
--     | x == a = Node x left right  
--     | x < a  = Node a (treeInsert x left) right  
--     | x > a  = Node a left (treeInsert x right)

------------------------------------- NESTED LISTS -------------------------------------

data NestedList a = Elem a | List [NestedList a]

instance Show a => Show (NestedList a) where
    show (Elem x) = show x
    show (List xs) = show xs

nl1 = List [Elem 1, List [List [Elem 2, Elem 3], Elem 4] , Elem 5]

deepEqual :: Eq a => NestedList a -> NestedList a -> Bool
deepEqual (Elem x) (Elem y) = x == y
deepEqual (List a) (List b) = and $ zipWith deepEqual a b
deepEqual _ _               = False

{-
    Hint: concat :: [[a]] -> [a]
    ex: concat [[1, 2], [3, 4]] = [1, 2, 3, 4]
-}
flatten (Elem x)    = [x]
flatten (List xs)   = concat $ map flatten xs
                    -- = concatMap flatten xs
