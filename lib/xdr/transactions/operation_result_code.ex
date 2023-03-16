defmodule StellarBase.XDR.OperationResultCode do
  @moduledoc """
  Representation of Stellar `OperationResultCode` type.
  """

  @behaviour XDR.Declaration

  @declarations [
    # inner object result is valid
    opINNER: 0,
    # too few valid signatures / wrong network
    opBAD_AUTH: -1,
    # source account was not found
    opNO_ACCOUNT: -2,
    # operation not supported at this time
    opNOT_SUPPORTED: -3,
    # max number of subentries already reached
    opTOO_MANY_SUBENTRIES: -4,
    # operation did too much work
    opEXCEEDED_WORK_LIMIT: -5,
    # account is sponsoring too many entries
    opTOO_MANY_SPONSORING: -6
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
