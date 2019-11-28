module Unist.UnistTests exposing (..)

import Expect exposing (Expectation)
import Fuzz exposing (..)
import Json.Decode as JD
import Test exposing (..)
import Unist.Fuzzer exposing (..)
import Unist.Point as Point exposing (Point)
import Unist.Position as Position exposing (Position)


pointTestSuite : Test
pointTestSuite =
    describe "Point Tests"
        [ describe
            "Given a Point"
            [ fuzz pointFuzzer "When it is encoded and decoded then the result should be equivalent to the original point" <|
                \original ->
                    let
                        encoded =
                            Point.encode original

                        decoded =
                            JD.decodeValue Point.decoder encoded
                    in
                    Expect.equal (Ok original) decoded
            ]
        , describe
            "Given a Location"
            [ fuzz locationFuzzer "it should be possible to convert it to a Point." <|
                \loc ->
                    let
                        expected =
                            { line = loc.row, column = loc.column, offset = Nothing }
                    in
                    Expect.equal expected (loc |> Point.fromLocation)
            ]
        ]


positionTests : Test
positionTests =
    describe "Given a position"
        [ fuzz positionFuzzer "Encoding and decoding a position should produce an equivalent position" <|
            \original ->
                let
                    encoded =
                        Position.encode original

                    decoded =
                        JD.decodeValue Position.decoder encoded
                in
                Expect.equal (Ok original) decoded
        ]
