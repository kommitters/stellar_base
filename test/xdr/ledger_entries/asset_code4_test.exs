defmodule StellarBase.XDR.AssetCode4Test do
  use ExUnit.Case

  alias StellarBase.XDR.AssetCode4

  describe "AssetCode4" do
    setup do
      %{
        code: "BTCN",
        asset_code: AssetCode4.new("BTCN"),
        binary: <<66, 84, 67, 78>>
      }
    end

    test "new/1", %{code: code} do
      %AssetCode4{code: ^code} = AssetCode4.new(code)
      4 = String.length(code)
    end

    test "encode_xdr/1", %{asset_code: asset_code, binary: binary} do
      {:ok, ^binary} = AssetCode4.encode_xdr(asset_code)
    end

    test "encode_xdr/1 with an invalid length" do
      {:error, :invalid_length} =
        "BTC2021"
        |> AssetCode4.new()
        |> AssetCode4.encode_xdr()
    end

    test "encode_xdr!/1", %{asset_code: asset_code, binary: binary} do
      ^binary = AssetCode4.encode_xdr!(asset_code)
    end

    test "encode_xdr!/1 with an invalid length" do
      assert_raise StellarBase.XDR.AssetCode4Error,
                   fn ->
                     "BTC2021"
                     |> AssetCode4.new()
                     |> AssetCode4.encode_xdr!()
                   end
    end

    test "decode_xdr/2", %{asset_code: asset_code, binary: binary} do
      {:ok, {^asset_code, ""}} = AssetCode4.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = AssetCode4.decode_xdr(123)
    end

    test "decode_xdr!/2", %{asset_code: asset_code, binary: binary} do
      {^asset_code, ""} = AssetCode4.decode_xdr!(binary)
    end
  end
end
