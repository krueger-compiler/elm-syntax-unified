module Unist.Node exposing (..)

import Json.Encode as JE
import Json.Encode.Extra exposing (maybe)
import Unist.Data exposing (Data)
import Unist.Point exposing (Point)
import Unist.Position as Position exposing (Position)


type alias Node =
    { tag : String
    , data : Data
    , position : Maybe Position
    }


type alias NodeLike a =
    { a
        | tag : String
        , data : Data
        , position : Maybe Position
    }


type alias Parent c a =
    { a
        | children : List c
    }


type alias Literal v a =
    NodeLike
        { a
            | value : v
        }


encodeNode : List ( String, JE.Value ) -> NodeLike a -> JE.Value
encodeNode otherFields node =
    let
        nodeFields =
            [ ( "data", node.data )
            , ( "position", maybe Position.encode node.position )
            ]

        fields =
            otherFields ++ nodeFields
    in
    JE.object fields
