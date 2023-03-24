defmodule StellarBase.XDR.CreateContractSource do
  @moduledoc """
  Representation of Stellar `CreateContractSource` type.
  """

  alias StellarBase.XDR.{SCContractCode, CreateContractSourceType, InstallContractCodeArgs}

  @behaviour XDR.Declaration

  @arms [
    CONTRACT_SOURCE_REF: SCContractCode,
    CONTRACT_SOURCE_INSTALLED: InstallContractCodeArgs
  ]

  @type contract_source :: SCContractCode.t() | InstallContractCodeArgs.t()

  @type t :: %__MODULE__{contract_source: contract_source(), type: CreateContractSourceType.t()}

  defstruct [:contract_source, :type]

  @spec new(contract_source :: contract_source(), type :: CreateContractSourceType.t()) :: t()
  def new(contract_source, %CreateContractSourceType{} = type),
    do: %__MODULE__{contract_source: contract_source, type: type}

  @impl true
  def encode_xdr(%__MODULE__{contract_source: contract_source, type: type}) do
    type
    |> XDR.Union.new(@arms, contract_source)
    |> XDR.Union.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{contract_source: contract_source, type: type}) do
    type
    |> XDR.Union.new(@arms, contract_source)
    |> XDR.Union.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, spec \\ union_spec())

  def decode_xdr(bytes, spec) do
    case XDR.Union.decode_xdr(bytes, spec) do
      {:ok, {{type, contract_source}, rest}} -> {:ok, {new(contract_source, type), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, spec \\ union_spec())

  def decode_xdr!(bytes, spec) do
    {{type, contract_source}, rest} = XDR.Union.decode_xdr!(bytes, spec)
    {new(contract_source, type), rest}
  end

  @spec union_spec() :: XDR.Union.t()
  defp union_spec do
    nil
    |> CreateContractSourceType.new()
    |> XDR.Union.new(@arms)
  end
end
