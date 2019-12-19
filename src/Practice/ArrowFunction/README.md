# Use arrow functions to curry manually

**Best practice**: Make sure each arrow function takes only one argument.

```purescript
-- Run with `spago run -m Practice.ArrowFunction.Main`
module Practice.ArrowFunction.Main where

import Prelude
import Data.Function.Uncurried (Fn2, runFn2)
import Effect (Effect)
import Effect.Class.Console (logShow)
import Effect.Uncurried (EffectFn2, runEffectFn2)

```

When I was learning PureScript, I saw FFI code like this a lot in tutorials or libraries. I thought this was the only way to write FFI code, and it feels boring and repetitive.

```purescript
foreign import equal_ :: Fn2 Int Int Boolean
equal' :: Int -> Int -> Boolean
equal' = runFn2 equal_

foreign import equalEffect_ :: EffectFn2 Int Int Boolean
equalEffect' :: Int -> Int -> Effect Boolean
equalEffect' = runEffectFn2 equalEffect_

```

Later, I found out what `runFn*` and [`runEffectFn*`](https://github.com/purescript/purescript-effect/blob/master/src/Effect/Uncurried.js) do is helping me currying. And later, I found that [language-javascript](https://github.com/erikd/language-javascript) supported arrow function. So now I don't need `runFn*` and `runEffectFn*` anymore. FFI code becomes much easier to read and write. Compare the above 6 lines with the following 2 lines.

```purescript
foreign import equal :: Int -> Int -> Boolean

foreign import equalEffect :: Int -> Int -> Effect Boolean
```

Notice the extra `() =>` in the implementation of `exports.equalEffect = a => b => () => a === b;`, it's related to how PureScript Effect is run in a do block in JavaScript.

```purescript

main :: Effect Unit
main = do
  logShow $ equal' 1 1 -- true
  logShow =<< equalEffect' 1 1 -- true
  logShow $ equal 1 1 -- true
  logShow =<< equalEffect 1 1 -- true

```

A case to use `runFn*` and `runEffectFn*` is when writing PureScript bindings to all functions of a third-party JavaScript module. As I don't control the arguments of those JavaScript functions, and I don't want to manage them in both JavaScript and PureScript FFI code, I choose to manage them only in PureScript code. See [purescript-node-fs-extra](https://github.com/nonbili/purescript-node-fs-extra/blob/master/src/Node/FS/Extra.purs) for an example.

## Summary

`runFn*` and `runEffectFn*` are not needed in most cases. Use arrow functions to curry manually, the PureScript part of FFI will match beautifully with the JavaScript part.
