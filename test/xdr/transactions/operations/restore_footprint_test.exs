defmodule StellarBase.XDR.Operations.RestoreFootprintTest do
  use ExUnit.Case

  alias StellarBase.XDR.{
    ExtensionPoint,
    Operations.RestoreFootprint,
    Void
  }

  describe "RestoreFootprint Operation" do
    setup do
      ext = ExtensionPoint.new(Void.new(), 0)

      %{
        ext: ext,
        restore_footprint: RestoreFootprint.new(ext),
        binary: <<0, 0, 0, 0>>
      }
    end

    test "new/1", %{ext: ext} do
      %RestoreFootprint{
        ext: ^ext
      } = RestoreFootprint.new(ext)
    end

    test "encode_xdr/1", %{restore_footprint: restore_footprint, binary: binary} do
      {:ok, ^binary} = RestoreFootprint.encode_xdr(restore_footprint)
    end

    test "encode_xdr!/1", %{restore_footprint: restore_footprint, binary: binary} do
      ^binary = RestoreFootprint.encode_xdr!(restore_footprint)
    end

    test "decode_xdr/2", %{restore_footprint: restore_footprint, binary: binary} do
      {:ok, {^restore_footprint, ""}} = RestoreFootprint.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = RestoreFootprint.decode_xdr(123)
    end

    test "decode_xdr!/2", %{restore_footprint: restore_footprint, binary: binary} do
      {^restore_footprint, ^binary} = RestoreFootprint.decode_xdr!(binary <> binary)
    end
  end
end
