-- Run with `spago run -m Practice.Promise.Main`
module Practice.Promise.Main where

import Prelude
import Control.Promise as Promise
import Effect (Effect)
import Effect.Aff (launchAff_, Aff)
import Effect.Class.Console (log)

foreign import fetch_ :: Int -> Effect (Promise.Promise String)

fetch :: Int -> Aff String
fetch = Promise.toAffE <<< fetch_

main :: Effect Unit
main = do
  launchAff_ $ do
    fetch 1 >>= log -- Content of 1
    fetch 2 >>= log -- Content of 2
