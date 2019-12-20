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

foreign import simpleObject :: { x :: Int, y :: String, z :: Boolean }

-- Throws `new Error("Failed pattern match at Data.Maybe (...): ");` in runtime.
foreign import nullableObject :: { x :: Maybe Int }

foreign import nullableObject_ :: Json

eitherNullableObject :: Either String { x :: Maybe Int }
eitherNullableObject = decodeJson nullableObject_

-- `encodeSimple (unsafeToForeign { x: Nothing })` outputs `{"x":{}}`
foreign import encodeSimple :: Foreign -> String
foreign import encodeNullable_ :: Json -> String

encodeNullable :: forall a. EncodeJson a => a -> String
encodeNullable = encodeNullable_ <<< encodeJson

type MyMap = Map.Map (Set.Set String) Int

foreign import getKeys_ :: Json -> Array String

getKeys :: MyMap -> Array String
getKeys = getKeys_ <<< encodeJson
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
