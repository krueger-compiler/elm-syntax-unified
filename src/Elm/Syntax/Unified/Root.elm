module Elm.Syntax.Unified.Root exposing (Root, empty, fromFile, toNode)

import Elm.Syntax.File exposing (File)
import Elm.Syntax.Unified.Module as Module exposing (Module)
import Unist.Data as Data exposing (Data)
import Unist.Node exposing (NodeLike)
import Unist.Position exposing (Position)


type alias Root =
    { children : List Module, data : Data, position : Maybe Position }


empty : Root
empty =
    { children = [], data = Data.empty, position = Nothing }


fromFile : File -> Root
fromFile file =
    let
        moduleNode =
            Module.fromFile file
    in
    { children = [ moduleNode ]
    , data = Data.empty
    , position = Module.position moduleNode
    }


toNode : Root -> NodeLike a
toNode root =
    { tag = "root"
    , children = root.children
    , data = root.data
    , position = root.position
    }
