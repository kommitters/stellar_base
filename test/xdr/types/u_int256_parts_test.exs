defmodule StellarBase.XDR.UInt256PartsTest do
  use ExUnit.Case

  alias StellarBase.XDR.UInt64
  alias StellarBase.XDR.UInt256Parts

  describe "UInt256Parts" do
    setup do
      hi_hi = UInt64.new(1)
      hi_lo = UInt64.new(0)
      lo_hi = UInt64.new(0)
      lo_lo = UInt64.new(0)

      %{
        hi_hi: hi_hi,
        hi_lo: hi_lo,
        lo_hi: lo_hi,
        lo_lo: lo_lo,
        int256_parts: UInt256Parts.new(hi_hi, hi_lo, lo_hi, lo_lo),
        binary:
          <<0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0>>
      }
    end

    test "new/1", %{hi_hi: hi_hi, hi_lo: hi_lo, lo_hi: lo_hi, lo_lo: lo_lo} do
      %UInt256Parts{hi_hi: ^hi_hi, hi_lo: ^hi_lo, lo_hi: ^lo_hi, lo_lo: ^lo_lo} =
        UInt256Parts.new(
          hi_hi,
          hi_lo,
          lo_hi,
          lo_lo
        )
    end

    test "encode_xdr/1", %{int256_parts: int256_parts, binary: binary} do
      {:ok, ^binary} = UInt256Parts.encode_xdr(int256_parts)
    end

    test "encode_xdr!/1", %{int256_parts: int256_parts, binary: binary} do
      ^binary = UInt256Parts.encode_xdr!(int256_parts)
    end

    test "decode_xdr/2", %{int256_parts: int256_parts, binary: binary} do
      {:ok, {^int256_parts, ""}} = UInt256Parts.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = UInt256Parts.decode_xdr(123)
    end

    test "decode_xdr!/2", %{int256_parts: int256_parts, binary: binary} do
      {^int256_parts, ^binary} = UInt256Parts.decode_xdr!(binary <> binary)
    end
  end
end
