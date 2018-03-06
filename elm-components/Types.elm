module Types exposing (..)

import Http

type alias Model = 
  { newProjectName : String
  , projectNameList : List String
  , showName : Bool
  , serverMessage : String
  , errorMessage : Maybe String
  }

type Msg =
  NewProjectName String
  | ProjectNameList List
  | SaveName Bool
  | SendHttpRequest 
  | DataReceived (Result Http.Error String)