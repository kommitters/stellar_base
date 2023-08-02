defmodule StellarBase.XDR.OperationResult do
  @moduledoc """
  Representation of Stellar `OperationResult` type.
  """
  alias StellarBase.XDR.{OperationResultTr, OperationResultCode, Void}

  @behaviour XDR.Declaration

  @arms [opINNER: OperationResultTr, default: Void]

  @type result :: OperationResultTr.t() | Void.t() | any()

  @type t :: %__MODULE__{result: result(), code: OperationResultCode.t()}

  defstruct [:result, :code]

  @spec new(result :: result(), code :: OperationResultCode.t()) :: t()
  def new(result, %OperationResultCode{} = code), do: %__MODULE__{result: result, code: code}

  @impl true
  def encode_xdr(%__MODULE__{result: result, code: code}) do
    code
    |> XDR.Union.new(@arms, result)
    |> XDR.Union.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{result: result, code: code}) do
    code
    |> XDR.Union.new(@arms, result)
    |> XDR.Union.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, spec \\ union_spec())

  def decode_xdr(bytes, spec) do
    case XDR.Union.decode_xdr(bytes, spec) do
      {:ok, {{code, result}, rest}} -> {:ok, {new(result, code), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, spec \\ union_spec())

  def decode_xdr!(bytes, spec) do
    {{code, result}, rest} = XDR.Union.decode_xdr!(bytes, spec)
    {new(result, code), rest}
  end

  @spec union_spec() :: XDR.Union.t()
  defp union_spec do
    nil
    |> OperationResultCode.new()
    |> XDR.Union.new(@arms)
  end
end
