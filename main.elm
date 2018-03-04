import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)
import Http

-- MODEL

type alias Model = 
  { newProjectName : String
  , projectNameList : List String
  , showName : Bool
  , serverMessage : String
  , errorMessage : Maybe String
  }

model : Model
model = 
  { newProjectName = ""
  , projectNameList = []
  , showName = False
  , serverMessage = ""
  , errorMessage = Nothing
  }


-- UPDATE

type Msg =
  NewProjectName String
  | ProjectNameList List
  | SaveName Bool
  | SendHttpRequest 
  | DataReceived (Result Http.Error String)

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


-- VIEW

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

-- MAIN 

main : Program Never Model Msg
main =
  program
    { init = ( model, Cmd.none )
    , update = update
    , view = view
    , subscriptions = \_ -> Sub.none
    }