
-- Run with `spago run -m Practice.NoTypeClass.Main`
module Practice.NoTypeClass.Main where

import Prelude
import Effect (Effect)
import Effect.Console (logShow)


foreign import equal :: forall a. a -> a -> Boolean

foreign import equalClass :: forall a. Eq a => a -> a -> Boolean


eqEqual :: forall a. Eq a => a -> a -> Boolean
eqEqual = equal


foreign import equalRecord :: forall a. Eq a => a -> a -> Boolean


data AB = A | B

main :: Effect Unit
main = do
  logShow $ equal A B -- false

  -- logShow $ eqEqual A B -- compile error

  logShow $ equal 1 1 -- true

  logShow $ equalClass 1 1 -- true

  logShow $ equalClass { x: 1 } { x: 1 } -- false!

  logShow $ equalRecord { x: 1 } { x: 1 } -- true

