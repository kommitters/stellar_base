defmodule StellarBase.XDR.Ed25519KeyWithSignature do
  @moduledoc """
  Representation of Stellar `Ed25519KeyWithSignature` type.
  """
  alias StellarBase.XDR.{Signature, UInt256}

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(
                 signature: Signature,
                 key: UInt256
               )

  @type t :: %__MODULE__{
          signature: Signature.t(),
          key: UInt256.t()
        }

  defstruct [:signature, :key]

  @spec new(
          signature :: Signature.t(),
          key :: UInt256.t()
        ) :: t()
  def new(%Signature{} = signature, %UInt256{} = key),
    do: %__MODULE__{
      signature: signature,
      key: key
    }

  @impl true
  def encode_xdr(%__MODULE__{
        signature: signature,
        key: key
      }) do
    [signature: signature, key: key]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{
        signature: signature,
        key: key
      }) do
    [signature: signature, key: key]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, struct \\ @struct_spec)

  def decode_xdr(bytes, struct) do
    case XDR.Struct.decode_xdr(bytes, struct) do
      {:ok,
       {%XDR.Struct{
          components: [
            signature: signature,
            key: key
          ]
        }, rest}} ->
        {:ok, {new(signature, key), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{
       components: [
         signature: signature,
         key: key
       ]
     }, rest} = XDR.Struct.decode_xdr!(bytes, struct)

    {new(signature, key), rest}
  end
end
