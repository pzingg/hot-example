module Main exposing (..)

import Json.Decode as Json
import Json.Encode as Encode exposing (encode)
import Html exposing (Html, Attribute, program, text, div, node)
import Html.Attributes exposing (id, class, attribute)


{-| SSCCE showing problems with handsontable 'hot-table' web component
in different browsers.

See https://github.com/handsontable/hot-table for information about the
component.

This demonstration app built with create-elm-app (webpack dev system).

Hot-table bower component installed with `bower install hot-table`

Polyfill for Safari and Firefox installed in src/index.js, based on
suggestions in https://www.polymer-project.org/1.0/docs/browsers

When viewed in Chrome with Polymer.dom is set to 'shadow',
the hot-table displays with correct styles and positioning, using the
native support for webcomponents that is built into Chrome.

In Safari and Firefox the grid will display inaccurately
(headers shown at top of screen, no grid borders, etc.), no matter what
Polymer.dom setting is used.  The same result shows up in Chrome
if Polymer.dom is set to 'shady' (the default).

You can adjust this setting in src/index.js.
-}
main : Program Never Model Msg
main =
    program { view = view, init = init, update = update, subscriptions = subscriptions }



-- MODEL


{-| Model is just a table of strings, with column headers
-}
type alias Model =
    { colHeaders : List String
    , datarows : List (List String)
    }


{-| Load some data for the table.
-}
init : ( Model, Cmd Msg )
init =
    ( { colHeaders = [ "First", "Second", "Third", "Fourth", "Fifth" ]
      , datarows =
            [ [ "1.2", "2.3", "3.4" ]
            , [ "4.5", "5.6", "6.7" ]
            , [ "1.2", "2.3" ]
            , [ "4.5", "5.6", "6.7" ]
            , [ "1.2", "2.3", "3.4", "1.9", "3.3" ]
            , [ "4.5", "5.6", "6.7" ]
            , [ "1.2", "2.3", "3.4" ]
            , [ "4.5", "5.6", "6.7" ]
            ]
      }
    , Cmd.none
    )



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )



-- VIEW


{-| Custom Html.node type for hot-table webcomponent.
-}
hotTable : List (Attribute a) -> List (Html a) -> Html a
hotTable =
    Html.node "hot-table"


{-| Encoode settings to name and format columns in hot-table.
-}
encodeSettings : List String -> Json.Value
encodeSettings colHeaders =
    let
        -- Each column can have distinct settings (like numeric)
        column _ =
            Encode.object
                [ ( "type", Encode.string "numeric" )
                , ( "format", Encode.string "0.000" )
                ]

        columns =
            List.map column colHeaders

        -- Also specify column names
        headers =
            List.map Encode.string colHeaders
    in
        Encode.object
            [ ( "rowHeaders", Encode.bool True )
            , ( "colHeaders", Encode.list headers )
            , ( "columns", Encode.list columns )
            ]


{-| Encoode the data for the table.
-}
encodeDatarows : List (List String) -> Json.Value
encodeDatarows datarows =
    let
        eachRow row =
            Encode.list <| List.map Encode.string row

        rows =
            List.map eachRow datarows
    in
        Encode.list rows


type Msg
    = NoOp


view : Model -> Html Msg
view model =
    div [ class "center" ]
        [ div [ class "wrapper" ]
            [ text "Elm hot-table example with numeric columns and row and column headers:"
            , hotTable
                [ id "my-table"
                  -- Initalize the table settings and data,
                  -- converting the Json.Values to strings
                , attribute "settings" (encode 0 <| encodeSettings model.colHeaders)
                , attribute "datarows" (encode 0 <| encodeDatarows model.datarows)
                ]
                []
            ]
        ]



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
