defmodule StellarBase.XDR.SCValTypeTest do
  use ExUnit.Case

  alias StellarBase.XDR.SCValType

  describe "SCValType" do
    setup do
      %{
        binary: <<0, 0, 0, 1>>,
        identifier: :SCV_U32,
        default_identifier: :SCV_U63,
        xdr_type: SCValType.new(:SCV_U32)
      }
    end

    test "new/1", %{identifier: type} do
      %SCValType{identifier: ^type} = SCValType.new(type)
    end

    test "new/1 with default value", %{default_identifier: type} do
      %SCValType{identifier: ^type} = SCValType.new()
    end

    test "encode_xdr/1", %{xdr_type: xdr_type, binary: binary} do
      {:ok, ^binary} = SCValType.encode_xdr(xdr_type)
    end

    test "encode_xdr!/1", %{xdr_type: xdr_type, binary: binary} do
      ^binary = SCValType.encode_xdr!(xdr_type)
    end

    test "decode_xdr/2", %{xdr_type: xdr_type, binary: binary} do
      {:ok, {^xdr_type, ""}} = SCValType.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = SCValType.decode_xdr(123)
    end

    test "decode_xdr!/2", %{xdr_type: xdr_type, binary: binary} do
      {^xdr_type, ^binary} = SCValType.decode_xdr!(binary <> binary)
    end

    test "invalid identifier" do
      {:error, :invalid_key} = SCValType.encode_xdr(%SCValType{identifier: :SCV_TEST})
    end
  end
end
