defmodule StellarBase.XDR.DecoratedSignature do
  @moduledoc """
  Representation of Stellar `DecoratedSignature` type.
  """
  alias StellarBase.XDR.{Signature, SignatureHint}

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(hint: SignatureHint, signature: Signature)

  @type t :: %__MODULE__{hint: SignatureHint.t(), signature: Signature.t()}

  defstruct [:hint, :signature]

  @spec new(hint :: SignatureHint.t(), signature :: Signature.t()) :: t()
  def new(%SignatureHint{} = hint, %Signature{} = signature),
    do: %__MODULE__{hint: hint, signature: signature}

  @impl true
  def encode_xdr(%__MODULE__{hint: hint, signature: signature}) do
    [hint: hint, signature: signature]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{hint: hint, signature: signature}) do
    [hint: hint, signature: signature]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, struct \\ @struct_spec)

  def decode_xdr(bytes, struct) do
    case XDR.Struct.decode_xdr(bytes, struct) do
      {:ok, {%XDR.Struct{components: [hint: hint, signature: signature]}, rest}} ->
        {:ok, {new(hint, signature), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{components: [hint: hint, signature: signature]}, rest} =
      XDR.Struct.decode_xdr!(bytes, struct)

    {new(hint, signature), rest}
  end
end
