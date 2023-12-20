defmodule StellarBase.XDR.Operations.ExtendFootprintTTLTest do
  use ExUnit.Case

  alias StellarBase.XDR.{
    ExtensionPoint,
    Operations.ExtendFootprintTTL,
    UInt32,
    Void
  }

  describe "ExtendFootprintTTL Operation" do
    setup do
      ext = ExtensionPoint.new(Void.new(), 0)
      extend_to = UInt32.new(105_255)

      %{
        ext: ext,
        extend_to: extend_to,
        bump_footprint_exp: ExtendFootprintTTL.new(ext, extend_to),
        binary: <<0, 0, 0, 0, 0, 1, 155, 39>>
      }
    end

    test "new/1", %{ext: ext, extend_to: extend_to} do
      %ExtendFootprintTTL{
        ext: ^ext,
        extend_to: ^extend_to
      } = ExtendFootprintTTL.new(ext, extend_to)
    end

    test "encode_xdr/1", %{bump_footprint_exp: bump_footprint_exp, binary: binary} do
      {:ok, ^binary} = ExtendFootprintTTL.encode_xdr(bump_footprint_exp)
    end

    test "encode_xdr!/1", %{bump_footprint_exp: bump_footprint_exp, binary: binary} do
      ^binary = ExtendFootprintTTL.encode_xdr!(bump_footprint_exp)
    end

    test "decode_xdr/2", %{bump_footprint_exp: bump_footprint_exp, binary: binary} do
      {:ok, {^bump_footprint_exp, ""}} = ExtendFootprintTTL.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = ExtendFootprintTTL.decode_xdr(123)
    end

    test "decode_xdr!/2", %{bump_footprint_exp: bump_footprint_exp, binary: binary} do
      {^bump_footprint_exp, ^binary} = ExtendFootprintTTL.decode_xdr!(binary <> binary)
    end
  end
end
