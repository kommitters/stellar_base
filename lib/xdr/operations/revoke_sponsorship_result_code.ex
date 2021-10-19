defmodule Stellar.XDR.Operations.RevokeSponsorshipResultCode do
  @moduledoc """
  Representation of Stellar `RevokeSponsorshipResultCode` type.
  """
  @behaviour XDR.Declaration

  @declarations [
    # success
    REVOKE_SPONSORSHIP_SUCCESS: 0,
    # failure
    REVOKE_SPONSORSHIP_DOES_NOT_EXIST: -1,
    REVOKE_SPONSORSHIP_NOT_SPONSOR: -2,
    REVOKE_SPONSORSHIP_LOW_RESERVE: -3,
    REVOKE_SPONSORSHIP_ONLY_TRANSFERABLE: -4,
    REVOKE_SPONSORSHIP_MALFORMED: -5
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
