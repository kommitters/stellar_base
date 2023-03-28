defmodule StellarBase.XDR.CreateContractArgs do
  @moduledoc """
  Representation of Stellar `CreateContractArgs` type.
  """
  alias StellarBase.XDR.{ContractID, SCContractCode}

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(contract_id: ContractID, source: SCContractCode)

  @type t :: %__MODULE__{contract_id: ContractID.t(), source: SCContractCode.t()}

  defstruct [:contract_id, :source]

  @spec new(contract_id :: ContractID.t(), source :: SCContractCode.t()) :: t()
  def new(%ContractID{} = contract_id, %SCContractCode{} = source),
    do: %__MODULE__{contract_id: contract_id, source: source}

  @impl true
  def encode_xdr(%__MODULE__{contract_id: contract_id, source: source}) do
    [contract_id: contract_id, source: source]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{contract_id: contract_id, source: source}) do
    [contract_id: contract_id, source: source]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, struct \\ @struct_spec)

  def decode_xdr(bytes, struct) do
    case XDR.Struct.decode_xdr(bytes, struct) do
      {:ok, {%XDR.Struct{components: [contract_id: contract_id, source: source]}, rest}} ->
        {:ok, {new(contract_id, source), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{components: [contract_id: contract_id, source: source]}, rest} =
      XDR.Struct.decode_xdr!(bytes, struct)

    {new(contract_id, source), rest}
  end
end
