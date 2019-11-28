module Unist.Fuzzer exposing (..)

import Elm.Syntax.Range exposing (Location)
import Fuzz exposing (..)
import Unist.Point exposing (Point)
import Unist.Position exposing (Position)


locationFuzzer : Fuzzer Location
locationFuzzer =
    map2 Location int int


pointFuzzer : Fuzzer Point
pointFuzzer =
    map3 Point int int (maybe int)


positionFuzzer : Fuzzer Position
positionFuzzer =
    map3 Position pointFuzzer pointFuzzer (maybe (list int))
