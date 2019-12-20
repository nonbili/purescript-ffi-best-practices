# No type class constraint in foreign import

**Best practice**: Do not add type class contraint to foreign imported functions.

```purescript
-- Run with `spago run -m Practice.NoTypeClass.Main`
module Practice.NoTypeClass.Main where

import Prelude
import Effect (Effect)
import Effect.Console (logShow)
```

Let's look at two equal functions, one with the `Eq` constraint, the other without.

```purescript
foreign import equal :: forall a. a -> a -> Boolean

foreign import equalClass :: forall a. Eq a => a -> a -> Boolean
```

If I open `Main.js`, I will find the implementation of `equalClass` has one more argument than `equal`. If I print this argument, I will see `Eq { eq: [Function] }`. That's the `Eq` type class represented as an object in JavaScript. Actullay, each type class constraint will add one extra argument to the foreign function. If I add or remove type classes constraint carelessly, it will break the program in runtime.

However, with `equal`, `purs` won't be able to help us checking there is an `Eq a` instance. Which may or may not be what we want. The solution is adding a separate function, and defining the constraint in this function.

```
eqEqual :: forall a. Eq a => a -> a -> Boolean
eqEqual = equal
```

A case to violate this rule is to use the type class functions from the JavaScript side. For example, if I use `===` to check the equality of two PureScript records, it would fail.

```purescript
foreign import equalRecord :: forall a. Eq a => a -> a -> Boolean
```

```purescript
data AB = A | B

main :: Effect Unit
main = do
  logShow $ equal A B -- false

  -- logShow $ eqEqual A B -- compile error

  logShow $ equal 1 1 -- true

  logShow $ equalClass 1 1 -- true

  logShow $ equalClass { x: 1 } { x: 1 } -- false!

  logShow $ equalRecord { x: 1 } { x: 1 } -- true
```

## Summary

Each type class constraint adds an extra argument to the foreign function. To avoid accidental runtime error, do not use type class constraint in foreign imported functions. The only case to violate this is when using type class function in JavaScript code.
