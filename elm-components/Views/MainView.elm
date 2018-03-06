module Views.MainView exposing (..)

import Types exposing (..)
import State exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)

view : Model -> Html Msg
view model = 
  div []
    [ input [type_ "text", placeholder "Project Name", onInput NewProjectName] []
    , button [ onClick (SaveName True) ] [ text "Add Project" ]
    , showProjectName model
    , div []
      [ button [ onClick SendHttpRequest ] [ text "Send Request!" ]
      , showServerMessageOrError model
      ]
    ]

showServerMessageOrError : Model -> Html Msg 
showServerMessageOrError model = 
  case model.errorMessage of  
    Just message ->
      viewError message 

    Nothing ->
      viewMessage model.serverMessage

viewError : String -> Html Msg 
viewError errorMessage =
  let 
    errorHeading = 
      "Hmm something went wrong..."
  in 
    div []
    [ h3 [] [ text errorHeading ]
    , text ("Error: " ++ errorMessage)
    ]

viewMessage : String -> Html Msg  
viewMessage serverMessage =
    div []
    [ h3 [] [ text serverMessage ]
    ]

-- Helper Functions

showProjectName : Model -> Html Msg
showProjectName model =
  if model.showName then
    ul [] (List.map toLi model.projectNameList)
  else 
    div [] []

toLi : String -> Html Msg
toLi item =
  li [] [ text item]