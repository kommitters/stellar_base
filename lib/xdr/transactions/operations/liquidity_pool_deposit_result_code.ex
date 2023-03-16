defmodule StellarBase.XDR.Operations.LiquidityPoolDepositResultCode do
  @moduledoc """
  Representation of Stellar `LiquidityPoolDepositResultCode` type.
  """

  @behaviour XDR.Declaration

  @declarations [
    # success
    LIQUIDITY_POOL_DEPOSIT_SUCCESS: 0,
    # bad input
    LIQUIDITY_POOL_DEPOSIT_MALFORMED: -1,
    # no trust line for one of the assets
    LIQUIDITY_POOL_DEPOSIT_NO_TRUST: -2,
    # not authorized for one of the assets
    LIQUIDITY_POOL_DEPOSIT_NOT_AUTHORIZED: -3,
    # not enough balance for one of the assets
    LIQUIDITY_POOL_DEPOSIT_UNDERFUNDED: -4,
    # pool share trust line doesn't have sufficient limit
    LIQUIDITY_POOL_DEPOSIT_LINE_FULL: -5,
    # deposit price outside bounds
    LIQUIDITY_POOL_DEPOSIT_BAD_PRICE: -6,
    # pool reserves are full
    LIQUIDITY_POOL_DEPOSIT_POOL_FULL: -7
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
