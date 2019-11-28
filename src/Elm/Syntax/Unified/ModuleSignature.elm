module Elm.Syntax.Unified.ModuleSignature exposing (..)

import Elm.Syntax.Unified.Exposing exposing (Exposing)
import Json.Encode exposing (Value)
import Unist.Position exposing (Position)


type ModuleSignature
    = DefaultModuleSignature { children : List Exposing, data : Value, position : Position }
    | PortModuleSignature { children : List Exposing, data : Value, position : Position }
    | EffectModuleSignature { children : List Exposing, data : Value, position : Position }


properties : ModuleSignature -> { a | children : List Exposing, data : Value, position : Position }
properties signature =
    case signature of
        DefaultModuleSignature props ->
            props

        PortModuleSignature props ->
            props

        EffectModuleSignature props ->
            props
