defmodule StellarBase.XDR.HostFunction do
  @moduledoc """
  Representation of Stellar `HostFunction` type.
  """

  alias StellarBase.XDR.{SCVec, CreateContractArgs, InstallContractCodeArgs, HostFunctionType}

  @behaviour XDR.Declaration

  @arms [
    HOST_FUNCTION_TYPE_INVOKE_CONTRACT: SCVec,
    HOST_FUNCTION_TYPE_CREATE_CONTRACT: CreateContractArgs,
    HOST_FUNCTION_TYPE_INSTALL_CONTRACT_CODE: InstallContractCodeArgs
  ]

  @type host_function :: SCVec.t() | CreateContractArgs.t() | InstallContractCodeArgs.t()

  @type t :: %__MODULE__{host_function: host_function(), type: HostFunctionType.t()}

  defstruct [:host_function, :type]

  @spec new(host_function :: host_function(), type :: HostFunctionType.t()) :: t()
  def new(host_function, %HostFunctionType{} = type),
    do: %__MODULE__{host_function: host_function, type: type}

  @impl true
  def encode_xdr(%__MODULE__{host_function: host_function, type: type}) do
    type
    |> XDR.Union.new(@arms, host_function)
    |> XDR.Union.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{host_function: host_function, type: type}) do
    type
    |> XDR.Union.new(@arms, host_function)
    |> XDR.Union.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, spec \\ union_spec())

  def decode_xdr(bytes, spec) do
    case XDR.Union.decode_xdr(bytes, spec) do
      {:ok, {{type, host_function}, rest}} -> {:ok, {new(host_function, type), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, spec \\ union_spec())

  def decode_xdr!(bytes, spec) do
    {{type, host_function}, rest} = XDR.Union.decode_xdr!(bytes, spec)
    {new(host_function, type), rest}
  end

  @spec union_spec() :: XDR.Union.t()
  defp union_spec do
    nil
    |> HostFunctionType.new()
    |> XDR.Union.new(@arms)
  end
end
