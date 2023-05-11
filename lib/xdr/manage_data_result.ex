defmodule StellarBase.XDR.ManageDataResult do
  @moduledoc """
  Automatically generated by xdrgen
  DO NOT EDIT or your changes may be overwritten

  Target implementation: elixir_xdr at https://hex.pm/packages/elixir_xdr

  Representation of Stellar `ManageDataResult` type.
  """

  @behaviour XDR.Declaration

  alias StellarBase.XDR.{
    ManageDataResultCode,
    Void
  }

  @arms [
    MANAGE_DATA_SUCCESS: Void,
    MANAGE_DATA_NOT_SUPPORTED_YET: Void,
    MANAGE_DATA_NAME_NOT_FOUND: Void,
    MANAGE_DATA_LOW_RESERVE: Void,
    MANAGE_DATA_INVALID_NAME: Void
  ]

  @type value ::
          Void.t()

  @type t :: %__MODULE__{value: value(), type: ManageDataResultCode.t()}

  defstruct [:value, :type]

  @spec new(value :: value(), type :: ManageDataResultCode.t()) :: t()
  def new(value, %ManageDataResultCode{} = type), do: %__MODULE__{value: value, type: type}

  @impl true
  def encode_xdr(%__MODULE__{value: value, type: type}) do
    type
    |> XDR.Union.new(@arms, value)
    |> XDR.Union.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{value: value, type: type}) do
    type
    |> XDR.Union.new(@arms, value)
    |> XDR.Union.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, spec \\ union_spec())

  def decode_xdr(bytes, spec) do
    case XDR.Union.decode_xdr(bytes, spec) do
      {:ok, {{type, value}, rest}} -> {:ok, {new(value, type), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, spec \\ union_spec())

  def decode_xdr!(bytes, spec) do
    {{type, value}, rest} = XDR.Union.decode_xdr!(bytes, spec)
    {new(value, type), rest}
  end

  @spec union_spec() :: XDR.Union.t()
  defp union_spec do
    nil
    |> ManageDataResultCode.new()
    |> XDR.Union.new(@arms)
  end
end
