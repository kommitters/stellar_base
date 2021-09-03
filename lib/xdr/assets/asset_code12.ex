defmodule Stellar.XDR.AssetCode12 do
  @moduledoc """
  Representation of Stellar `AssetCode12` type.
  """
  @behaviour XDR.Declaration

  @type t :: %__MODULE__{code: String.t()}

  defstruct [:code]

  @max_size 12

  @opaque_spec XDR.VariableOpaque.new(nil, @max_size)

  @spec new(code :: String.t()) :: t()
  def new(code), do: %__MODULE__{code: code}

  @impl true
  def encode_xdr(%__MODULE__{code: code}) do
    code
    |> XDR.VariableOpaque.new(@max_size)
    |> XDR.VariableOpaque.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{code: code}) do
    code
    |> XDR.VariableOpaque.new(@max_size)
    |> XDR.VariableOpaque.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, spec \\ @opaque_spec)

  def decode_xdr(bytes, spec) do
    case XDR.VariableOpaque.decode_xdr(bytes, spec) do
      {:ok, {%XDR.VariableOpaque{opaque: code}, rest}} -> {:ok, {new(code), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, spec \\ @opaque_spec)

  def decode_xdr!(bytes, spec) do
    {%XDR.VariableOpaque{opaque: code}, rest} = XDR.VariableOpaque.decode_xdr!(bytes, spec)
    {new(code), rest}
  end
end
