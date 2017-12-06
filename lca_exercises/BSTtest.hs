module BSTtest where

import Test.Hspec

import BSTmain
main :: IO ()
main = hspec $ do

describe "test" $ do
  it "returns the lowest common ancestor of nodes 4 and 9; should be 8" $
    mylca 4 9 `shouldBe` 8

  it "returns the lowest common ancestor of nodes 9 and 4; should be 8" $
    mylca 9 4 `shouldBe` 8

  it "returns the lowest common ancestor of nodes 4 and 4; should be 4" $
    mylca 4 4 `shouldBe` 4

  it "returns the lowest common ancestor of nodes 10 and 2; should be 8" $
    mylca 10 2 `shouldBe` 8

  it "returns the lowest common ancestor of nodes 7 and 12; should be 8" $
    mylca 7 12 `shouldBe` 8

  it "returns the lowest common ancestor of nodes 9 and 11; should be 9" $
    mylca 9 11 `shouldBe` 9

  it "returns the lowest common ancestor of nodes 11 and 9; should be 9" $
    mylca 11 9 `shouldBe` 9

  it "returns the lowest common ancestor of nodes 2 and 4; should be 4" $
    mylca 2 4 `shouldBe` 4

  it "returns the lowest common ancestor of nodes 4 and 2; should be 4" $
    mylca 4 2 `shouldBe` 4

  it "ERROR test: two nodes not in tree" $
    mylca 6 13 `shouldBe` error "Node not in tree"

  it "ERROR test: first node not in tree" $
    mylca 3 7 `shouldBe` error "Node not in tree"

  it "ERROR test: second node not tree" $
    mylca 7 3 `shouldBe` error "Node not in tree"
