defmodule StellarBase.XDR.AssetTypeTest do
  use ExUnit.Case

  alias StellarBase.XDR.AssetType

  describe "AssetType" do
    setup do
      %{
        identifier: :ASSET_TYPE_CREDIT_ALPHANUM4,
        operation_type: AssetType.new(:ASSET_TYPE_CREDIT_ALPHANUM4),
        binary: <<0, 0, 0, 1>>
      }
    end

    test "new/1", %{identifier: type} do
      %AssetType{identifier: ^type} = AssetType.new(type)
    end

    test "new/1 with an invalid type" do
      %AssetType{identifier: nil} = AssetType.new(nil)
    end

    test "encode_xdr/1", %{operation_type: operation_type, binary: binary} do
      {:ok, ^binary} = AssetType.encode_xdr(operation_type)
    end

    test "encode_xdr/1 with an invalid identifier" do
      {:error, :invalid_key} = AssetType.encode_xdr(%AssetType{identifier: :BUY_MONEY})
    end

    test "encode_xdr!/1", %{operation_type: operation_type, binary: binary} do
      ^binary = AssetType.encode_xdr!(operation_type)
    end

    test "decode_xdr/2", %{operation_type: operation_type, binary: binary} do
      {:ok, {^operation_type, ""}} = AssetType.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid declaration" do
      {:error, :invalid_key} = AssetType.decode_xdr(<<1, 0, 0, 1>>)
    end

    test "decode_xdr!/2", %{operation_type: operation_type, binary: binary} do
      {^operation_type, ^binary} = AssetType.decode_xdr!(binary <> binary)
    end
  end
end
