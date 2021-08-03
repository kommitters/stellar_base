defmodule Stellar.XDR.MuxedAccount do
  @moduledoc """
  Representation of Stellar `MuxedAccount` type.
  """
  alias Stellar.XDR.{UInt256, CryptoKeyType, MuxedAccountMed25519}

  @behaviour XDR.Declaration

  @arms [
    KEY_TYPE_ED25519: UInt256,
    KEY_TYPE_MUXED_ED25519: MuxedAccountMed25519
  ]

  @union_spec XDR.Union.new(CryptoKeyType.new(nil), @arms)

  @type account :: UInt256.t() | MuxedAccountMed25519.t()

  @type t :: %__MODULE__{type: CryptoKeyType.t(), account: account()}

  defstruct [:type, :account]

  @spec new(type :: UInt256.t(), account :: account()) :: t()
  def new(%CryptoKeyType{identifier: identifier}, _account)
      when identifier not in ~w(KEY_TYPE_ED25519 KEY_TYPE_MUXED_ED25519)a,
      do: {:error, :invalid_key_type}

  def new(%CryptoKeyType{} = type, %UInt256{} = account),
    do: %__MODULE__{type: type, account: account}

  def new(%CryptoKeyType{} = type, %MuxedAccountMed25519{} = account),
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
  def decode_xdr(bytes, spec \\ @union_spec)

  def decode_xdr(bytes, spec) do
    case XDR.Union.decode_xdr(bytes, spec) do
      {:ok, {{type, account}, rest}} -> {:ok, {new(type, account), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, spec \\ @union_spec)

  def decode_xdr!(bytes, spec) do
    case XDR.Union.decode_xdr!(bytes, spec) do
      {{type, account}, rest} -> {new(type, account), rest}
      error -> error
    end
  end

  @spec union_spec() :: XDR.Union.t()
  def union_spec do
    enum_spec = CryptoKeyType.new(nil)
    XDR.Union.new(enum_spec, @arms)
  end
end
