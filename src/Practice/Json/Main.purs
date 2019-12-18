-- Run with `spago run -m Practice.Json.Main`
module Practice.Json.Main where

import Prelude
import Data.Argonaut.Core (Json)
import Data.Argonaut.Encode (class EncodeJson, encodeJson)
import Data.Maybe (Maybe(..))
import Effect (Effect)
import Effect.Class.Console (log)

foreign import encode_ :: Json -> String

encode :: forall a. EncodeJson a => a -> String
encode = encode_ <<< encodeJson

type XY = { x :: Int, y :: Maybe Int }

main :: Effect Unit
main = do
  log $ encode ({ x: 1, y: Nothing } :: XY) -- {"y":null,"x":1}
  log $ encode ({ x: 1, y: Just 11 } :: XY) -- {"y":11,"x":1}

