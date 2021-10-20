defmodule Stellar.XDR.Operations.BeginSponsoringFutureReservesResultCode do
  @moduledoc """
  Representation of Stellar `BeginSponsoringFutureReservesResultCode` type.
  """
  @behaviour XDR.Declaration

  @declarations [
    # success
    BEGIN_SPONSORING_FUTURE_RESERVES_SUCCESS: 0,
    # failure
    BEGIN_SPONSORING_FUTURE_RESERVES_MALFORMED: -1,
    BEGIN_SPONSORING_FUTURE_RESERVES_ALREADY_SPONSORED: -2,
    BEGIN_SPONSORING_FUTURE_RESERVES_RECURSIVE: -3
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
