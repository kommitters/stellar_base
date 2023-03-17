defmodule StellarBase.XDR.ContractCode do
  @moduledoc """
  Representation of Stellar `ContractCode` type.
  """

  alias StellarBase.XDR.Hash

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(hash: Hash)

  @type t :: %__MODULE__{hash: Hash.t()}

  defstruct [:hash]

  @spec new(hash :: Hash.t()) :: t()
  def new(%Hash{} = hash), do: %__MODULE__{hash: hash}

  @impl true
  def encode_xdr(%__MODULE__{hash: hash}) do
    [hash: hash]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{hash: hash}) do
    [hash: hash]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, struct \\ @struct_spec)

  def decode_xdr(bytes, struct) do
    case XDR.Struct.decode_xdr(bytes, struct) do
      {:ok, {%XDR.Struct{components: [hash: hash]}, rest}} ->
        {:ok, {new(hash), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{components: [hash: hash]}, rest} = XDR.Struct.decode_xdr!(bytes, struct)

    {new(hash), rest}
  end
end
