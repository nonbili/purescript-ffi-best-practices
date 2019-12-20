# Use Promise for async code

**Best practice**: Convert Promise to Aff when dealing with async foreign code.

The `Promise` in this document means the `data Promise` defined in [purescript-aff-promise](https://pursuit.purescript.org/packages/purescript-aff-promise).

```purescript
-- Run with `spago run -m Practice.Promise.Main`
module Practice.Promise.Main where

import Prelude
import Control.Promise as Promise
import Data.Either (Either(..))
import Data.Foldable (traverse_)
import Effect (Effect)
import Effect.Aff (Aff)
import Effect.Aff as Aff
import Effect.Class.Console (log)
```

Handle JavaScript promise or async/await the same way in PureScript.

```purescript
foreign import fetchPromise_ :: Int -> Effect (Promise.Promise String)

fetchPromise :: Int -> Aff String
fetchPromise = Promise.toAffE <<< fetchPromise_

foreign import fetchAsync_ :: Int -> Effect (Promise.Promise String)

fetchAsync :: Int -> Aff String
fetchAsync = Promise.toAffE <<< fetchAsync_
```

Use `Aff.attempt` to handle promise rejection.

```purescript
main :: Effect Unit
main = do
  Aff.launchAff_ $ do
    fetchPromise 1 >>= log -- Promise content of 1
    fetchAsync 2 >>= log -- Promise content of 2

    Aff.attempt (fetchAsync 3) >>= traverse_ \res ->
      log res -- Promise content of 3

    Aff.attempt (fetchPromise 0) >>= case _ of
      Left err -> log $ Aff.message err -- Invalid id
      Right res -> log res

    Aff.attempt (fetchAsync (-1)) >>= traverse_ \res ->
      log res -- no output
```

## Summary

Promise is the standard way to handle async in JavaScript, Aff is the standard way to handle async in PureScript. They work nicely together.
