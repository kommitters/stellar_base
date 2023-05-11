defmodule StellarBase.XDR.ExtensionPointTest do
  use ExUnit.Case

  alias StellarBase.XDR.{ExtensionPoint, Void}

  describe "ExtensionPoint" do
    setup do
      extension_point_type = 0
      void = Void.new()

      %{
        void: void,
        extension_point_type: extension_point_type,
        extension_point: ExtensionPoint.new(void, extension_point_type),
        binary: <<0, 0, 0, 0>>
      }
    end

    test "new/1", %{void: void, extension_point_type: extension_point_type} do
      %ExtensionPoint{value: ^void} = ExtensionPoint.new(void, extension_point_type)
    end

    test "encode_xdr/1", %{extension_point: extension_point, binary: binary} do
      {:ok, ^binary} = ExtensionPoint.encode_xdr(extension_point)
    end

    test "encode_xdr!/1", %{extension_point: extension_point, binary: binary} do
      ^binary = ExtensionPoint.encode_xdr!(extension_point)
    end

    test "decode_xdr/2", %{extension_point: extension_point, binary: binary} do
      {:ok, {^extension_point, ""}} = ExtensionPoint.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = ExtensionPoint.decode_xdr(123)
    end

    test "decode_xdr!/2", %{extension_point: extension_point, binary: binary} do
      {^extension_point, ^binary} = ExtensionPoint.decode_xdr!(binary <> binary)
    end
  end
end
