module BST where
import qualified Data.List --List library

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
insert :: (Ord a) => Tree a -> a -> Tree a
insert Nil x = Node Nil x Nil
insert (Node t1 v t2) x
 | v == x = Node t1 v t2
 | v  < x = Node t1 v (insert t2 x)
 | v  > x = Node (insert t1 x) v t2

delete :: (Ord a) => Tree a -> a -> Tree a
delete Nil _ = Nil
delete (Node t1 v t2) x
 | contains (Node t1 v t2) x == False = error "Node not in tree"
 | x  < v = Node (delete t1 x) v t2
 | x  > v = Node t1 v (delete t2 x)

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
 ctree2 tree (h:t) = ctree2 (insert tree h) t

lca :: (Ord a) => Tree a -> a -> a -> a
lca Nil _ _ = error "Null tree"
lca (Node t1 v t2) p q
 | contains (Node t1 v t2) p == False || contains (Node t1 v t2) q == False = error "Node not in tree"
 | v > p && v < q = v
 | v > p && v > q = (lca t1 p q)
 | v < p && v < q = (lca t2 p q)
 | otherwise = v
