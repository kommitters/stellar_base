defmodule StellarBase.XDR.ClaimableBalanceEntryExtV1 do
  @moduledoc """
  Representation of Stellar `ClaimableBalanceEntryExtV1` type.
  """
  alias StellarBase.XDR.{Ext, UInt32}

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(ext: Ext, flags: UInt32)

  @type t :: %__MODULE__{ext: Ext.t(), flags: UInt32.t()}

  defstruct [:ext, :flags]

  @spec new(ext :: Ext.t(), flags :: UInt32.t()) :: t()
  def new(%Ext{} = ext, %UInt32{} = flags), do: %__MODULE__{ext: ext, flags: flags}

  @impl true
  def encode_xdr(%__MODULE__{ext: ext, flags: flags}) do
    [ext: ext, flags: flags]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{ext: ext, flags: flags}) do
    [ext: ext, flags: flags]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, struct \\ @struct_spec)

  def decode_xdr(bytes, struct) do
    case XDR.Struct.decode_xdr(bytes, struct) do
      {:ok, {%XDR.Struct{components: [ext: ext, flags: flags]}, rest}} ->
        {:ok, {new(ext, flags), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{components: [ext: ext, flags: flags]}, rest} =
      XDR.Struct.decode_xdr!(bytes, struct)

    {new(ext, flags), rest}
  end
end
