defmodule StellarBase.XDR.ContractAuth do
  @moduledoc """
  Representation of Stellar `ContractAuth` type.
  """
  alias StellarBase.XDR.{OptionalAddressWithNonce, AuthorizedInvocation, SCVec}

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(
                 address_with_nonce: OptionalAddressWithNonce,
                 authorized_invocation: AuthorizedInvocation,
                 signature_args: SCVec
               )

  @type t :: %__MODULE__{
          address_with_nonce: OptionalAddressWithNonce.t(),
          authorized_invocation: AuthorizedInvocation.t(),
          signature_args: SCVec.t()
        }

  defstruct [:address_with_nonce, :authorized_invocation, :signature_args]

  @spec new(
          address_with_nonce :: OptionalAddressWithNonce.t(),
          authorized_invocation :: AuthorizedInvocation.t(),
          signature_args :: SCVec.t()
        ) :: t()
  def new(
        %OptionalAddressWithNonce{} = address_with_nonce,
        %AuthorizedInvocation{} = authorized_invocation,
        %SCVec{} = signature_args
      ),
      do: %__MODULE__{
        address_with_nonce: address_with_nonce,
        authorized_invocation: authorized_invocation,
        signature_args: signature_args
      }

  @impl true
  def encode_xdr(%__MODULE__{
        address_with_nonce: address_with_nonce,
        authorized_invocation: authorized_invocation,
        signature_args: signature_args
      }) do
    [
      address_with_nonce: address_with_nonce,
      authorized_invocation: authorized_invocation,
      signature_args: signature_args
    ]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{
        address_with_nonce: address_with_nonce,
        authorized_invocation: authorized_invocation,
        signature_args: signature_args
      }) do
    [
      address_with_nonce: address_with_nonce,
      authorized_invocation: authorized_invocation,
      signature_args: signature_args
    ]
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
            address_with_nonce: address_with_nonce,
            authorized_invocation: authorized_invocation,
            signature_args: signature_args
          ]
        }, rest}} ->
        {:ok, {new(address_with_nonce, authorized_invocation, signature_args), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{
       components: [
         address_with_nonce: address_with_nonce,
         authorized_invocation: authorized_invocation,
         signature_args: signature_args
       ]
     }, rest} = XDR.Struct.decode_xdr!(bytes, struct)

    {new(address_with_nonce, authorized_invocation, signature_args), rest}
  end
end
