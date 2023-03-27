defmodule StellarBase.XDR.InvokeHostFunctionResult do
  @moduledoc """
  Representation of Stellar `InvokeHostFunctionResult` type.
  """
  alias StellarBase.XDR.{InvokeHostFunctionResultCode, SCVal, Void}

  @behaviour XDR.Declaration

  @arms [
    INVOKE_HOST_FUNCTION_SUCCESS: SCVal,
    INVOKE_HOST_FUNCTION_MALFORMED: Void,
    INVOKE_HOST_FUNCTION_TRAPPED: Void
  ]

  @type invoke_host_function_result_value :: SCVal.t() | Void.t()

  @type t :: %__MODULE__{
          value: invoke_host_function_result_value(),
          code: InvokeHostFunctionResultCode.t()
        }

  defstruct [:value, :code]

  @spec new(
          value :: invoke_host_function_result_value(),
          type :: InvokeHostFunctionResultCode.t()
        ) :: t()
  def new(value, %InvokeHostFunctionResultCode{} = code),
    do: %__MODULE__{value: value, code: code}

  @impl true
  def encode_xdr(%__MODULE__{value: value, code: code}) do
    code
    |> XDR.Union.new(@arms, value)
    |> XDR.Union.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{value: value, code: code}) do
    code
    |> XDR.Union.new(@arms, value)
    |> XDR.Union.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, spec \\ union_spec())

  def decode_xdr(bytes, spec) do
    case XDR.Union.decode_xdr(bytes, spec) do
      {:ok, {{code, value}, rest}} -> {:ok, {new(value, code), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, spec \\ union_spec())

  def decode_xdr!(bytes, spec) do
    {{code, value}, rest} = XDR.Union.decode_xdr!(bytes, spec)
    {new(value, code), rest}
  end

  @spec union_spec() :: XDR.Union.t()
  defp union_spec do
    nil
    |> InvokeHostFunctionResultCode.new()
    |> XDR.Union.new(@arms)
  end
end
