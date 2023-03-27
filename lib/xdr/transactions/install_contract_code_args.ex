defmodule StellarBase.XDR.InstallContractCodeArgs do
  @moduledoc """
  Representation of Stellar `InstallContractCodeArgs` type.
  """

  alias StellarBase.XDR.VariableOpaque256000

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(code: VariableOpaque256000)

  @type t :: %__MODULE__{code: VariableOpaque256000.t()}

  defstruct [:code]

  @spec new(code :: VariableOpaque256000.t()) :: t()
  def new(%VariableOpaque256000{} = code), do: %__MODULE__{code: code}

  @impl true
  def encode_xdr(%__MODULE__{code: code}) do
    [code: code]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{code: code}) do
    [code: code]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, struct \\ @struct_spec)

  def decode_xdr(bytes, struct) do
    case XDR.Struct.decode_xdr(bytes, struct) do
      {:ok, {%XDR.Struct{components: [code: code]}, rest}} ->
        {:ok, {new(code), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{components: [code: code]}, rest} = XDR.Struct.decode_xdr!(bytes, struct)

    {new(code), rest}
  end
end
