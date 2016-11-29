module Main exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)
import Html.Attributes exposing (disabled)
import Array exposing (..)


main =
    Html.beginnerProgram
        { model = model
        , view = view
        , update = update
        }



-- MODEL


type alias RandomPairModel =
    { vi : Int
    , ni :
        Int
        -- Current Index for the verb and noun
    , joiner : String
    , verbs : Array String
    , nouns : Array String
    }


model : RandomPairModel
model =
    { vi = 0
    , ni = 0
    , joiner = "that"
    , nouns = Array.fromList [ "car", "hat", "cat" ]
    , verbs = Array.fromList [ "splash", "eat", "bless" ]
    }



-- UPDATE


type Msg
    = Next
    | Prev


update : Msg -> RandomPairModel -> RandomPairModel
update msg model =
    case msg of
        Next ->
            let
                vi =
                    if model.vi + 1 < length model.verbs then
                        model.vi + 1
                    else
                        0

                ni =
                    if model.ni + 1 < length model.nouns then
                        model.ni + 1
                    else
                        0
            in
                { model | vi = vi, ni = ni }

        Prev ->
            Debug.crash "TODO Msg Prev is not implemented"



-- VIEW
-- TODO: what does this mean... it's a function that returns an Html.msg? a tuple of both? Either?


view : RandomPairModel -> Html Msg
view model =
    let
        verb =
            stringOrBust <| Array.get model.vi model.verbs

        noun =
            stringOrBust <| Array.get model.ni model.nouns
    in
        article []
            [ h1 [] [ text "Verb that Noun" ]
            , p []
                [ span [] [ text (verb ++ " ") ]
                , span [] [ text (model.joiner ++ " ") ]
                , span [] [ text noun ]
                ]
            , button [ onClick Next ] [ text "Next" ]
            ]



-- Utils


stringOrBust : Maybe String -> String
stringOrBust str =
    case str of
        Just str ->
            str

        Nothing ->
            "_"
