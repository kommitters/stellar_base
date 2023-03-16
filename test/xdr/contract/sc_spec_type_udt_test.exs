defmodule StellarBase.XDR.SCSpecTypeUDTTest do
  use ExUnit.Case

  alias StellarBase.XDR.{SCSpecTypeUDT, String60}

  describe "SCSpecTypeUDT" do
    setup do
      name = String60.new("Hello there")

      %{
        name: name,
        sc_spec_type_bytes_n: SCSpecTypeUDT.new(name),
        binary: <<0, 0, 0, 11, 72, 101, 108, 108, 111, 32, 116, 104, 101, 114, 101, 0>>
      }
    end

    test "new/1", %{name: name} do
      %SCSpecTypeUDT{name: ^name} = SCSpecTypeUDT.new(name)
    end

    test "encode_xdr/1", %{sc_spec_type_bytes_n: sc_spec_type_bytes_n, binary: binary} do
      {:ok, ^binary} = SCSpecTypeUDT.encode_xdr(sc_spec_type_bytes_n)
    end

    test "encode_xdr!/1", %{sc_spec_type_bytes_n: sc_spec_type_bytes_n, binary: binary} do
      ^binary = SCSpecTypeUDT.encode_xdr!(sc_spec_type_bytes_n)
    end

    test "decode_xdr/2", %{sc_spec_type_bytes_n: sc_spec_type_bytes_n, binary: binary} do
      {:ok, {^sc_spec_type_bytes_n, ""}} = SCSpecTypeUDT.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = SCSpecTypeUDT.decode_xdr(123)
    end

    test "decode_xdr!/2", %{sc_spec_type_bytes_n: sc_spec_type_bytes_n, binary: binary} do
      {^sc_spec_type_bytes_n, ^binary} = SCSpecTypeUDT.decode_xdr!(binary <> binary)
    end
  end
end
