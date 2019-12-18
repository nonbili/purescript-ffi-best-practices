# Use arrow function instead of mkFn* and mkEffectFn*

**Best practice**: Use arrow function to curry manually, so that no need to write intermediary functions.

```purescript
-- Run with `spago run -m Practice.ArrowFunction.Main`
module Practice.ArrowFunction.Main where

import Prelude
import Data.Function.Uncurried (Fn2, runFn2)
import Effect (Effect)
import Effect.Class.Console (logShow)

foreign import equal :: Int -> Int -> Boolean

foreign import equal_ :: Fn2 Int Int Boolean
equal' :: Int -> Int -> Boolean
equal' = runFn2 equal_

```

```purescript

main :: Effect Unit
main = do
  logShow $ equal 1 1 -- true
  logShow $ equal' 1 1 -- true

```
