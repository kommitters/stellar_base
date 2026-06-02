defmodule StellarBase.XDR.ConfigSettingContractParallelComputeV0 do
  @moduledoc """
  Representation of Stellar `ConfigSettingContractParallelComputeV0` type.
  """

  @behaviour XDR.Declaration

  alias StellarBase.XDR.UInt32

  @struct_spec XDR.Struct.new(ledger_max_dependent_tx_clusters: UInt32)

  @type ledger_max_dependent_tx_clusters_type :: UInt32.t()

  @type t :: %__MODULE__{
          ledger_max_dependent_tx_clusters: ledger_max_dependent_tx_clusters_type()
        }

  defstruct [:ledger_max_dependent_tx_clusters]

  @spec new(ledger_max_dependent_tx_clusters :: ledger_max_dependent_tx_clusters_type()) :: t()
  def new(%UInt32{} = ledger_max_dependent_tx_clusters),
    do: %__MODULE__{ledger_max_dependent_tx_clusters: ledger_max_dependent_tx_clusters}

  @impl true
  def encode_xdr(%__MODULE__{ledger_max_dependent_tx_clusters: ledger_max_dependent_tx_clusters}) do
    [ledger_max_dependent_tx_clusters: ledger_max_dependent_tx_clusters]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{ledger_max_dependent_tx_clusters: ledger_max_dependent_tx_clusters}) do
    [ledger_max_dependent_tx_clusters: ledger_max_dependent_tx_clusters]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, struct \\ @struct_spec)

  def decode_xdr(bytes, struct) do
    case XDR.Struct.decode_xdr(bytes, struct) do
      {:ok,
       {%XDR.Struct{
          components: [ledger_max_dependent_tx_clusters: ledger_max_dependent_tx_clusters]
        }, rest}} ->
        {:ok, {new(ledger_max_dependent_tx_clusters), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{
       components: [ledger_max_dependent_tx_clusters: ledger_max_dependent_tx_clusters]
     },
     rest} =
      XDR.Struct.decode_xdr!(bytes, struct)

    {new(ledger_max_dependent_tx_clusters), rest}
  end
end
