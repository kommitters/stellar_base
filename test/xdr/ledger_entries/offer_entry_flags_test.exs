defmodule StellarBase.XDR.OfferEntryFlagsTest do
  use ExUnit.Case

  alias StellarBase.XDR.OfferEntryFlags

  describe "OfferEntryFlags" do
    setup do
      %{
        identifier: :PASSIVE_FLAG,
        offer_entry_type: OfferEntryFlags.new(:PASSIVE_FLAG),
        binary: <<0, 0, 0, 1>>
      }
    end

    test "new/1", %{identifier: type} do
      %OfferEntryFlags{identifier: ^type} = OfferEntryFlags.new(type)
    end

    test "new/1 with an invalid type" do
      %OfferEntryFlags{identifier: nil} = OfferEntryFlags.new(nil)
    end

    test "encode_xdr/1", %{offer_entry_type: offer_entry_type, binary: binary} do
      {:ok, ^binary} = OfferEntryFlags.encode_xdr(offer_entry_type)
    end

    test "encode_xdr/1 with an invalid identifier" do
      {:error, :invalid_key} =
        OfferEntryFlags.encode_xdr(%OfferEntryFlags{identifier: :BUY_MONEY})
    end

    test "encode_xdr!/1", %{offer_entry_type: offer_entry_type, binary: binary} do
      ^binary = OfferEntryFlags.encode_xdr!(offer_entry_type)
    end

    test "decode_xdr/2", %{offer_entry_type: offer_entry_type, binary: binary} do
      {:ok, {^offer_entry_type, ""}} = OfferEntryFlags.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid declaration" do
      {:error, :invalid_key} = OfferEntryFlags.decode_xdr(<<1, 0, 0, 1>>)
    end

    test "decode_xdr!/2", %{offer_entry_type: offer_entry_type, binary: binary} do
      {^offer_entry_type, ^binary} = OfferEntryFlags.decode_xdr!(binary <> binary)
    end
  end
end
