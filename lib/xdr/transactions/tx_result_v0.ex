defmodule StellarBase.XDR.TxResultV0 do
  @moduledoc """
  Representation of Stellar `TxResultV0` type.
  """
  alias StellarBase.XDR.{OperationResultList, TransactionResultCode, Void}

  @behaviour XDR.Declaration

  @arms [
    txSUCCESS: OperationResultList,
    txFAILED: OperationResultList,
    txTOO_EARLY: Void,
    txTOO_LATE: Void,
    txMISSING_OPERATION: Void,
    txBAD_SEQ: Void,
    txBAD_AUTH: Void,
    txINSUFFICIENT_BALANCE: Void,
    txNO_ACCOUNT: Void,
    txINSUFFICIENT_FEE: Void,
    txBAD_AUTH_EXTRA: Void,
    txINTERNAL_ERROR: Void,
    txNOT_SUPPORTED: Void,
    # txFEE_BUMP_INNER_FAILED is not included
    txBAD_SPONSORSHIP: Void,
    txBAD_MIN_SEQ_AGE_OR_GAP: Void,
    txMALFORMED: Void
  ]

  @type t :: %__MODULE__{result: any(), code: TransactionResultCode.t()}

  defstruct [:result, :code]

  @spec new(result :: any(), code :: TransactionResultCode.t()) :: t()
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
