defmodule StellarBase.XDR.Operations.BumpFootprintExpirationTest do
  use ExUnit.Case

  alias StellarBase.XDR.{
    ExtensionPoint,
    Operations.BumpFootprintExpiration,
    UInt32,
    Void
  }

  describe "BumpFootprintExpiration Operation" do
    setup do
      ext = ExtensionPoint.new(Void.new(), 0)
      ledgers_to_expire = UInt32.new(105_255)

      %{
        ext: ext,
        ledgers_to_expire: ledgers_to_expire,
        bump_footprint_exp: BumpFootprintExpiration.new(ext, ledgers_to_expire),
        binary: <<0, 0, 0, 0, 0, 1, 155, 39>>
      }
    end

    test "new/1", %{ext: ext, ledgers_to_expire: ledgers_to_expire} do
      %BumpFootprintExpiration{
        ext: ^ext,
        ledgers_to_expire: ^ledgers_to_expire
      } = BumpFootprintExpiration.new(ext, ledgers_to_expire)
    end

    test "encode_xdr/1", %{bump_footprint_exp: bump_footprint_exp, binary: binary} do
      {:ok, ^binary} = BumpFootprintExpiration.encode_xdr(bump_footprint_exp)
    end

    test "encode_xdr!/1", %{bump_footprint_exp: bump_footprint_exp, binary: binary} do
      ^binary = BumpFootprintExpiration.encode_xdr!(bump_footprint_exp)
    end

    test "decode_xdr/2", %{bump_footprint_exp: bump_footprint_exp, binary: binary} do
      {:ok, {^bump_footprint_exp, ""}} = BumpFootprintExpiration.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = BumpFootprintExpiration.decode_xdr(123)
    end

    test "decode_xdr!/2", %{bump_footprint_exp: bump_footprint_exp, binary: binary} do
      {^bump_footprint_exp, ^binary} = BumpFootprintExpiration.decode_xdr!(binary <> binary)
    end
  end
end
