import Html exposing (..)
import State exposing (init, update)
import Types exposing (..)
import Views.MainView exposing (view)

-- MAIN 

main : Program Never Model Msg
main =
  program
    { init = ( init, Cmd.none )
    , update = update
    , view = view
    , subscriptions = \_ -> Sub.none
    }