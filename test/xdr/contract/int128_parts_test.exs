defmodule StellarBase.XDR.Int128PartsTest do
  use ExUnit.Case

  alias StellarBase.XDR.{Int128Parts, UInt64, Int64}

  describe "Int128Parts" do
    setup do
      hi = Int64.new(3313)
      lo = UInt64.new(3312)

      %{
        lo: lo,
        hi: hi,
        int128_parts: Int128Parts.new(hi, lo),
        binary: <<0, 0, 0, 0, 0, 0, 12, 241, 0, 0, 0, 0, 0, 0, 12, 240>>
      }
    end

    test "new/1", %{lo: lo, hi: hi} do
      %Int128Parts{hi: ^hi, lo: ^lo} = Int128Parts.new(hi, lo)
    end

    test "encode_xdr/1", %{int128_parts: int128_parts, binary: binary} do
      {:ok, ^binary} = Int128Parts.encode_xdr(int128_parts)
    end

    test "encode_xdr!/1", %{int128_parts: int128_parts, binary: binary} do
      ^binary = Int128Parts.encode_xdr!(int128_parts)
    end

    test "decode_xdr/2", %{int128_parts: int128_parts, binary: binary} do
      {:ok, {^int128_parts, ""}} = Int128Parts.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = Int128Parts.decode_xdr(123)
    end

    test "decode_xdr!/2", %{int128_parts: int128_parts, binary: binary} do
      {^int128_parts, ^binary} = Int128Parts.decode_xdr!(binary <> binary)
    end
  end
end
