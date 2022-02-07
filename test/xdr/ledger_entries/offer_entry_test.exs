defmodule StellarBase.XDR.OfferEntryTest do
  use ExUnit.Case

  import StellarBase.Test.Utils, only: [create_account_id: 1, create_asset: 2]

  alias StellarBase.XDR.{Ext, Int32, Int64, OfferEntry, Price}

  describe "OfferEntry Operation" do
    setup do
      seller_id = create_account_id("GCNY5OXYSY4FKHOPT2SPOQZAOEIGXB5LBYW3HVU3OWSTQITS65M5RCNY")

      offer_id = Int64.new(123_456)

      selling =
        create_asset(:alpha_num4,
          code: "BTCN",
          issuer: "GBZNLMUQMIN3VGUJISKZU7GNY3O3XLMYEHJCKCSMDHKLGSMKALRXOEZD"
        )

      buying =
        create_asset(:alpha_num12,
          code: "BTCNEW2021",
          issuer: "GBZNLMUQMIN3VGUJISKZU7GNY3O3XLMYEHJCKCSMDHKLGSMKALRXOEZD"
        )

      amount = Int64.new(5_000_000)

      price = Price.new(Int32.new(1), Int32.new(10))

      ext = Ext.new()

      %{
        seller_id: seller_id,
        offer_id: offer_id,
        selling: selling,
        buying: buying,
        amount: amount,
        price: price,
        ext: ext,
        offer_entry: OfferEntry.new(seller_id, offer_id, selling, buying, amount, price, ext),
        binary:
          <<0, 0, 0, 0, 155, 142, 186, 248, 150, 56, 85, 29, 207, 158, 164, 247, 67, 32, 113, 16,
            107, 135, 171, 14, 45, 179, 214, 155, 117, 165, 56, 34, 114, 247, 89, 216, 0, 0, 0, 0,
            0, 1, 226, 64, 0, 0, 0, 1, 66, 84, 67, 78, 0, 0, 0, 0, 114, 213, 178, 144, 98, 27,
            186, 154, 137, 68, 149, 154, 124, 205, 198, 221, 187, 173, 152, 33, 210, 37, 10, 76,
            25, 212, 179, 73, 138, 2, 227, 119, 0, 0, 0, 2, 66, 84, 67, 78, 69, 87, 50, 48, 50,
            49, 0, 0, 0, 0, 0, 0, 114, 213, 178, 144, 98, 27, 186, 154, 137, 68, 149, 154, 124,
            205, 198, 221, 187, 173, 152, 33, 210, 37, 10, 76, 25, 212, 179, 73, 138, 2, 227, 119,
            0, 0, 0, 0, 0, 76, 75, 64, 0, 0, 0, 1, 0, 0, 0, 10, 0, 0, 0, 0>>
      }
    end

    test "new/1", %{
      seller_id: seller_id,
      offer_id: offer_id,
      selling: selling,
      buying: buying,
      amount: amount,
      price: price,
      ext: ext
    } do
      %OfferEntry{
        seller_id: ^seller_id,
        offer_id: ^offer_id,
        selling: ^selling,
        buying: ^buying,
        amount: ^amount
      } = OfferEntry.new(seller_id, offer_id, selling, buying, amount, price, ext)
    end

    test "encode_xdr/1", %{offer_entry: offer_entry, binary: binary} do
      {:ok, ^binary} = OfferEntry.encode_xdr(offer_entry)
    end

    test "encode_xdr!/1", %{offer_entry: offer_entry, binary: binary} do
      ^binary = OfferEntry.encode_xdr!(offer_entry)
    end

    test "decode_xdr/2", %{offer_entry: offer_entry, binary: binary} do
      {:ok, {^offer_entry, ""}} = OfferEntry.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = OfferEntry.decode_xdr(123)
    end

    test "decode_xdr!/2", %{offer_entry: offer_entry, binary: binary} do
      {^offer_entry, ^binary} = OfferEntry.decode_xdr!(binary <> binary)
    end
  end
end
