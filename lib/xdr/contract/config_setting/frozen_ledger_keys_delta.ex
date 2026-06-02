defmodule StellarBase.XDR.FrozenLedgerKeysDelta do
  @moduledoc """
  Representation of Stellar `FrozenLedgerKeysDelta` type.
  """

  @behaviour XDR.Declaration

  alias StellarBase.XDR.EncodedLedgerKeyList

  @struct_spec XDR.Struct.new(
                 keys_to_freeze: EncodedLedgerKeyList,
                 keys_to_unfreeze: EncodedLedgerKeyList
               )

  @type keys_to_freeze_type :: EncodedLedgerKeyList.t()
  @type keys_to_unfreeze_type :: EncodedLedgerKeyList.t()

  @type t :: %__MODULE__{
          keys_to_freeze: keys_to_freeze_type(),
          keys_to_unfreeze: keys_to_unfreeze_type()
        }

  defstruct [:keys_to_freeze, :keys_to_unfreeze]

  @spec new(keys_to_freeze :: keys_to_freeze_type(), keys_to_unfreeze :: keys_to_unfreeze_type()) ::
          t()
  def new(
        %EncodedLedgerKeyList{} = keys_to_freeze,
        %EncodedLedgerKeyList{} = keys_to_unfreeze
      ),
      do: %__MODULE__{keys_to_freeze: keys_to_freeze, keys_to_unfreeze: keys_to_unfreeze}

  @impl true
  def encode_xdr(%__MODULE__{keys_to_freeze: keys_to_freeze, keys_to_unfreeze: keys_to_unfreeze}) do
    [keys_to_freeze: keys_to_freeze, keys_to_unfreeze: keys_to_unfreeze]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{keys_to_freeze: keys_to_freeze, keys_to_unfreeze: keys_to_unfreeze}) do
    [keys_to_freeze: keys_to_freeze, keys_to_unfreeze: keys_to_unfreeze]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, struct \\ @struct_spec)

  def decode_xdr(bytes, struct) do
    case XDR.Struct.decode_xdr(bytes, struct) do
      {:ok,
       {%XDR.Struct{
          components: [keys_to_freeze: keys_to_freeze, keys_to_unfreeze: keys_to_unfreeze]
        }, rest}} ->
        {:ok, {new(keys_to_freeze, keys_to_unfreeze), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{
       components: [keys_to_freeze: keys_to_freeze, keys_to_unfreeze: keys_to_unfreeze]
     },
     rest} =
      XDR.Struct.decode_xdr!(bytes, struct)

    {new(keys_to_freeze, keys_to_unfreeze), rest}
  end
end
