module Unist.Data exposing (..)

import Json.Encode as JE exposing (Value)


type alias Data =
    Value


empty : Value
empty =
    JE.null
