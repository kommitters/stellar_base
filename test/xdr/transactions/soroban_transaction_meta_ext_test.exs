defmodule StellarBase.XDR.SorobanTransactionMetaExtTest do
  use ExUnit.Case

  alias StellarBase.XDR.{
    SorobanTransactionMetaExt,
    Void
  }

  describe "SorobanTransactionMetaExt" do
    setup do
      extension_point_type = 0
      void = Void.new()
      ext = SorobanTransactionMetaExt.new(void, extension_point_type)

      %{
        value: void,
        type: extension_point_type,
        ext: ext,
        binary: <<0, 0, 0, 0>>
      }
    end

    test "new/1", %{
      value: value,
      type: type,
      ext: ext
    } do
      ^ext = SorobanTransactionMetaExt.new(value, type)
    end

    test "encode_xdr/1", %{
      ext: ext,
      binary: binary
    } do
      {:ok, ^binary} = SorobanTransactionMetaExt.encode_xdr(ext)
    end

    test "encode_xdr!/1", %{
      ext: ext,
      binary: binary
    } do
      ^binary = SorobanTransactionMetaExt.encode_xdr!(ext)
    end

    test "decode_xdr/2", %{
      ext: ext,
      binary: binary
    } do
      {:ok, {^ext, ""}} = SorobanTransactionMetaExt.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = SorobanTransactionMetaExt.decode_xdr(1234)
    end

    test "decode_xdr!/2", %{
      ext: ext,
      binary: binary
    } do
      {^ext, ^binary} = SorobanTransactionMetaExt.decode_xdr!(binary <> binary)
    end
  end
end
