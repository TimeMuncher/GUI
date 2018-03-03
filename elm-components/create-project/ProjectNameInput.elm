{-
    Currently this is identical to main.elm and is
    not being used
-}


module ProjectNameInput 
  exposing 
    ( Msg
      ( ProjectName
      , SaveName
      )
    , Model
    , main
    )

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)

-- MODEL

type alias Model = 
  { projectName : String 
  , showName : Bool
  }

model : Model
model = 
  { projectName = ""
  , showName = False
  }


-- UPDATE

type Msg =
  ProjectName String
  | SaveName Bool

update : Msg -> Model -> Model 
update msg model =
  case msg of
    ProjectName name ->
      { model | projectName = name }

    SaveName show ->
      { model | showName = True }


-- VIEW

view : Model -> Html Msg
view model = 
  div []
    [ input [type_ "text", placeholder "Project Name", onInput ProjectName] []
    , button [ onClick (SaveName True) ] [ text "Add Project" ]
    ]


-- MAIN 

main : Program Never Model Msg
main =
  beginnerProgram
    { model = model
    , update = update
    , view = view
    }