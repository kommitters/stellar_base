defmodule Stellar.XDR.InflationPayoutList do
  @moduledoc """
  Representation of a Stellar `InflationPayoutList` list.
  """
  alias Stellar.XDR.InflationPayout

  @behaviour XDR.Declaration

  @max_length 100

  @array_type InflationPayout

  @array_spec %{type: @array_type, max_length: @max_length}

  @type t :: %__MODULE__{payouts: list(InflationPayout.t())}

  defstruct [:payouts]

  @spec new(payouts :: list(InflationPayout.t())) :: t()
  def new(payouts), do: %__MODULE__{payouts: payouts}

  @impl true
  def encode_xdr(%__MODULE__{payouts: payouts}) do
    payouts
    |> XDR.VariableArray.new(@array_type, @max_length)
    |> XDR.VariableArray.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{payouts: payouts}) do
    payouts
    |> XDR.VariableArray.new(@array_type, @max_length)
    |> XDR.VariableArray.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, spec \\ @array_spec)

  def decode_xdr(bytes, spec) do
    case XDR.VariableArray.decode_xdr(bytes, spec) do
      {:ok, {payouts, rest}} -> {:ok, {new(payouts), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, spec \\ @array_spec)

  def decode_xdr!(bytes, spec) do
    {payouts, rest} = XDR.VariableArray.decode_xdr!(bytes, spec)
    {new(payouts), rest}
  end
end
