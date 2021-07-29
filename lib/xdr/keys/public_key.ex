defmodule Stellar.XDR.PublicKey do
  @moduledoc """
  Representation of Stellar `PublicKey` type.
  """
  alias Stellar.XDR.{UInt256, PublicKeyType}

  @behaviour XDR.Declaration

  @arms [PUBLIC_KEY_TYPE_ED25519: UInt256]

  @type t :: %__MODULE__{public_key: String.t(), type: atom()}

  defstruct [:public_key, :type]

  @spec new(type :: atom() | nil) :: t()
  def new(public_key, type \\ :PUBLIC_KEY_TYPE_ED25519),
    do: %__MODULE__{public_key: public_key, type: type}

  @impl true
  def encode_xdr(%__MODULE__{public_key: public_key, type: type}) do
    type
    |> PublicKeyType.new()
    |> XDR.Union.new(@arms, public_key)
    |> XDR.Union.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{public_key: public_key, type: type}) do
    type
    |> PublicKeyType.new()
    |> XDR.Union.new(@arms, public_key)
    |> XDR.Union.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, spec \\ xdr_union_spec())

  def decode_xdr(bytes, spec) do
    case XDR.Union.decode_xdr(bytes, spec) do
      {:ok, {{type, %UInt256{datum: key}}, rest}} -> {:ok, {new(key, type), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, spec \\ xdr_union_spec())

  def decode_xdr!(bytes, spec) do
    {{type, %UInt256{datum: key}}, rest} = XDR.Union.decode_xdr!(bytes, spec)
    {new(key, type), rest}
  end

  @spec xdr_union_spec() :: XDR.Union.t()
  defp xdr_union_spec do
    :PUBLIC_KEY_TYPE_ED25519
    |> PublicKeyType.new()
    |> XDR.Union.new(@arms)
  end
end
