defmodule Stellar.XDR.MuxedAccountMed25519 do
  @moduledoc """
  Representation of Stellar `MuxedAccountMed25519` type.
  """
  alias Stellar.XDR.{UInt64, UInt256}

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(id: UInt64, ed25519: UInt256)

  @type t :: %__MODULE__{id: UInt64.t(), ed25519: UInt256.t()}

  defstruct [:id, :ed25519]

  @spec new(id :: UInt64.t(), ed25519 :: UInt256.t()) :: t()
  def new(%UInt64{} = id, %UInt256{} = ed25519), do: %__MODULE__{id: id, ed25519: ed25519}

  @impl true
  def encode_xdr(%__MODULE__{id: id, ed25519: ed25519}) do
    [id: id, ed25519: ed25519]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{id: id, ed25519: ed25519}) do
    [id: id, ed25519: ed25519]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, struct \\ @struct_spec)

  def decode_xdr(bytes, struct) do
    case XDR.Struct.decode_xdr(bytes, struct) do
      {:ok, {%XDR.Struct{components: [id: id, ed25519: ed25519]}, rest}} ->
        {:ok, {new(id, ed25519), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{components: [id: id, ed25519: ed25519]}, rest} =
      XDR.Struct.decode_xdr!(bytes, struct)

    {new(id, ed25519), rest}
  end
end
