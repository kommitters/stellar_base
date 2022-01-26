defmodule StellarBase.XDR.UInt256 do
  @moduledoc """
  Representation of Stellar `UInt256` type.
  """
  alias StellarBase.XDR.Opaque32

  @behaviour XDR.Declaration

  @type t :: %__MODULE__{datum: binary()}

  defstruct [:datum]

  @spec new(uint256 :: binary()) :: t()
  def new(uint256), do: %__MODULE__{datum: uint256}

  @impl true
  def encode_xdr(%__MODULE__{datum: uint256}) do
    Opaque32.encode_xdr(%Opaque32{opaque: uint256})
  end

  @impl true
  def encode_xdr!(%__MODULE__{datum: uint256}) do
    Opaque32.encode_xdr!(%Opaque32{opaque: uint256})
  end

  @impl true
  def decode_xdr(bytes, term \\ nil)

  def decode_xdr(bytes, _term) do
    case Opaque32.decode_xdr(bytes) do
      {:ok, {%Opaque32{opaque: uint256}, rest}} -> {:ok, {new(uint256), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, term \\ nil)

  def decode_xdr!(bytes, _term) do
    {%Opaque32{opaque: uint256}, rest} = Opaque32.decode_xdr!(bytes)
    {new(uint256), rest}
  end
end
