-- Run with `spago run -m Practice.ArrowFunction.Main`
module Practice.ArrowFunction.Main where

import Prelude
import Data.Function.Uncurried (Fn2, runFn2)
import Effect (Effect)
import Effect.Class.Console (logShow)
import Effect.Uncurried (EffectFn2, runEffectFn2)

foreign import equal_ :: Fn2 Int Int Boolean
equal' :: Int -> Int -> Boolean
equal' = runFn2 equal_

foreign import equalEffect_ :: EffectFn2 Int Int Boolean
equalEffect' :: Int -> Int -> Effect Boolean
equalEffect' = runEffectFn2 equalEffect_

foreign import equal :: Int -> Int -> Boolean

foreign import equalEffect :: Int -> Int -> Effect Boolean

main :: Effect Unit
main = do
  logShow $ equal' 1 1 -- true
  logShow =<< equalEffect' 1 1 -- true
  logShow $ equal 1 1 -- true
  logShow =<< equalEffect 1 1 -- true

