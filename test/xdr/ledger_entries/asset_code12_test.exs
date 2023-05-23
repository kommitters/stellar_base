defmodule StellarBase.XDR.AssetCode12Test do
  use ExUnit.Case

  alias StellarBase.XDR.AssetCode12

  describe "AssetCode12" do
    setup do
      %{
        code: "BTCNEW000000",
        asset_code: AssetCode12.new("BTCNEW000000"),
        binary: "BTCNEW000000"
      }
    end

    test "new/1", %{code: code} do
      %AssetCode12{value: ^code} = AssetCode12.new(code)
      12 = String.length(code)
    end

    test "encode_xdr/1", %{asset_code: asset_code, binary: binary} do
      {:ok, ^binary} = AssetCode12.encode_xdr(asset_code)
    end

    test "encode_xdr/1 with an invalid length" do
      assert_raise ArgumentError,
        fn ->
          "BTC2021000000000"
          |> AssetCode12.new()
          |> AssetCode12.encode_xdr()
        end
    end

    test "encode_xdr!/1", %{asset_code: asset_code, binary: binary} do
      ^binary = AssetCode12.encode_xdr!(asset_code)
    end

    test "encode_xdr!/1 with an invalid length" do
      assert_raise ArgumentError,
                   fn ->
                     "BTC2021000000000"
                     |> AssetCode12.new()
                     |> AssetCode12.encode_xdr!()
                   end
    end

    test "decode_xdr/2 with a 12-bytes code" do
      {:ok, {%AssetCode12{value: "BTCNEW2000"}, ""}} =
        AssetCode12.decode_xdr(<<66, 84, 67, 78, 69, 87, 50, 48, 48, 48, 0, 0>>)
    end

    test "decode_xdr/2 with a 8-bytes code" do
      {:ok, {%AssetCode12{value: "BTCNE"}, <<0, 0, 0, 0>>}} =
        AssetCode12.decode_xdr(<<66, 84, 67, 78, 69, 0, 0, 0, 0, 0, 0, 0>>)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = AssetCode12.decode_xdr(123)
    end

    test "decode_xdr!/2", %{asset_code: asset_code, binary: binary} do
      {^asset_code, ""} = AssetCode12.decode_xdr!(binary)
    end
  end
end
