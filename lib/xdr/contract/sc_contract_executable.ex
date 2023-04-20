defmodule StellarBase.XDR.SCContractExecutable do
  @moduledoc """
  Representation of Stellar `SCContractExecutable` type.
  """

  alias StellarBase.XDR.{Hash, SCContractExecutableType, Void}

  @behaviour XDR.Declaration

  @arms [
    SCCONTRACT_EXECUTABLE_WASM_REF: Hash,
    SCCONTRACT_EXECUTABLE_TOKEN: Void
  ]

  @type contract_executable :: Hash.t() | Void.t()

  @type t :: %__MODULE__{
          contract_executable: contract_executable(),
          type: SCContractExecutableType.t()
        }

  defstruct [:contract_executable, :type]

  @spec new(contract_executable :: contract_executable(), type :: SCContractExecutableType.t()) ::
          t()
  def new(contract_executable, %SCContractExecutableType{} = type),
    do: %__MODULE__{contract_executable: contract_executable, type: type}

  @impl true
  def encode_xdr(%__MODULE__{contract_executable: contract_executable, type: type}) do
    type
    |> XDR.Union.new(@arms, contract_executable)
    |> XDR.Union.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{contract_executable: contract_executable, type: type}) do
    type
    |> XDR.Union.new(@arms, contract_executable)
    |> XDR.Union.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, spec \\ union_spec())

  def decode_xdr(bytes, spec) do
    case XDR.Union.decode_xdr(bytes, spec) do
      {:ok, {{type, contract_executable}, rest}} -> {:ok, {new(contract_executable, type), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, spec \\ union_spec())

  def decode_xdr!(bytes, spec) do
    {{type, contract_executable}, rest} = XDR.Union.decode_xdr!(bytes, spec)
    {new(contract_executable, type), rest}
  end

  @spec union_spec() :: XDR.Union.t()
  defp union_spec do
    nil
    |> SCContractExecutableType.new()
    |> XDR.Union.new(@arms)
  end
end
