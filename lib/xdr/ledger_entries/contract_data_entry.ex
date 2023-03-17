defmodule StellarBase.XDR.ContractDataEntry do
  @moduledoc """
  Representation of Stellar `ContractDataEntry` type.
  """

  alias StellarBase.XDR.{Hash, SCVal}

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(contract_id: Hash, key: SCVal, val: SCVal)

  @type t :: %__MODULE__{contract_id: Hash.t(), key: SCVal.t(), val: SCVal.t()}

  defstruct [:contract_id, :key, :val]

  @spec new(contract_id :: Hash.t(), key :: SCVal.t(), val :: SCVal.t()) :: t()
  def new(%Hash{} = contract_id, %SCVal{} = key, %SCVal{} = val),
    do: %__MODULE__{contract_id: contract_id, key: key, val: val}

  @impl true
  def encode_xdr(%__MODULE__{contract_id: contract_id, key: key, val: val}) do
    [contract_id: contract_id, key: key, val: val]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{contract_id: contract_id, key: key, val: val}) do
    [contract_id: contract_id, key: key, val: val]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, struct \\ @struct_spec)

  def decode_xdr(bytes, struct) do
    case XDR.Struct.decode_xdr(bytes, struct) do
      {:ok, {%XDR.Struct{components: [contract_id: contract_id, key: key, val: val]}, rest}} ->
        {:ok, {new(contract_id, key, val), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{components: [contract_id: contract_id, key: key, val: val]}, rest} =
      XDR.Struct.decode_xdr!(bytes, struct)

    {new(contract_id, key, val), rest}
  end
end
