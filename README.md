# PureScript FFI Best Practices

These are some patterns I use from day to day when writing PureScript FFI code, I call it best practices, but don't take it too seriously, use your own judgement. To better understand why a `foreign import` works or doesn't work, the best way is looking into the generated JavaScript code in the `output` folder directly.

## Best practices

Code examples are there, but documentation are incomplete yet.

1. [Use arrow function to curry](src/Practice/ArrowFunction)
2. [No type class constraint in foreign import](src/Practice/NoTypeClass)
3. [Use Json to interoperate record](src/Practice/Json)
4. [Use Promise for async code](src/Practice/Promise)

## Run a practice

You can run each practice separately

```
spago build
spago run -m Practice.ArrowFunction.Main
spago run -m Practice.Promise.Main
```

## A Literal PureScript Setup

All `src/**/Main.purs` are extracted from `src/**/README.md` by sed.

Run `find src/**/README.md | entr -s ./codegen.sh` to regenerate Main.purs on README changes.
