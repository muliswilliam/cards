defmodule Cards do
  @moduledoc """
  `Card` module
  """

  @spec create_deck :: [<<_::24, _::_*16>>, ...]
  @doc """
    Create a deck of decks
  """
  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five"]
    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]

    for suit <- suits, value <- values do
      "#{value} of #{suit}"
    end
  end

  @doc """
  Shuffle a deck of cards

  ## Examples
    iex> deck = Cards.create_deck
    iex> Cards.shuffle(deck)
  """
  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
    Check if a card is in a deck

  ## Examples

      iex> deck = Cards.create_deck
      iex> Cards.contains?(deck, "Ace of Spades")
      true

  """
  @spec contains?(any, any) :: boolean
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
  Deal a deck of hands and return a hand
  `hand_size` specifies number of cards in a hand

  ## Examples

      iex>deck = Cards.create_deck()
      iex> Cards.deal(deck, 1)
      ["Ace of Spades"]

  """
  def deal(deck, hand_size) do
    {hand, _} = Enum.split(deck, hand_size)
    hand
  end

  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  @doc """
  Loads a file from the file system
  `filename` specifies the location of the file
  """
  @spec load(
          binary
          | maybe_improper_list(
              binary | maybe_improper_list(any, binary | []) | char,
              binary | []
            )
        ) :: any
  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, reason} -> "Error reading the file. Reason #{reason}"
    end
  end

  @doc """
  Creates a deck of cards, shuffles the cards deals the deck
  Returns a hand of `hand_size` as the number of cards in the hand.
  """
  def create_hand(hand_size) do
    Cards.create_deck()
    |> Cards.shuffle()
    |> Cards.deal(hand_size)
  end
end
