defmodule StellarBase.XDR.SCContractCode do
  @moduledoc """
  Representation of Stellar `SCContractCode` type.
  """

  alias StellarBase.XDR.{Hash, SCContractCodeType, Void}

  @behaviour XDR.Declaration

  @arms [
    SCCONTRACT_CODE_WASM_REF: Hash,
    SCCONTRACT_CODE_TOKEN: Void
  ]

  @type contract_code :: Hash.t() | Void.t()

  @type t :: %__MODULE__{contract_code: contract_code(), type: SCContractCodeType.t()}

  defstruct [:contract_code, :type]

  @spec new(contract_code :: contract_code(), type :: SCContractCodeType.t()) :: t()
  def new(contract_code, %SCContractCodeType{} = type),
    do: %__MODULE__{contract_code: contract_code, type: type}

  @impl true
  def encode_xdr(%__MODULE__{contract_code: contract_code, type: type}) do
    type
    |> XDR.Union.new(@arms, contract_code)
    |> XDR.Union.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{contract_code: contract_code, type: type}) do
    type
    |> XDR.Union.new(@arms, contract_code)
    |> XDR.Union.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, spec \\ union_spec())

  def decode_xdr(bytes, spec) do
    case XDR.Union.decode_xdr(bytes, spec) do
      {:ok, {{type, contract_code}, rest}} -> {:ok, {new(contract_code, type), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, spec \\ union_spec())

  def decode_xdr!(bytes, spec) do
    {{type, contract_code}, rest} = XDR.Union.decode_xdr!(bytes, spec)
    {new(contract_code, type), rest}
  end

  @spec union_spec() :: XDR.Union.t()
  defp union_spec do
    nil
    |> SCContractCodeType.new()
    |> XDR.Union.new(@arms)
  end
end
