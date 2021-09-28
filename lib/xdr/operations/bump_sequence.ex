defmodule Stellar.XDR.Operations.BumpSequence do
  @moduledoc """
  Representation of Stellar `BumpSequence` type.
  """
  alias Stellar.XDR.SequenceNumber

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(bump_to: SequenceNumber)

  @type t :: %__MODULE__{bump_to: SequenceNumber.t()}

  defstruct [:bump_to]

  @spec new(bump_to :: SequenceNumber.t()) :: t()
  def new(%SequenceNumber{} = bump_to),
    do: %__MODULE__{bump_to: bump_to}

  @impl true
  def encode_xdr(%__MODULE__{bump_to: bump_to}) do
    [bump_to: bump_to]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{bump_to: bump_to}) do
    [bump_to: bump_to]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, struct \\ @struct_spec)

  def decode_xdr(bytes, struct) do
    case XDR.Struct.decode_xdr(bytes, struct) do
      {:ok, {%XDR.Struct{components: [bump_to: bump_to]}, rest}} ->
        {:ok, {new(bump_to), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{components: [bump_to: bump_to]}, rest} = XDR.Struct.decode_xdr!(bytes, struct)

    {new(bump_to), rest}
  end
end
