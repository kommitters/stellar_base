defmodule StellarBase.XDR.SCStaticTest do
  use ExUnit.Case

  alias StellarBase.XDR.SCStatic

  describe "SCStatic" do
    setup do
      %{
        binary: <<0, 0, 0, 1>>,
        identifier: :SCS_TRUE,
        default_identifier: :SCS_VOID,
        xdr_type: SCStatic.new(:SCS_TRUE)
      }
    end

    test "new/1", %{identifier: type} do
      %SCStatic{identifier: ^type} = SCStatic.new(type)
    end

    test "new/1 with default value", %{default_identifier: type} do
      %SCStatic{identifier: ^type} = SCStatic.new()
    end

    test "encode_xdr/1", %{xdr_type: xdr_type, binary: binary} do
      {:ok, ^binary} = SCStatic.encode_xdr(xdr_type)
    end

    test "encode_xdr!/1", %{xdr_type: xdr_type, binary: binary} do
      ^binary = SCStatic.encode_xdr!(xdr_type)
    end

    test "decode_xdr/2", %{xdr_type: xdr_type, binary: binary} do
      {:ok, {^xdr_type, ""}} = SCStatic.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = SCStatic.decode_xdr(123)
    end

    test "decode_xdr!/2", %{xdr_type: xdr_type, binary: binary} do
      {^xdr_type, ^binary} = SCStatic.decode_xdr!(binary <> binary)
    end

    test "invalid identifier" do
      {:error, :invalid_key} = SCStatic.encode_xdr(%SCStatic{identifier: :SCS_TEST})
    end
  end
end
