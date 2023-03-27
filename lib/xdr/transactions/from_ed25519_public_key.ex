defmodule StellarBase.XDR.FromEd25519PublicKey do
  @moduledoc """
  Representation of Stellar `FromEd25519PublicKey` type.
  """
  alias StellarBase.XDR.{Signature, UInt256}

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(
                 key: UInt256,
                 signature: Signature,
                 salt: UInt256
               )

  @type t :: %__MODULE__{
          key: UInt256.t(),
          signature: Signature.t(),
          salt: UInt256.t()
        }

  defstruct [:key, :signature, :salt]

  @spec new(
          key :: UInt256.t(),
          signature :: Signature.t(),
          salt :: UInt256.t()
        ) :: t()
  def new(%UInt256{} = key, %Signature{} = signature, %UInt256{} = salt),
    do: %__MODULE__{
      key: key,
      signature: signature,
      salt: salt
    }

  @impl true
  def encode_xdr(%__MODULE__{
        key: key,
        signature: signature,
        salt: salt
      }) do
    [key: key, signature: signature, salt: salt]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{
        key: key,
        signature: signature,
        salt: salt
      }) do
    [key: key, signature: signature, salt: salt]
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
            key: key,
            signature: signature,
            salt: salt
          ]
        }, rest}} ->
        {:ok, {new(key, signature, salt), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{
       components: [
         key: key,
         signature: signature,
         salt: salt
       ]
     }, rest} = XDR.Struct.decode_xdr!(bytes, struct)

    {new(key, signature, salt), rest}
  end
end
