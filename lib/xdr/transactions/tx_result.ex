defmodule StellarBase.XDR.TxResult do
  @moduledoc """
  Representation of Stellar `TxResult` type.
  """
  alias StellarBase.XDR.{
    InnerTransactionResultPair,
    OperationResultList,
    TransactionResultCode,
    Void
  }

  @behaviour XDR.Declaration

  @arms [
    txFEE_BUMP_INNER_SUCCESS: InnerTransactionResultPair,
    txFEE_BUMP_INNER_FAILED: InnerTransactionResultPair,
    txSUCCESS: OperationResultList,
    txFAILED: OperationResultList,
    default: Void
  ]

  @type result :: InnerTransactionResultPair.t() | OperationResultList.t() | Void.t() | any()

  @type t :: %__MODULE__{result: result(), code: TransactionResultCode.t()}

  defstruct [:result, :code]

  @spec new(result :: result(), code :: TransactionResultCode.t()) :: t()
  def new(result, %TransactionResultCode{} = code),
    do: %__MODULE__{result: result, code: code}

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
    |> TransactionResultCode.new()
    |> XDR.Union.new(@arms)
  end
end
