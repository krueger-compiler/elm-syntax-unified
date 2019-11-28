module Elm.Syntax.Unified.Parser exposing (parse)

import Elm.Parser as ElmParser
import Elm.Processing as Processing
import Elm.Syntax.Unified.Ast as Ast exposing (Ast)
import Parser exposing (DeadEnd, Problem)
import Unist.Point exposing (Point, point)


type ParseError
    = ParseError { errorMessage : String, point : Point }


parse : String -> Result (List ParseError) Ast
parse sourceCode =
    let
        result =
            ElmParser.parse sourceCode
    in
    case result of
        Ok rawFile ->
            let
                processorContext =
                    Processing.init

                file =
                    Processing.process processorContext rawFile
            in
            Ast.fromFile file |> Ok

        Err deadEnds ->
            deadEnds
                |> List.map deadEndToParseError
                |> Err


deadEndToParseError : DeadEnd -> ParseError
deadEndToParseError { row, col, problem } =
    case problem of
        Problem errorMessage ->
            ParseError
                { errorMessage = errorMessage
                , point = point row col
                }

        _ ->
            ParseError
                { errorMessage = Debug.toString problem
                , point = point row col
                }
