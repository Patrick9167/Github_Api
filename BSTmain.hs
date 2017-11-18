module BSTmain where

import BST

myTree = ctree [8, 4, 2, 7, 9, 11, 10, 12]
mylca n m = lca myTree n m

mydag = [Elem 0[1,2], Elem 1[5,4], Elem 2[5,3],
           Elem 3[4], Elem 4[], Elem 5[]]
daglca n m = lcaDAG mydag n m 0
