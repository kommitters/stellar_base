defmodule StellarBase.XDR.Thresholds do
  @moduledoc """
  Representation of an AccountEntry's Thresholds.
  Thresholds stores unsigned bytes: [weight of master|low|med|high]
  """
  alias StellarBase.XDR.Opaque4

  @behaviour XDR.Declaration

  @type thresholds :: [
          master_weight: byte(),
          low: byte(),
          med: byte(),
          high: byte()
        ]

  @type t :: %__MODULE__{master_weight: byte(), low: byte(), med: byte(), high: byte()}

  defstruct [:master_weight, :low, :med, :high]

  @spec new(thresholds :: thresholds()) :: t()
  def new(master_weight: master_weight, low: low, med: med, high: high),
    do: %__MODULE__{master_weight: master_weight, low: low, med: med, high: high}

  @impl true
  def encode_xdr(%__MODULE__{
        master_weight: master_weight,
        low: low,
        med: med,
        high: high
      }) do
    <<master_weight::8, low::8, med::8, high::8>>
    |> Opaque4.new()
    |> Opaque4.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{master_weight: master_weight, low: low, med: med, high: high}) do
    <<master_weight, low, med, high>>
    |> Opaque4.new()
    |> Opaque4.encode_xdr!()
  end

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

  @spec to_keyword_list(thresholds :: binary()) :: thresholds()
  defp to_keyword_list(thresholds) do
    <<master_weight::8, low::8, med::8, high::8>> = thresholds
    [master_weight: master_weight, low: low, med: med, high: high]
  end
end
