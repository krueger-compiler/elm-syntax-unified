module Elm.Syntax.Unified.Exposing exposing (Exposing(..))

import Elm.Syntax.Exposing as E
import Unist.Position exposing (Position)


type Exposing
    = All { position : Position }
