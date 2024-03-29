defmodule StellarBase.XDR.Operations.CreateClaimableBalanceResultCode do
  @moduledoc """
  Representation of Stellar `CreateClaimableBalanceResultCode` type.
  """

  @behaviour XDR.Declaration

  @declarations [
    CREATE_CLAIMABLE_BALANCE_SUCCESS: 0,
    CREATE_CLAIMABLE_BALANCE_MALFORMED: -1,
    CREATE_CLAIMABLE_BALANCE_LOW_RESERVE: -2,
    CREATE_CLAIMABLE_BALANCE_NO_TRUST: -3,
    CREATE_CLAIMABLE_BALANCE_NOT_AUTHORIZED: -4,
    CREATE_CLAIMABLE_BALANCE_UNDERFUNDED: -5
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
