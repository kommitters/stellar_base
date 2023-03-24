defmodule StellarBase.XDR.ContractPublicKey do
  @moduledoc """
  Representation of Stellar `ContractPublicKey` type.
  """

  alias StellarBase.XDR.{UInt256, ContractIDPublicKey}

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(key_source: ContractIDPublicKey, salt: UInt256)

  @type t :: %__MODULE__{key_source: ContractIDPublicKey.t(), salt: UInt256.t()}

  defstruct [:key_source, :salt]

  @spec new(key_source :: ContractIDPublicKey.t(), salt :: UInt256.t()) :: t()
  def new(%ContractIDPublicKey{} = key_source, %UInt256{} = salt),
    do: %__MODULE__{key_source: key_source, salt: salt}

  @impl true
  def encode_xdr(%__MODULE__{key_source: key_source, salt: salt}) do
    [key_source: key_source, salt: salt]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{key_source: key_source, salt: salt}) do
    [key_source: key_source, salt: salt]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, struct \\ @struct_spec)

  def decode_xdr(bytes, struct) do
    case XDR.Struct.decode_xdr(bytes, struct) do
      {:ok, {%XDR.Struct{components: [key_source: key_source, salt: salt]}, rest}} ->
        {:ok, {new(key_source, salt), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{components: [key_source: key_source, salt: salt]}, rest} =
      XDR.Struct.decode_xdr!(bytes, struct)

    {new(key_source, salt), rest}
  end
end
