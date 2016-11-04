module CardSpelling exposing (spellCard)

import Dict exposing (get, fromList)
import String

type Value = Jack | Queen | King | Ace | Num Int
type Suit = Club | Diamond | Spade | Heart
type Card = OrdinaryCard Value Suit | Joker

printSuit : Suit -> String
printSuit suit = toString suit

printValue : Value -> String
printValue value = 
  let
    numMap = fromList [(2, "Two"),
     (3, "Three"),
     (4, "Four"),
     (5, "Five"),
     (6, "Six"),
     (7, "Seven"),
     (8, "Eight"),
     (9, "Nine"),
     (10, "Ten")]
  in 
    case value of
      Num x ->
        case get x numMap of
          Just y ->
            y
          Nothing ->
            ""

      _ ->
        toString value
        
printCard : Card -> String
printCard card =
  case card of
    OrdinaryCard value suit -> 
      [printValue value, " of ", printSuit suit]
        |> String.concat
    
    Joker ->
      "Joker"

parseNumValue : String -> Maybe Value
parseNumValue value =
  case String.toInt value of
    Ok num ->
      if num > 1 && num <= 10 then 
        Just (Num num)
      else
        Nothing
      
    Err _ ->
      Nothing
      
parseValue : String -> Maybe Value
parseValue value =
  case value of
    "J" -> Just Jack
    "Q" -> Just Queen
    "K" -> Just King
    "A" -> Just Ace
    _ -> parseNumValue value

parseSuit : Char -> Maybe Suit
parseSuit char =
  case char of
    'C' -> Just Club
    'D' -> Just Diamond
    'S' -> Just Spade
    'H' -> Just Heart
    _ -> Nothing

parseCardString : String -> Maybe Card
parseCardString str =
  case str of
    "J" -> Just Joker
    _ -> 
      str 
        |> divideCardString
        |> mapToCard

divideCardString : String -> (Maybe String, Maybe Char)
divideCardString str =
  let 
    chars = String.toList str
    suit = chars
      |> List.reverse
      |> List.head
    value = chars
      |> List.reverse
      |> List.tail
      |> Maybe.map List.reverse
      |> Maybe.map String.fromList
  in
    (value, suit)

mapToCard : (Maybe String, Maybe Char) -> Maybe Card
mapToCard (value, suit) =
  case (value `Maybe.andThen` parseValue, suit `Maybe.andThen` parseSuit) of
    (Just v, Just s) -> Just (OrdinaryCard v s)
    _ -> Nothing

spellCard : String -> String
spellCard str =
  str
    |> parseCardString
    |> Maybe.map printCard
    |> Maybe.withDefault "-- unknown card --"
