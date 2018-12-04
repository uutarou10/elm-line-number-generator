module Main exposing (Model, Msg(..), appendLineNumber, init, main, update, view)

import Browser
import Html exposing (Html, div, h1, pre, text, textarea)
import Html.Attributes exposing (value)
import Html.Events exposing (onInput)



---- MODEL ----


type alias Model =
    { inputText : String }


init : Model
init =
    { inputText = "" }



---- UPDATE ----


type Msg
    = UpdateText String


update : Msg -> Model -> Model
update msg model =
    case msg of
        UpdateText text ->
            { model | inputText = text }



---- VIEW ----


appendLineNumber : String -> String
appendLineNumber text =
    text
        |> String.split "\n"
        |> List.indexedMap Tuple.pair
        |> List.map (\( a, b ) -> String.fromInt (a + 1) ++ " | " ++ b)
        |> String.join "\n"


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "Line number generator" ]
        , textarea
            [ value model.inputText
            , onInput UpdateText
            ]
            []
        , pre [] [ text (appendLineNumber model.inputText) ]
        ]



---- PROGRAM ----


main =
    Browser.sandbox
        { init = init
        , view = view
        , update = update
        }
