defmodule CardsTest do
  use ExUnit.Case
  doctest Cards

  test "shuffling a deck randomizes it" do
    deck = Cards.create_deck()
    refute deck == Cards.shuffle(deck)
  end
end
