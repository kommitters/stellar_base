defmodule Stellar.XDR.PublicKeyType do
  @moduledoc """
  Representation of Stellar `PublicKeyType` type.
  """
  @behaviour XDR.Declaration

  @declarations [PUBLIC_KEY_TYPE_ED25519: 0]

  @enum_spec %XDR.Enum{declarations: @declarations, identifier: nil}

  @type t :: %__MODULE__{identifier: atom()}

  defstruct [:declarations, :identifier]

  @spec new(type :: atom()) :: t()
  def new(type \\ :PUBLIC_KEY_TYPE_ED25519),
    do: %__MODULE__{identifier: type, declarations: @declarations}

  @impl true
  def encode_xdr(%__MODULE__{identifier: type}) do
    XDR.Enum.encode_xdr(%XDR.Enum{declarations: @declarations, identifier: type})
  end

  @impl true
  def encode_xdr!(%__MODULE__{identifier: type}) do
    XDR.Enum.encode_xdr!(%XDR.Enum{declarations: @declarations, identifier: type})
  end

  @impl true
  def decode_xdr(bytes, spec \\ @enum_spec)

  def decode_xdr(bytes, spec) do
    case XDR.Enum.decode_xdr(bytes, spec) do
      {:ok, {%XDR.Enum{identifier: type}, rest}} -> {:ok, {new(type), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, spec \\ @enum_spec)

  def decode_xdr!(bytes, spec) do
    {%XDR.Enum{identifier: type}, rest} = XDR.Enum.decode_xdr!(bytes, spec)
    {new(type), rest}
  end
end
