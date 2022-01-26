defmodule StellarBase.XDR.Operations.PathPaymentStrictSendResult do
  @moduledoc """
  Representation of Stellar `PathPaymentStrictSendResult` type.
  """
  alias StellarBase.XDR.{Asset, Void}

  alias StellarBase.XDR.Operations.{
    PathPaymentStrictSendResultCode,
    PathPaymentStrictResultSuccess
  }

  @behaviour XDR.Declaration

  @arms [
    PATH_PAYMENT_STRICT_SEND_SUCCESS: PathPaymentStrictResultSuccess,
    PATH_PAYMENT_STRICT_SEND_NO_ISSUER: Asset,
    default: Void
  ]

  @type result :: PathPaymentStrictResultSuccess.t() | Asset.t() | any()

  @type t :: %__MODULE__{result: result(), code: PathPaymentStrictSendResultCode.t()}

  defstruct [:result, :code]

  @spec new(result :: result(), code :: PathPaymentStrictSendResultCode.t()) :: t()
  def new(result, %PathPaymentStrictSendResultCode{} = code),
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
    |> PathPaymentStrictSendResultCode.new()
    |> XDR.Union.new(@arms)
  end
end
