defmodule StellarBase.XDR.FreezeBypassTxsDelta do
  @moduledoc """
  Representation of Stellar `FreezeBypassTxsDelta` type.
  """

  @behaviour XDR.Declaration

  alias StellarBase.XDR.HashList

  @struct_spec XDR.Struct.new(
                 add_txs: HashList,
                 remove_txs: HashList
               )

  @type add_txs_type :: HashList.t()
  @type remove_txs_type :: HashList.t()

  @type t :: %__MODULE__{add_txs: add_txs_type(), remove_txs: remove_txs_type()}

  defstruct [:add_txs, :remove_txs]

  @spec new(add_txs :: add_txs_type(), remove_txs :: remove_txs_type()) :: t()
  def new(
        %HashList{} = add_txs,
        %HashList{} = remove_txs
      ),
      do: %__MODULE__{add_txs: add_txs, remove_txs: remove_txs}

  @impl true
  def encode_xdr(%__MODULE__{add_txs: add_txs, remove_txs: remove_txs}) do
    [add_txs: add_txs, remove_txs: remove_txs]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{add_txs: add_txs, remove_txs: remove_txs}) do
    [add_txs: add_txs, remove_txs: remove_txs]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, struct \\ @struct_spec)

  def decode_xdr(bytes, struct) do
    case XDR.Struct.decode_xdr(bytes, struct) do
      {:ok, {%XDR.Struct{components: [add_txs: add_txs, remove_txs: remove_txs]}, rest}} ->
        {:ok, {new(add_txs, remove_txs), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{components: [add_txs: add_txs, remove_txs: remove_txs]}, rest} =
      XDR.Struct.decode_xdr!(bytes, struct)

    {new(add_txs, remove_txs), rest}
  end
end
