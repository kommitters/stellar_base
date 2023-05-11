defmodule StellarBase.XDR.ManageOfferEffectTest do
  use ExUnit.Case

  alias StellarBase.XDR.ManageOfferEffect

  describe "ManageOfferEffect" do
    setup do
      %{
        code: :MANAGE_OFFER_CREATED,
        result: ManageOfferEffect.new(:MANAGE_OFFER_CREATED),
        binary: <<0, 0, 0, 0>>
      }
    end

    test "new/1", %{code: type} do
      %ManageOfferEffect{identifier: ^type} = ManageOfferEffect.new(type)
    end

    test "encode_xdr/1", %{result: result, binary: binary} do
      {:ok, ^binary} = ManageOfferEffect.encode_xdr(result)
    end

    test "encode_xdr/1 with an invalid code" do
      {:error, :invalid_key} =
        ManageOfferEffect.encode_xdr(%ManageOfferEffect{
          identifier: :TEST
        })
    end

    test "encode_xdr!/1", %{result: result, binary: binary} do
      ^binary = ManageOfferEffect.encode_xdr!(result)
    end

    test "decode_xdr/2", %{result: result, binary: binary} do
      {:ok, {^result, ""}} = ManageOfferEffect.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid declaration" do
      {:error, :invalid_key} = ManageOfferEffect.decode_xdr(<<1, 0, 0, 1>>)
    end

    test "decode_xdr!/2", %{result: result, binary: binary} do
      {^result, ^binary} = ManageOfferEffect.decode_xdr!(binary <> binary)
    end

    test "decode_xdr!/2 with an error code" do
      {%ManageOfferEffect{identifier: :MANAGE_OFFER_UPDATED}, ""} =
        ManageOfferEffect.decode_xdr!(<<0, 0, 0, 1>>)
    end
  end
end
