defmodule StellarBase.XDR.SCEnvMetaEntry do
  @moduledoc """
  Representation of Stellar `SCEnvMetaEntry` type.
  """

  alias StellarBase.XDR.{UInt64, SCEnvMetaKind}

  @behaviour XDR.Declaration

  @arms [
    SC_ENV_META_KIND_INTERFACE_VERSION: UInt64
  ]

  @type entry :: UInt64.t()

  @type t :: %__MODULE__{entry: entry(), type: SCEnvMetaKind.t()}

  defstruct [:entry, :type]

  @spec new(entry :: entry(), type :: SCEnvMetaKind.t()) :: t()
  def new(entry, %SCEnvMetaKind{} = type), do: %__MODULE__{entry: entry, type: type}

  @impl true
  def encode_xdr(%__MODULE__{entry: entry, type: type}) do
    type
    |> XDR.Union.new(@arms, entry)
    |> XDR.Union.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{entry: entry, type: type}) do
    type
    |> XDR.Union.new(@arms, entry)
    |> XDR.Union.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, spec \\ union_spec())

  def decode_xdr(bytes, spec) do
    case XDR.Union.decode_xdr(bytes, spec) do
      {:ok, {{type, entry}, rest}} -> {:ok, {new(entry, type), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, spec \\ union_spec())

  def decode_xdr!(bytes, spec) do
    {{type, entry}, rest} = XDR.Union.decode_xdr!(bytes, spec)
    {new(entry, type), rest}
  end

  @spec union_spec() :: XDR.Union.t()
  defp union_spec do
    nil
    |> SCEnvMetaKind.new()
    |> XDR.Union.new(@arms)
  end
end
