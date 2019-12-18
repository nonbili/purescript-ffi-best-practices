{ name =
    "purescript-ffi-best-practices"
, dependencies =
    [ "aff", "aff-promise", "effect", "console", "psci-support" ]
, packages =
    ./packages.dhall
, sources =
    [ "src/**/*.purs" ]
}
