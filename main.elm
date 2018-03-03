import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)

-- MODEL

type alias Model = 
  { newProjectName : String
  , projectNameList : List String
  , showName : Bool
  }

model : Model
model = 
  { newProjectName = ""
  , projectNameList = []
  , showName = False
  }


-- UPDATE

type Msg =
  NewProjectName String
  | ProjectNameList List
  | SaveName Bool

update : Msg -> Model -> Model 
update msg model =
  case msg of
    NewProjectName name ->
      { model | newProjectName = name }

    SaveName show ->
      { model | 
          showName = True
        , projectNameList = model.newProjectName::model.projectNameList} 

    ProjectNameList _ ->
      { model | projectNameList = model.newProjectName::model.projectNameList}


-- VIEW

view : Model -> Html Msg
view model = 
  div []
    [ input [type_ "text", placeholder "Project Name", onInput NewProjectName] []
    , button [ onClick (SaveName True) ] [ text "Add Project" ]
    , showProjectName model
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
  div [] [ text item]

-- MAIN 

main : Program Never Model Msg
main =
  beginnerProgram
    { model = model
    , update = update
    , view = view
    }