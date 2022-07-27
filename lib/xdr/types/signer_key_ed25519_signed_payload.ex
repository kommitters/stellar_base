defmodule StellarBase.XDR.SignerKeyEd25519SignedPayload do
  @moduledoc """
  Representation of Stellar `Signer key ed25519 signed payload signer` type.
  """

  alias StellarBase.XDR.{UInt256, VariableOpaque64}

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(
                 ed25519: UInt256,
                 payload: VariableOpaque64
               )

  @type t :: %__MODULE__{
          ed25519: UInt256.t(),
          payload: VariableOpaque64.t()
        }

  defstruct [:ed25519, :payload]

  @spec new(
          ed25519 :: UInt256.t(),
          payload :: VariableOpaque64.t()
        ) :: t()
  def new(
        %UInt256{} = ed25519,
        %VariableOpaque64{} = payload
      ),
      do: %__MODULE__{ed25519: ed25519, payload: payload}

  @impl true
  def encode_xdr(%__MODULE__{ed25519: ed25519, payload: payload}) do
    [ed25519: ed25519, payload: payload]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{ed25519: ed25519, payload: payload}) do
    [ed25519: ed25519, payload: payload]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, struct \\ @struct_spec)

  def decode_xdr(bytes, struct) do
    case XDR.Struct.decode_xdr(bytes, struct) do
      {:ok, {%XDR.Struct{components: [ed25519: ed25519, payload: payload]}, rest}} ->
        {:ok, {new(ed25519, payload), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{components: [ed25519: ed25519, payload: payload]}, rest} =
      XDR.Struct.decode_xdr!(bytes, struct)

    {new(ed25519, payload), rest}
  end
end
