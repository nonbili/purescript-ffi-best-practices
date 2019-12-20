# Use Json to interoperate

**Best practice**: Use Json to pass a value back and forth between PureScript and JavaScript.

The `Json` in this document means the `data Json` defined in [purescript-argonaut-core](https://pursuit.purescript.org/packages/purescript-argonaut-core).

```purescript
-- Run with `spago run -m Practice.Json.Main`
module Practice.Json.Main where

import Prelude
import Data.Argonaut.Core (Json)
import Data.Argonaut.Decode (decodeJson)
import Data.Argonaut.Encode (class EncodeJson, encodeJson)
import Data.Either (Either)
import Data.Map as Map
import Data.Maybe (Maybe(..))
import Data.Set as Set
import Data.Tuple (Tuple(..))
import Effect (Effect)
import Effect.Class.Console (log, logShow)
import Foreign (Foreign, unsafeToForeign)

```

## Pass a value from JavaScript to PureScript

For primitive JavaScript types like `number`, `string` and `boolean`, they map to PureScript record fields directly.

```purescript
foreign import simpleObject :: { x :: Int, y :: String, z :: Boolean }

```

But if a field is nullable, it doesn't work.

```purescript
-- Throws `new Error("Failed pattern match at Data.Maybe (...): ");` in runtime.
foreign import nullableObject :: { x :: Maybe Int }

```

Use Json to fix it.

```purescript
foreign import nullableObject_ :: Json

eitherNullableObject :: Either String { x :: Maybe Int }
eitherNullableObject = decodeJson nullableObject_

```

## Pass a value from PureScript to JavaScript

The other way around is similar, use `Maybe a` as a nullable field in JavaScript is problematic.

```purescript
-- `encodeSimple (unsafeToForeign { x: Nothing })` outputs `{"x":{}}`
foreign import encodeSimple :: Foreign -> String
```

```purescript
foreign import encodeNullable_ :: Json -> String

encodeNullable :: forall a. EncodeJson a => a -> String
encodeNullable = encodeNullable_ <<< encodeJson

```

Another benefit of using `Json` is there are built-in `EncodeJson` and `DecodeJson` instances for data structures like `Map` and `Set`. For example, if I want to do some computation on a huge Map, it's possibly faster to do it in JavaScript.

```purescript
type MyMap = Map.Map (Set.Set String) Int

foreign import getKeys_ :: Json -> Array String

getKeys :: MyMap -> Array String
getKeys = getKeys_ <<< encodeJson
```

```purescript
type XY = { x :: Int, y :: Maybe Int }

myMap :: MyMap
myMap = Map.fromFoldable
  [ Tuple (Set.fromFoldable ["x", "y"]) 12
  , Tuple (Set.fromFoldable ["y", "z"]) 34
  ]

main :: Effect Unit
main = do
  logShow simpleObject
  -- logShow nullableObject -- throws
  logShow eitherNullableObject -- (Right { x: Nothing })

  log $ encodeSimple (unsafeToForeign { x: Nothing }) -- {"x":{}}
  log $ encodeSimple (unsafeToForeign { x: Just 1 })  -- {"x":{"value0":1}}

  log $ encodeNullable ({ x: 1, y: Nothing } :: XY) -- {"y":null,"x":1}
  log $ encodeNullable ({ x: 1, y: Just 11 } :: XY) -- {"y":11,"x":1}

  logShow $ getKeys myMap -- ["x","y","z"]
```

## Summary

When passing values between PureScript and JavaScript, use Json as a bridge to avoid runtime errors or undesired results. The built-in `DecodeJson` and `EncodeJson` instances are nice.
