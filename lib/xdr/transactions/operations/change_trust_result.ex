defmodule StellarBase.XDR.Operations.ChangeTrustResult do
  @moduledoc """
  Representation of Stellar `ChangeTrustResult` type.
  """
  alias StellarBase.XDR.Void
  alias StellarBase.XDR.Operations.ChangeTrustResultCode

  @behaviour XDR.Declaration

  @arms [CHANGE_TRUST_SUCCESS: Void, default: Void]

  @type t :: %__MODULE__{result: any(), code: ChangeTrustResultCode.t()}

  defstruct [:result, :code]

  @spec new(result :: any(), code :: ChangeTrustResultCode.t()) :: t()
  def new(result, %ChangeTrustResultCode{} = code), do: %__MODULE__{result: result, code: code}

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
    |> ChangeTrustResultCode.new()
    |> XDR.Union.new(@arms)
  end
end
