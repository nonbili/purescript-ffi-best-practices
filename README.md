# PureScript FFI Best Practices

These are some patterns I use from day to day when writing PureScript FFI code, I call them best practices, but no need to take them too seriously, use your own judgement. To understand why a `foreign import` works or doesn't work, the best way is looking into the generated JavaScript code in the `output` folder directly.

## Best practices

Code examples are there, but documentation are incomplete yet.

1. [Use arrow functions to curry manually](src/Practice/ArrowFunction)
2. [No type class constraint in foreign import](src/Practice/NoTypeClass)
3. [Use Json to interoperate](src/Practice/Json)
4. [Use Promise for async code](src/Practice/Promise)

## How to use this repo

```
src
└── Practice
    ├── ArrowFunction
    │   ├── Main.js
    │   ├── Main.purs
    │   └── README.md
```

Each practice lives in its own folder inside `src/Practice`, each folder contains three files. `Main.purs` is auto-extracted from `README.md`, so it's recommended to open `Main.js` and `README.md` side by side.

You can also run each practice separately

```
spago build
spago run -m Practice.ArrowFunction.Main
spago run -m Practice.Promise.Main
```

## A Literal PureScript Setup

All `src/**/Main.purs` are extracted from `src/**/README.md` by sed.

Run `find src/**/README.md | entr -s ./codegen.sh` to regenerate Main.purs on README changes.
