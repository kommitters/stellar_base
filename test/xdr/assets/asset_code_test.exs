defmodule Stellar.XDR.AssetCodeTest do
  use ExUnit.Case

  alias Stellar.XDR.{AssetCode, AssetCode4, AssetType}

  describe "AssetCode" do
    setup do
      asset = AssetCode4.new("BTCN")
      asset_type = AssetType.new(:ASSET_TYPE_CREDIT_ALPHANUM4)

      %{
        asset: asset,
        asset_type: asset_type,
        asset_code: AssetCode.new(asset, asset_type),
        binary: <<0, 0, 0, 1, 0, 0, 0, 4, 66, 84, 67, 78>>
      }
    end

    test "new/1", %{asset: asset, asset_type: asset_type} do
      %AssetCode{asset: ^asset, type: ^asset_type} = AssetCode.new(asset, asset_type)
    end

    test "encode_xdr/1", %{asset_code: asset_code, binary: binary} do
      {:ok, ^binary} = AssetCode.encode_xdr(asset_code)
    end

    test "encode_xdr/1 with an invalid type", %{asset: asset} do
      asset_type = AssetType.new(:NEW_BITCOIN)

      assert_raise XDR.EnumError,
                   "The key which you try to encode doesn't belong to the current declarations",
                   fn ->
                     asset
                     |> AssetCode.new(asset_type)
                     |> AssetCode.encode_xdr()
                   end
    end

    test "encode_xdr!/1", %{asset_code: asset_code, binary: binary} do
      ^binary = AssetCode.encode_xdr!(asset_code)
    end

    test "decode_xdr/2", %{asset_code: asset_code, binary: binary} do
      {:ok, {^asset_code, ""}} = AssetCode.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = AssetCode.decode_xdr(123)
    end

    test "decode_xdr!/2", %{asset_code: asset_code, binary: binary} do
      {^asset_code, ^binary} = AssetCode.decode_xdr!(binary <> binary)
    end
  end
end
