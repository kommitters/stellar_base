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

  @type t :: %__MODULE__{entry: entry(), kind: SCEnvMetaKind.t()}

  defstruct [:entry, :kind]

  @spec new(entry :: entry(), kind :: SCEnvMetaKind.t()) :: t()
  def new(entry, %SCEnvMetaKind{} = kind), do: %__MODULE__{entry: entry, kind: kind}

  @impl true
  def encode_xdr(%__MODULE__{entry: entry, kind: kind}) do
    kind
    |> XDR.Union.new(@arms, entry)
    |> XDR.Union.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{entry: entry, kind: kind}) do
    kind
    |> XDR.Union.new(@arms, entry)
    |> XDR.Union.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, spec \\ union_spec())

  def decode_xdr(bytes, spec) do
    case XDR.Union.decode_xdr(bytes, spec) do
      {:ok, {{kind, entry}, rest}} -> {:ok, {new(entry, kind), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, spec \\ union_spec())

  def decode_xdr!(bytes, spec) do
    {{kind, entry}, rest} = XDR.Union.decode_xdr!(bytes, spec)
    {new(entry, kind), rest}
  end

  @spec union_spec() :: XDR.Union.t()
  defp union_spec do
    nil
    |> SCEnvMetaKind.new()
    |> XDR.Union.new(@arms)
  end
end
