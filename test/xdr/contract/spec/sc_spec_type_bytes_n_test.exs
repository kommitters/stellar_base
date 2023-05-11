defmodule StellarBase.XDR.SCSpecTypeBytesNTest do
  use ExUnit.Case

  alias StellarBase.XDR.{SCSpecTypeBytesN, Uint32}

  describe "SCSpecTypeBytesN" do
    setup do
      number = Uint32.new(4_294_967_295)

      %{
        number: number,
        sc_spec_type_bytes_n: SCSpecTypeBytesN.new(number),
        binary: <<255, 255, 255, 255>>
      }
    end

    test "new/1", %{number: number} do
      %SCSpecTypeBytesN{n: ^number} = SCSpecTypeBytesN.new(number)
    end

    test "encode_xdr/1", %{sc_spec_type_bytes_n: sc_spec_type_bytes_n, binary: binary} do
      {:ok, ^binary} = SCSpecTypeBytesN.encode_xdr(sc_spec_type_bytes_n)
    end

    test "encode_xdr!/1", %{sc_spec_type_bytes_n: sc_spec_type_bytes_n, binary: binary} do
      ^binary = SCSpecTypeBytesN.encode_xdr!(sc_spec_type_bytes_n)
    end

    test "decode_xdr/2", %{sc_spec_type_bytes_n: sc_spec_type_bytes_n, binary: binary} do
      {:ok, {^sc_spec_type_bytes_n, ""}} = SCSpecTypeBytesN.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = SCSpecTypeBytesN.decode_xdr(123)
    end

    test "decode_xdr!/2", %{sc_spec_type_bytes_n: sc_spec_type_bytes_n, binary: binary} do
      {^sc_spec_type_bytes_n, ^binary} = SCSpecTypeBytesN.decode_xdr!(binary <> binary)
    end
  end
end
