defmodule Stellar.XDR.AssetCode12Test do
  use ExUnit.Case

  alias Stellar.XDR.AssetCode12

  describe "AssetCode12" do
    setup do
      %{
        code: "BTCNEW000000",
        asset_code: AssetCode12.new("BTCNEW000000"),
        binary: "BTCNEW000000"
      }
    end

    test "new/1", %{code: code} do
      %AssetCode12{code: ^code} = AssetCode12.new(code)
      12 = String.length(code)
    end

    test "encode_xdr/1", %{asset_code: asset_code, binary: binary} do
      {:ok, ^binary} = AssetCode12.encode_xdr(asset_code)
    end

    test "encode_xdr/1 with an invalid length" do
      {:error, :invalid_length} =
        "BTCNEW2000000"
        |> AssetCode12.new()
        |> AssetCode12.encode_xdr()
    end

    test "encode_xdr!/1", %{asset_code: asset_code, binary: binary} do
      ^binary = AssetCode12.encode_xdr!(asset_code)
    end

    test "encode_xdr!/1 with an invalid length" do
      assert_raise Stellar.XDR.AssetCode12Error,
                   fn ->
                     "BTC2021000000000"
                     |> AssetCode12.new()
                     |> AssetCode12.encode_xdr!()
                   end
    end

    test "decode_xdr/2", %{asset_code: asset_code, binary: binary} do
      {:ok, {^asset_code, ""}} = AssetCode12.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = AssetCode12.decode_xdr(123)
    end

    test "decode_xdr!/2", %{asset_code: asset_code, binary: binary} do
      {^asset_code, ""} = AssetCode12.decode_xdr!(binary)
    end
  end
end
