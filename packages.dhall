let upstream =
	  https://github.com/purescript/package-sets/releases/download/psc-0.13.5-20191215/packages.dhall sha256:fdc5d54cd54213000100fbc13c90dce01668a73fe528d8662430558df3411bee

let overrides = {=}

let additions = {=}

in  upstream ⫽ overrides ⫽ additions