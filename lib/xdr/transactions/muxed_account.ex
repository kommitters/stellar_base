defmodule StellarBase.XDR.MuxedAccount do
  @moduledoc """
  Representation of Stellar `MuxedAccount` type.
  """
  alias StellarBase.XDR.{UInt256, CryptoKeyType, MuxedAccountMed25519}

  @behaviour XDR.Declaration

  @arms [
    KEY_TYPE_ED25519: UInt256,
    KEY_TYPE_MUXED_ED25519: MuxedAccountMed25519
  ]

  @type account :: UInt256.t() | MuxedAccountMed25519.t()

  @type t :: %__MODULE__{account: account(), type: CryptoKeyType.t()}

  defstruct [:type, :account]

  @spec new(account :: account(), type :: CryptoKeyType.t()) :: t()
  def new(_account, %CryptoKeyType{identifier: identifier})
      when identifier not in ~w(KEY_TYPE_ED25519 KEY_TYPE_MUXED_ED25519)a,
      do: {:error, :invalid_key_type}

  def new(%UInt256{} = account, %CryptoKeyType{} = type),
    do: %__MODULE__{type: type, account: account}

  def new(%MuxedAccountMed25519{} = account, %CryptoKeyType{} = type),
    do: %__MODULE__{type: type, account: account}

  @impl true
  def encode_xdr(%__MODULE__{type: type, account: account}) do
    type
    |> XDR.Union.new(@arms, account)
    |> XDR.Union.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{type: type, account: account}) do
    type
    |> XDR.Union.new(@arms, account)
    |> XDR.Union.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, spec \\ union_spec())

  def decode_xdr(bytes, spec) do
    case XDR.Union.decode_xdr(bytes, spec) do
      {:ok, {{type, account}, rest}} -> {:ok, {new(account, type), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, spec \\ union_spec())

  def decode_xdr!(bytes, spec) do
    {{type, account}, rest} = XDR.Union.decode_xdr!(bytes, spec)
    {new(account, type), rest}
  end

  @spec union_spec() :: XDR.Union.t()
  def union_spec do
    nil
    |> CryptoKeyType.new()
    |> XDR.Union.new(@arms)
  end
end
