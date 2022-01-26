defmodule StellarBase.XDR.PublicKey do
  @moduledoc """
  Representation of Stellar `PublicKey` type.
  """
  alias StellarBase.XDR.{UInt256, PublicKeyType}

  @behaviour XDR.Declaration

  @arms [PUBLIC_KEY_TYPE_ED25519: UInt256]

  @type t :: %__MODULE__{public_key: UInt256.t(), type: PublicKeyType.t()}

  defstruct [:public_key, :type]

  @spec new(public_key :: UInt256.t(), type :: PublicKeyType.t()) :: t()
  def new(%UInt256{} = public_key, %PublicKeyType{} = type),
    do: %__MODULE__{public_key: public_key, type: type}

  @impl true
  def encode_xdr(%__MODULE__{public_key: public_key, type: type}) do
    type
    |> XDR.Union.new(@arms, public_key)
    |> XDR.Union.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{public_key: public_key, type: type}) do
    type
    |> XDR.Union.new(@arms, public_key)
    |> XDR.Union.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, spec \\ union_spec())

  def decode_xdr(bytes, spec) do
    case XDR.Union.decode_xdr(bytes, spec) do
      {:ok, {{type, key}, rest}} -> {:ok, {new(key, type), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, spec \\ union_spec())

  def decode_xdr!(bytes, spec) do
    {{type, key}, rest} = XDR.Union.decode_xdr!(bytes, spec)
    {new(key, type), rest}
  end

  @spec union_spec() :: XDR.Union.t()
  defp union_spec do
    nil
    |> PublicKeyType.new()
    |> XDR.Union.new(@arms)
  end
end
