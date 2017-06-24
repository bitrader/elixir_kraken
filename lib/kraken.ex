defmodule Kraken do
  @moduledoc """
  Documentation for Kraken.
  """

  use HTTPoison.Base

  @base_url "https://api.kraken.com/0/public/Ticker?pair=XXBTZUSD"

  @doc """
  Get Bitcoin ticker exchange to USD

  ## Examples

      iex> Kraken.ticker

  """
  def ticker do
    with {:ok, result} <- get(@base_url),
         {:ok, json}   <- Poison.decode(result.body),
         do: transform(json)
  end

  defp transform(json) do
    result = json["result"]["XXBTZUSD"]

    {:ok, %{
      "ask":  result["a"],
      "bid":  result["b"],
      "low":  result["l"],
      "high": result["h"],
      "open": result["o"],
      "volume":       result["v"],
      "last_trade":   result["c"],
      "trades_today": result["t"],
      "volume_weighted_average": result["p"]
    }}
  end
end
