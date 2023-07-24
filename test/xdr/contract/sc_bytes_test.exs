defmodule StellarBase.XDR.SCBytesTest do
  use ExUnit.Case

  alias StellarBase.XDR.SCBytes

  describe "SCBytes" do
    setup do
      %{
        sc_bytes: SCBytes.new("GCIZ3GSM5"),
        binary: <<0, 0, 0, 9, 71, 67, 73, 90, 51, 71, 83, 77, 53, 0, 0, 0>>
      }
    end

    test "new/1" do
      %SCBytes{value: sc_bytes} =
        SCBytes.new(<<0, 0, 0, 9, 71, 67, 73, 90, 51, 71, 83, 77, 53, 0, 0, 0>>)

      16 = String.length(sc_bytes)
    end

    test "encode_xdr/1", %{sc_bytes: sc_bytes, binary: binary} do
      {:ok, ^binary} = SCBytes.encode_xdr(sc_bytes)
    end

    test "encode_xdr!/1", %{sc_bytes: sc_bytes, binary: binary} do
      ^binary = SCBytes.encode_xdr!(sc_bytes)
    end

    test "decode_xdr/2", %{sc_bytes: sc_bytes, binary: binary} do
      {:ok, {^sc_bytes, ""}} = SCBytes.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = SCBytes.decode_xdr(123)
    end

    test "decode_xdr!/2", %{sc_bytes: sc_bytes, binary: binary} do
      {^sc_bytes, ""} = SCBytes.decode_xdr!(binary)
    end
  end
end
