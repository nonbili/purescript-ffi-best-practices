{ name =
    "purescript-ffi-best-practices"
, dependencies =
    [ "aff"
    , "aff-promise"
    , "argonaut-codecs"
    , "console"
    , "effect"
    , "psci-support"
    ]
, packages =
    ./packages.dhall
, sources =
    [ "src/**/*.purs" ]
}
