module Unist.Position exposing (Position, decoder, encode, fromRange, toRange)

import Elm.Syntax.Range exposing (Range)
import Json.Decode as JD exposing (Decoder)
import Json.Decode.Extra exposing (optionalNullableField)
import Json.Encode exposing (Value, int, list, object)
import Json.Encode.Extra exposing (maybe)
import Unist.Point as Point exposing (Point)


type alias Position =
    { start : Point
    , end : Point
    , indent : Maybe (List Int)
    }


fromRange : Range -> Position
fromRange { start, end } =
    { start = Point.fromLocation start
    , end = Point.fromLocation end
    , indent = Nothing
    }


toRange : Position -> Range
toRange { start, end } =
    { start = Point.toLocation start
    , end = Point.toLocation end
    }


{-| Encode a Position to JSON
-}
encode : Position -> Value
encode position =
    object
        [ ( "start", Point.encode position.start )
        , ( "end", Point.encode position.end )
        , ( "indent", maybe (list int) position.indent )
        ]


{-| A decoder for Positions
-}
decoder : Decoder Position
decoder =
    JD.map3 Position
        (JD.field "start" Point.decoder)
        (JD.field "end" Point.decoder)
        (optionalNullableField "indent" (JD.list JD.int))
