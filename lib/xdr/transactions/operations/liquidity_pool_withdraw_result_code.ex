defmodule StellarBase.XDR.Operations.LiquidityPoolWithdrawResultCode do
  @moduledoc """
  Representation of Stellar `LiquidityPoolWithdrawResultCode` type.
  """

  @behaviour XDR.Declaration

  @declarations [
    # success
    LIQUIDITY_POOL_WITHDRAW_SUCCESS: 0,
    # bad input
    LIQUIDITY_POOL_WITHDRAW_MALFORMED: -1,
    # no trust line for one of the assets
    LIQUIDITY_POOL_WITHDRAW_NO_TRUST: -2,
    # not enough balance of the pool share
    LIQUIDITY_POOL_WITHDRAW_UNDERFUNDED: -3,
    # would go above limit for one of the assets
    LIQUIDITY_POOL_WITHDRAW_LINE_FULL: -4,
    # didn't withdraw enough
    LIQUIDITY_POOL_WITHDRAW_UNDER_MINIMUM: -5
  ]

  @enum_spec %XDR.Enum{declarations: @declarations, identifier: nil}

  @type t :: %__MODULE__{identifier: atom()}

  defstruct [:identifier]

  @spec new(code :: atom()) :: t()
  def new(code), do: %__MODULE__{identifier: code}

  @impl true
  def encode_xdr(%__MODULE__{identifier: code}) do
    @declarations
    |> XDR.Enum.new(code)
    |> XDR.Enum.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{identifier: code}) do
    @declarations
    |> XDR.Enum.new(code)
    |> XDR.Enum.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, spec \\ @enum_spec)

  def decode_xdr(bytes, spec) do
    case XDR.Enum.decode_xdr(bytes, spec) do
      {:ok, {%XDR.Enum{identifier: code}, rest}} -> {:ok, {new(code), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, spec \\ @enum_spec)

  def decode_xdr!(bytes, spec) do
    {%XDR.Enum{identifier: code}, rest} = XDR.Enum.decode_xdr!(bytes, spec)
    {new(code), rest}
  end
end
