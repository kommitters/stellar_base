defmodule StellarBase.XDR.ContractData do
  @moduledoc """
  Representation of Stellar `ContractData` type.
  """

  alias StellarBase.XDR.{Hash, SCVal}

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(contract_id: Hash, key: SCVal)

  @type t :: %__MODULE__{contract_id: Hash.t(), key: SCVal.t()}

  defstruct [:contract_id, :key]

  @spec new(contract_id :: Hash.t(), key :: SCVal.t()) :: t()
  def new(%Hash{} = contract_id, %SCVal{} = key),
    do: %__MODULE__{contract_id: contract_id, key: key}

  @impl true
  def encode_xdr(%__MODULE__{contract_id: contract_id, key: key}) do
    [contract_id: contract_id, key: key]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{contract_id: contract_id, key: key}) do
    [contract_id: contract_id, key: key]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, struct \\ @struct_spec)

  def decode_xdr(bytes, struct) do
    case XDR.Struct.decode_xdr(bytes, struct) do
      {:ok, {%XDR.Struct{components: [contract_id: contract_id, key: key]}, rest}} ->
        {:ok, {new(contract_id, key), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{components: [contract_id: contract_id, key: key]}, rest} =
      XDR.Struct.decode_xdr!(bytes, struct)

    {new(contract_id, key), rest}
  end
end
