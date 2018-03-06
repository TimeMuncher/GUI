module State exposing (..)

import Types exposing (..)
import Http

init : Model
init = 
  { newProjectName = ""
  , projectNameList = []
  , showName = False
  , serverMessage = ""
  , errorMessage = Nothing
  }

url : String
url = 
  "http://localhost:6767/"

update : Msg -> Model -> ( Model, Cmd Msg)
update msg model =
  case msg of
    NewProjectName name ->
      ({ model | newProjectName = name }, Cmd.none)

    SaveName show ->
      ({ model | 
          showName = True
        , projectNameList = model.newProjectName::model.projectNameList}
      , Cmd.none)

    ProjectNameList _ ->
      ({ model | projectNameList = model.newProjectName::model.projectNameList}, Cmd.none)

    SendHttpRequest ->
      ( model, Http.send DataReceived (Http.getString url))

    DataReceived ( Ok serverMessage ) ->
      ({ model | serverMessage = serverMessage }, Cmd.none)

    DataReceived ( Err _ ) ->
      (model, Cmd.none)