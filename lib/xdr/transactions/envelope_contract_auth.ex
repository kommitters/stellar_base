defmodule StellarBase.XDR.EnvelopeContractAuth do
  @moduledoc """
  Representation of Stellar `EnvelopeContractAuth` type.
  """
  alias StellarBase.XDR.{Hash, UInt64, AuthorizedInvocation}

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(
                 network_id: Hash,
                 nonce: UInt64,
                 invocation: AuthorizedInvocation
               )

  @type t :: %__MODULE__{
          network_id: Hash.t(),
          nonce: UInt64.t(),
          invocation: AuthorizedInvocation.t()
        }

  defstruct [:network_id, :nonce, :invocation]

  @spec new(
          network_id :: Hash.t(),
          nonce :: UInt64.t(),
          invocation :: AuthorizedInvocation.t()
        ) :: t()
  def new(
        %Hash{} = network_id,
        %UInt64{} = nonce,
        %AuthorizedInvocation{} = invocation
      ) do
    %__MODULE__{
      network_id: network_id,
      nonce: nonce,
      invocation: invocation
    }
  end

  @impl true
  def encode_xdr(%__MODULE__{
        network_id: network_id,
        nonce: nonce,
        invocation: invocation
      }) do
    [
      network_id: network_id,
      nonce: nonce,
      invocation: invocation
    ]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{
        network_id: network_id,
        nonce: nonce,
        invocation: invocation
      }) do
    [
      network_id: network_id,
      nonce: nonce,
      invocation: invocation
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
            network_id: network_id,
            nonce: nonce,
            invocation: invocation
          ]
        }, rest}} ->
        {:ok, {new(network_id, nonce, invocation), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{
       components: [
         network_id: network_id,
         nonce: nonce,
         invocation: invocation
       ]
     }, rest} = XDR.Struct.decode_xdr!(bytes, struct)

    {new(network_id, nonce, invocation), rest}
  end
end
