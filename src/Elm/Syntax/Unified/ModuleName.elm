module Elm.Syntax.Unified.ModuleName exposing (..)


type alias ModuleName =
    List String


show : ModuleName -> String
show =
    toPascalCase


toPascalCase : ModuleName -> String
toPascalCase moduleName =
    String.join "." moduleName
