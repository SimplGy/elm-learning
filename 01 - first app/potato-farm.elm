import Html exposing (..)
import Html.Events exposing (onClick)
import Html.Attributes exposing (disabled)



main =
  Html.beginnerProgram
    { model = model
    , view = view
    , update = update
    }



-- MODEL
type alias PotatoFarmModel =
  { amount : Int
  } 
model : PotatoFarmModel
model =
  { amount = 3 }



-- UPDATE
type Msg =
  Increment Int | Decrement

update : Msg -> PotatoFarmModel -> PotatoFarmModel
update msg model =
  case msg of
    Increment val ->
      { model | amount = model.amount + val }
    Decrement ->
      { model | amount = max 0 (model.amount - 1) }



-- VIEW
-- TODO: what does this mean... it's a function that returns an Html.msg? a tuple of both? Either?
view : PotatoFarmModel -> Html Msg
view model =
  let
    cannotDecrement =
      model.amount <= 0
    caption =
      (toString model.amount ++ " " ++ pluralize "potato" "potatoes" model.amount)

  in
    article []
      [ h1 [] [ text "Potato Farm" ]
      , p [] [ text caption ]
      , button [ onClick <| Increment 3 ] [ text "Grow Potatoes" ]
      , button [ disabled cannotDecrement, onClick Decrement ] [ text "Eat Potato" ]
      ]



-- UTILS

pluralize : String -> String -> Int -> String
pluralize singular plural quantity =
  if quantity == 1 then
    singular
  else
    plural

