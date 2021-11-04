defmodule Stellar.XDR.Thresholds do
  @moduledoc """
  Representation of an AccountEntry's Thresholds.
  Thresholds stores unsigned bytes: [weight of master|low|med|high]
  """
  alias Stellar.XDR.Opaque4

  @behaviour XDR.Declaration

  @type thresholds :: [
          master_weight: non_neg_integer(),
          low: non_neg_integer(),
          med: non_neg_integer(),
          high: non_neg_integer()
        ]

  @type t :: %__MODULE__{thresholds: thresholds}

  defstruct [:thresholds]

  @spec new(master_weight: byte(), low: byte(), med: byte(), high: byte()) :: t()
  def new([master_weight: _master_weight, low: _low, med: _med, high: _high] = thresholds),
    do: %__MODULE__{thresholds: thresholds}

  @impl true
  def encode_xdr(%__MODULE__{
        thresholds:
          [master_weight: _master_weight, low: _low, med: _med, high: _high] = thresholds
      }) do
    to_binary(thresholds)
    |> Opaque4.new()
    |> Opaque4.encode_xdr()
  end

  def encode_xdr(_thresholds), do: {:error, :invalid_thresholds_specification}

  @impl true
  def encode_xdr!(%__MODULE__{thresholds: thresholds}) do
    to_binary(thresholds)
    |> Opaque4.new()
    |> Opaque4.encode_xdr!()
  end

  def encode_xdr!(_thresholds),
    do: raise(Stellar.XDR.ThresholdsError, :invalid_thresholds_specification)

  @impl true
  def decode_xdr(bytes, spec \\ nil)

  def decode_xdr(bytes, _spec) do
    case Opaque4.decode_xdr(bytes) do
      {:ok, {%Opaque4{opaque: thresholds}, rest}} ->
        {:ok, {new(to_keyword_list(thresholds)), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, spec \\ nil)

  def decode_xdr!(bytes, _spec) do
    {%Opaque4{opaque: thresholds}, rest} = Opaque4.decode_xdr!(bytes)
    {new(to_keyword_list(thresholds)), rest}
  end

  @spec to_binary(thresholds :: thresholds()) :: binary()
  defp to_binary(thresholds) do
    [master_weight: master_weight, low: low, med: med, high: high] = thresholds
    <<master_weight, low, med, high>>
  end

  @spec to_keyword_list(thresholds :: binary()) :: thresholds()
  defp to_keyword_list(thresholds) do
    <<master_weight::8, low::8, med::8, high::8>> = thresholds
    [master_weight: master_weight, low: low, med: med, high: high]
  end
end
