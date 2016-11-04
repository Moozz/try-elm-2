module ParserComponent exposing (..)

import Html exposing (Html, Attribute, div, input, text, p)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import CardSpelling exposing (spellCard)

type alias Model = 
    { spell : String
    }

initModel : String -> Model
initModel str = 
    { spell = str }

type Msg = Change String

update : Msg -> Model -> Model
update msg model =
    case msg of 
        Change x ->
            { model | spell = x }

view : Model -> Html Msg
view model =
    div [ mainStyle ]
        [ input [ inputStyle, placeholder "Input your card here", onInput Change ] []
        , p [cardStyle] [ text (spellCard model.spell) ]
        ]

mainStyle : Attribute Msg
mainStyle =
    style
        [ ( "font-family", "-apple-system, system, sans-serif" )
        , ( "margin", "10px" )
        , ( "padding", "40px" )
        , ( "display", "flex" )
        , ( "flex-direction", "column" )
        , ( "align-items", "stretch" )
        , ( "background-color", "#fafafa" )
        , ( "border", "lightgray solid 1px" )
        ]

inputStyle : Attribute Msg
inputStyle =
    style
        [ ( "border", "#fafafa solid" )
        , ( "border-bottom", "lightgray solid 1px" )
        , ( "font-size", "2em" )
        , ( "color", "rgba(0,0,0,0.75)" )
        , ( "background-color", "#fafafa" )
        ]

cardStyle : Attribute Msg
cardStyle =
    style
        [ ( "font-size", "2em" )
        , ( "color", "rgba(0,0,0,0.75)" )
        ]
