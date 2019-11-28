module Elm.Syntax.Unified.Ast exposing (..)

import Elm.Syntax.File exposing (File)
import Elm.Syntax.Unified.Root as Root exposing (Root)
import Json.Encode as JE


type alias Ast =
    Root


fromFile : File -> Ast
fromFile file =
    Root.fromFile file
