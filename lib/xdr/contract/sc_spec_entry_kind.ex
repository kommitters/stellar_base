defmodule StellarBase.XDR.SCSpecEntryKind do
  @moduledoc """
  Representation of Stellar `SCSpecEntryKind` type.
  """
  @behaviour XDR.Declaration

  @declarations [
    SC_SPEC_ENTRY_FUNCTION_V0: 0,
    SC_SPEC_ENTRY_UDT_STRUCT_V0: 1,
    SC_SPEC_ENTRY_UDT_UNION_V0: 2,
    SC_SPEC_ENTRY_UDT_ENUM_V0: 3,
    SC_SPEC_ENTRY_UDT_ERROR_ENUM_V0: 4
  ]

  @enum_spec %XDR.Enum{declarations: @declarations, identifier: nil}

  @type t :: %__MODULE__{identifier: atom()}

  defstruct [:identifier]

  @spec new(code :: atom()) :: t()
  def new(code), do: %__MODULE__{identifier: code}

  @impl true
  def encode_xdr(%__MODULE__{identifier: code}) do
    @declarations
    |> XDR.Enum.new(code)
    |> XDR.Enum.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{identifier: code}) do
    @declarations
    |> XDR.Enum.new(code)
    |> XDR.Enum.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, spec \\ @enum_spec)

  def decode_xdr(bytes, spec) do
    case XDR.Enum.decode_xdr(bytes, spec) do
      {:ok, {%XDR.Enum{identifier: code}, rest}} -> {:ok, {new(code), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, spec \\ @enum_spec)

  def decode_xdr!(bytes, spec) do
    {%XDR.Enum{identifier: code}, rest} = XDR.Enum.decode_xdr!(bytes, spec)
    {new(code), rest}
  end
end
