defmodule Stellar.XDR.DecoratedSignatures do
  @moduledoc """
  Representation of a Stellar `DecoratedSignatures` list.
  """
  alias Stellar.XDR.DecoratedSignature

  @behaviour XDR.Declaration

  @max_length 20

  @array_type DecoratedSignature

  @array_spec %{type: @array_type, max_length: @max_length}

  @type t :: %__MODULE__{signatures: list(DecoratedSignature.t())}

  defstruct [:signatures]

  @spec new(signatures :: list(DecoratedSignature.t())) :: t()
  def new(signatures), do: %__MODULE__{signatures: signatures}

  @impl true
  def encode_xdr(%__MODULE__{signatures: signatures}) do
    signatures
    |> XDR.VariableArray.new(@array_type, @max_length)
    |> XDR.VariableArray.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{signatures: signatures}) do
    signatures
    |> XDR.VariableArray.new(@array_type, @max_length)
    |> XDR.VariableArray.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, spec \\ @array_spec)

  def decode_xdr(bytes, spec) do
    case XDR.VariableArray.decode_xdr(bytes, spec) do
      {:ok, {signatures, rest}} -> {:ok, {new(signatures), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, spec \\ @array_spec)

  def decode_xdr!(bytes, spec) do
    {signatures, rest} = XDR.VariableArray.decode_xdr!(bytes, spec)
    {new(signatures), rest}
  end
end
