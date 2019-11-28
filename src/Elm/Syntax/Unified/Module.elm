module Elm.Syntax.Unified.Module exposing (..)

import Elm.Syntax.File exposing (File)
import Elm.Syntax.Node as N
import Elm.Syntax.Module as M
import Elm.Syntax.Unified.ModuleName exposing (ModuleName)
import Elm.Syntax.Unified.ModuleSignature exposing (ModuleSignature)
import Unist.Data as Data exposing (Data)
import Unist.Node exposing (NodeLike)
import Unist.Position exposing (Position, fromRange)


type Module
    = NormalModule { name : ModuleName, children : List ModuleChildren, data : Data, position : Maybe Position }
    | PortModule { name : ModuleName, children : List ModuleChildren, data : Data, position : Maybe Position }
    | EffectModule { name : ModuleName, children : List ModuleChildren, data : Data, position : Maybe Position }


type alias ModuleNodeLike a =
    { a
        | tag : String
        , name : ModuleName
        , data : Data
        , position : Maybe Position
    }


type ModuleChildren
    = Signature ModuleSignature

fromFile: File -> Module
fromFile file =
    let
        N.Node range moduleInfo = file.moduleDefinition
        moduleName = M.moduleName moduleInfo
        position = fromRange range
    in
        case moduleInfo of
            M.NormalModule _ ->
                NormalModule
                    { name = moduleName
                    , children = []
                    , data = Data.empty
                    , position = Just position
                    }
            M.PortModule _ ->
               PortModule { name = moduleName
                , children = []
                , data = Data.empty
                , position = Just position}

            M.EffectModule _ ->
                EffectModule { name = moduleName
                , children = []
                , data = Data.empty
                , position = Just position}

position : Module -> Maybe Position
position node =
    case node of
        NormalModule props -> props.position
        PortModule props -> props.position
        EffectModule props -> props.position

toNode : Module -> ModuleNodeLike a
toNode aModule =
    case aModule of
        NormalModule record ->
            { tag = "module"
            , name = record.name
            , children = record.children
            , data = record.data
            , position = record.position
            }

        PortModule record ->
            { tag = "portModule"
            , name = record.name
            , children = record.children
            , data = record.data
            , position = record.position
            }

        EffectModule record ->
            { tag = "effectModule"
            , name = record.name
            , children = record.children
            , data = record.data
            , position = record.position
            }
