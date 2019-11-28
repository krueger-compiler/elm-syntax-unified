module Elm.Syntax.Unified.Nodes.Comment exposing (Comment, encode)

import Json.Encode as E
import Unist.Data exposing (Data)
import Unist.Node exposing (Literal, Node, NodeLike)
import Unist.Position exposing (Position)


type alias Comment =
    { value : String
    , data : Data
    , position : Maybe Position
    }


toNode : Comment -> NodeLike a
toNode comment =
    { tag = "comment"
    , value = comment.value
    , data = comment.data
    , position = comment.position
    }


encode : Comment -> E.Value
encode node =
    E.object
        [ ( "type", E.string "comment" )
        , ( "value", E.string node.value )
        , ( "data", node.data )
        ]
