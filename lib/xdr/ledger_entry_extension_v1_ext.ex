defmodule StellarBase.XDR.LedgerEntryExtensionV1Ext do
  @moduledoc """
  Automatically generated by xdrgen
  DO NOT EDIT or your changes may be overwritten

  Target implementation: elixir_xdr at https://hex.pm/packages/elixir_xdr

  Representation of Stellar `LedgerEntryExtensionV1Ext` type.
  """

  @behaviour XDR.Declaration

  alias StellarBase.XDR.{
    Int,
    Void
  }

  @arms %{
    0 => Void
  }

  @type value ::
          Void.t()

  @type t :: %__MODULE__{value: value(), type: Int.t()}

  defstruct [:value, :type]

  @spec new(value :: value(), type :: Int.t()) :: t()
  def new(value, %Int{} = type), do: %__MODULE__{value: value, type: type}

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
    0
    |> Int.new()
    |> XDR.Union.new(@arms)
  end
end
