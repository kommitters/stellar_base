defmodule StellarBase.XDR.ScMetaV0Test do
  use ExUnit.Case

  alias StellarBase.XDR.{SCMetaV0, String}

  describe "SCMetaV0" do
    setup do
      key = String.new("key")
      val = String.new("val")
      sc_meta_v0 = SCMetaV0.new(key, val)

      %{
        key: key,
        val: val,
        sc_meta_v0: sc_meta_v0,
        binary: <<0, 0, 0, 3, 107, 101, 121, 0, 0, 0, 0, 3, 118, 97, 108, 0>>
      }
    end

    test "new/1", %{key: key, val: val} do
      %SCMetaV0{key: ^key, val: ^val} = SCMetaV0.new(key, val)
    end

    test "encode_xdr/1", %{sc_meta_v0: sc_meta_v0, binary: binary} do
      {:ok, ^binary} = SCMetaV0.encode_xdr(sc_meta_v0)
    end

    test "encode_xdr!/1", %{sc_meta_v0: sc_meta_v0, binary: binary} do
      ^binary = SCMetaV0.encode_xdr!(sc_meta_v0)
    end

    test "decode_xdr/2", %{sc_meta_v0: sc_meta_v0, binary: binary} do
      {:ok, {^sc_meta_v0, ""}} = SCMetaV0.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = SCMetaV0.decode_xdr(123)
    end

    test "decode_xdr!/2", %{sc_meta_v0: sc_meta_v0, binary: binary} do
      {^sc_meta_v0, ^binary} = SCMetaV0.decode_xdr!(binary <> binary)
    end
  end
end
