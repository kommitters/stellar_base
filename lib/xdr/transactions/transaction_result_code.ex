defmodule StellarBase.XDR.TransactionResultCode do
  @moduledoc """
  Representation of Stellar `TransactionResultCode` type.
  """
  @behaviour XDR.Declaration

  @declarations [
    # fee bump inner transaction succeeded
    txFEE_BUMP_INNER_SUCCESS: 1,
    # all operations succeeded
    txSUCCESS: 0,
    # one of the operations failed (none were applied)
    txFAILED: -1,
    # ledger closeTime before minTime
    txTOO_EARLY: -2,
    # ledger closeTime after maxTime
    txTOO_LATE: -3,
    # no operation was specified
    txMISSING_OPERATION: -4,
    # sequence number does not match source account
    txBAD_SEQ: -5,
    # too few valid signatures / wrong network
    txBAD_AUTH: -6,
    # fee would bring account below reserve
    txINSUFFICIENT_BALANCE: -7,
    # source account not found
    txNO_ACCOUNT: -8,
    # fee is too small
    txINSUFFICIENT_FEE: -9,
    # unused signatures attached to transaction
    txBAD_AUTH_EXTRA: -10,
    # an unknown error occurred
    txINTERNAL_ERROR: -11,
    # transaction type not supported
    txNOT_SUPPORTED: -12,
    # fee bump inner transaction failed
    txFEE_BUMP_INNER_FAILED: -13,
    # sponsorship not confirmed
    txBAD_SPONSORSHIP: -14
  ]

  @enum_spec %XDR.Enum{declarations: @declarations, identifier: nil}

  @type t :: %__MODULE__{identifier: atom()}

  defstruct [:identifier]

  @spec new(code :: atom()) :: t()
  def new(code), do: %__MODULE__{identifier: code}

  @impl true
  def encode_xdr(%__MODULE__{identifier: code}) do
    @declarations
    |> XDR.Enum.new(code)
    |> XDR.Enum.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{identifier: code}) do
    @declarations
    |> XDR.Enum.new(code)
    |> XDR.Enum.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, spec \\ @enum_spec)

  def decode_xdr(bytes, spec) do
    case XDR.Enum.decode_xdr(bytes, spec) do
      {:ok, {%XDR.Enum{identifier: code}, rest}} -> {:ok, {new(code), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, spec \\ @enum_spec)

  def decode_xdr!(bytes, spec) do
    {%XDR.Enum{identifier: code}, rest} = XDR.Enum.decode_xdr!(bytes, spec)
    {new(code), rest}
  end
end
