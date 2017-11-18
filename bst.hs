module BST where
import Data.List --List library

data Tree a = Nil | Node (Tree a) a (Tree a)--tree data type
 deriving (Show, Eq)

{- BASIC Information -}
empty :: (Ord a) => Tree a -> Bool
empty Nil = True
empty  _  = False

contains :: (Ord a) => (Tree a) -> a -> Bool
contains Nil _ = False
contains (Node t1 v t2) x
 | x == v = True
 | x  < v = contains t1 x
 | x  > v = contains t2 x

{- BASIC Manipulation -}
insertN :: (Ord a) => Tree a -> a -> Tree a
insertN Nil x = Node Nil x Nil
insertN (Node t1 v t2) x
 | v == x = Node t1 v t2
 | v  < x = Node t1 v (insertN t2 x)
 | v  > x = Node (insertN t1 x) v t2

deleteN :: (Ord a) => Tree a -> a -> Tree a
deleteN Nil _ = Nil
deleteN (Node t1 v t2) x
 | contains (Node t1 v t2) x == False = error "Node not in tree"
 | x  < v = Node (deleteN t1 x) v t2
 | x  > v = Node t1 v (deleteN t2 x)

get_max :: (Ord a) => Tree a -> a
get_max Nil = error "No tree"
get_max (Node t1 v t2)
 | t2 /= Nil = get_max t2
 | otherwise = v

ctree :: (Ord a) => [a] -> Tree a
ctree [] = Nil
ctree (h:t) = ctree2 (Node Nil h Nil) t
 where
 ctree2 tree [] = tree
 ctree2 tree (h:t) = ctree2 (insertN tree h) t

lca :: (Ord a) => Tree a -> a -> a -> a
lca Nil _ _ = error "Null tree"
lca (Node t1 v t2) p q
 | contains (Node t1 v t2) p == False || contains (Node t1 v t2) q == False = error "Node not in tree"
 | v > p && v < q = v
 | v > p && v > q = (lca t1 p q)
 | v < p && v < q = (lca t2 p q)
 | otherwise = v


data Dnode = Elem Int [Int]
  deriving (Show, Eq)

type DAG = [Dnode]



path :: DAG -> Int -> Int -> [[Int]]
path d x y
 | x == y =[[x]]
 | otherwise = case find (nodeMatch y) d of
   Just(Elem _ []) -> [[y]]
   Just(Elem _ a) -> map (y:)
                    $ filter(\a  -> last a ==x)
                    $ concatMap (path d x) a
   Nothing -> []

nodeMatch :: Int -> Dnode -> Bool
nodeMatch v (Elem x y) = x == v

lcaDAG :: DAG -> Int -> Int -> Int-> [Int]
lcaDAG d n1 n2 root
 | n1 == n2 = [n1]
 | otherwise = findMatch (path d n1 root) (path d n2 root)

findMatch :: [[Int]] -> [[Int]] -> [Int]
findMatch [] _ = []
findMatch (h:t) p
  = case comp (reverse h) p of
   Just x -> (x:)
               $ findMatch t p
   Nothing -> findMatch t p

comp :: [Int] -> [[Int]] -> Maybe Int
comp _ [] = Nothing
comp (h:t) (c:p)
  = case h `elem` c of
   True -> Just h
   False -> comp (h:t) p
