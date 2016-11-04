import ParserComponent exposing (Model, Msg, initModel, view, update)
import Html exposing (Html, Attribute, div, input, text, p)
import Html.App as App

main : Program Basics.Never
main =
    App.beginnerProgram { 
        model = init "" "",
        view = view, 
        update = update 
    }

type Msg 
    = First ParserComponent.Msg
    | Second ParserComponent.Msg
    
type alias Model =
    {
        firstParser : ParserComponent.Model,
        secondParser : ParserComponent.Model
    }

init : String -> String -> Model
init first second = 
    Model { spell = first} { spell = second }

update : Msg -> Model -> Model
update msg model =
    case msg of 
        First x ->
            { model | firstParser = ParserComponent.update x model.firstParser }
        Second x -> 
            { model | secondParser = ParserComponent.update x model.secondParser }

view : Model -> Html Msg
view model =
    div []
        [ App.map First (ParserComponent.view model.firstParser)
        , App.map Second (ParserComponent.view model.secondParser)]