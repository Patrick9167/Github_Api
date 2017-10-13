module BSTtest where

import Test.Hspec

import BSTmain
main :: IO ()
main = hspec $ do

describe "LCA" $ do
  it "returns the lowest common ancestor of nodes 2 and 7; should be 4" $
    myLCA 2 7 `shouldBe` 4

  it "returns the lowest common ancestor of nodes 5 and 7; should be 7" $
    myLCA 5 7 `shouldBe` 7


  it "returns the lowest common ancestor of nodes 2 and 12; should fail as 12 is not a node in the tree" $
    myLCA 2 12 `shouldBe` error "Node not in tree"
