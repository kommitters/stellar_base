defmodule Stellar.XDR.Operations.ClaimClaimableBalanceResult do
  @moduledoc """
  Representation of Stellar `ClaimClaimableBalanceResult` type.
  """
  alias Stellar.XDR.Void
  alias Stellar.XDR.Operations.ClaimClaimableBalanceResultCode

  @behaviour XDR.Declaration

  @arms [CLAIM_CLAIMABLE_BALANCE_SUCCESS: Void, default: Void]

  @type t :: %__MODULE__{result: any(), code: ClaimClaimableBalanceResultCode.t()}

  defstruct [:result, :code]

  @spec new(result :: any(), code :: ClaimClaimableBalanceResultCode.t()) :: t()
  def new(result, %ClaimClaimableBalanceResultCode{} = code),
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
    |> ClaimClaimableBalanceResultCode.new()
    |> XDR.Union.new(@arms)
  end
end
