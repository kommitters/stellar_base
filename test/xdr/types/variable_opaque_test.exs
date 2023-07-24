defmodule StellarBase.XDR.VariableOpaqueTest do
  use ExUnit.Case

  alias StellarBase.XDR.VariableOpaque

  describe "VariableOpaque" do
    setup do
      %{
        variable_opaque256000: VariableOpaque.new("GCIZ3GSM5"),
        binary: <<0, 0, 0, 9, 71, 67, 73, 90, 51, 71, 83, 77, 53, 0, 0, 0>>
      }
    end

    test "new/1" do
      %VariableOpaque{opaque: variable_opaque256000} =
        VariableOpaque.new(<<0, 0, 0, 9, 71, 67, 73, 90, 51, 71, 83, 77, 53, 0, 0, 0>>)

      16 = String.length(variable_opaque256000)
    end

    test "encode_xdr/1", %{variable_opaque256000: variable_opaque256000, binary: binary} do
      {:ok, ^binary} = VariableOpaque.encode_xdr(variable_opaque256000)
    end

    test "encode_xdr!/1", %{variable_opaque256000: variable_opaque256000, binary: binary} do
      ^binary = VariableOpaque.encode_xdr!(variable_opaque256000)
    end

    test "decode_xdr/2", %{variable_opaque256000: variable_opaque256000, binary: binary} do
      {:ok, {^variable_opaque256000, ""}} = VariableOpaque.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = VariableOpaque.decode_xdr(123)
    end

    test "decode_xdr!/2", %{variable_opaque256000: variable_opaque256000, binary: binary} do
      {^variable_opaque256000, ""} = VariableOpaque.decode_xdr!(binary)
    end
  end
end
