defmodule StellarBase.XDR.Operations.AccountMergeResultCode do
  @moduledoc """
  Representation of Stellar `AccountMergeResultCode` type.
  """

  @behaviour XDR.Declaration

  @declarations [
    # success
    ACCOUNT_MERGE_SUCCESS: 0,
    # can't merge onto itself
    ACCOUNT_MERGE_MALFORMED: -1,
    # destination does not exist
    ACCOUNT_MERGE_NO_ACCOUNT: -2,
    # source account has AUTH_IMMUTABLE set
    ACCOUNT_MERGE_IMMUTABLE_SET: -3,
    # account has trust lines/offers
    ACCOUNT_MERGE_HAS_SUB_ENTRIES: -4,
    # sequence number is over max allowed
    ACCOUNT_MERGE_SEQNUM_TOO_FAR: -5,
    # can't add source balance to destination balance
    ACCOUNT_MERGE_DEST_FULL: -6,
    # can't merge account that is a sponsor
    ACCOUNT_MERGE_IS_SPONSOR: -7
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
