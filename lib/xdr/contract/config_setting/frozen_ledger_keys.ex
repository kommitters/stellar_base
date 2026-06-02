defmodule StellarBase.XDR.FrozenLedgerKeys do
  @moduledoc """
  Representation of Stellar `FrozenLedgerKeys` type.
  """

  @behaviour XDR.Declaration

  alias StellarBase.XDR.EncodedLedgerKeyList

  @struct_spec XDR.Struct.new(keys: EncodedLedgerKeyList)

  @type keys_type :: EncodedLedgerKeyList.t()

  @type t :: %__MODULE__{keys: keys_type()}

  defstruct [:keys]

  @spec new(keys :: keys_type()) :: t()
  def new(%EncodedLedgerKeyList{} = keys),
    do: %__MODULE__{keys: keys}

  @impl true
  def encode_xdr(%__MODULE__{keys: keys}) do
    [keys: keys]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{keys: keys}) do
    [keys: keys]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, struct \\ @struct_spec)

  def decode_xdr(bytes, struct) do
    case XDR.Struct.decode_xdr(bytes, struct) do
      {:ok, {%XDR.Struct{components: [keys: keys]}, rest}} ->
        {:ok, {new(keys), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{components: [keys: keys]}, rest} =
      XDR.Struct.decode_xdr!(bytes, struct)

    {new(keys), rest}
  end
end
