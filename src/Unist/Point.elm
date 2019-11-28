module Unist.Point exposing (Point, decoder, encode, fromLocation, point, toLocation)

import Elm.Syntax.Range exposing (Location)
import Json.Decode as JD exposing (Decoder)
import Json.Decode.Extra exposing (optionalNullableField)
import Json.Encode as JE
import Json.Encode.Extra exposing (maybe)


type alias Point =
    { line : Int
    , column : Int
    , offset : Maybe Int
    }


point : Int -> Int -> Point
point line column =
    { line = line, column = column, offset = Nothing }


fromLocation : Location -> Point
fromLocation location =
    { line = location.row
    , column = location.column
    , offset = Nothing
    }


toLocation : Point -> Location
toLocation { line, column } =
    { row = line, column = column }


encode : Point -> JE.Value
encode input =
    JE.object
        [ ( "line", JE.int input.line )
        , ( "column", JE.int input.column )
        , ( "offset", input.offset |> maybe JE.int )
        ]


decoder : Decoder Point
decoder =
    JD.map3 Point
        (JD.field "line" JD.int)
        (JD.field "column" JD.int)
        (optionalNullableField "offset" JD.int)
