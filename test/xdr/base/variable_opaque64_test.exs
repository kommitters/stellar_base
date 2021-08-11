defmodule Stellar.XDR.VariableOpaque64Test do
  use ExUnit.Case

  alias Stellar.XDR.VariableOpaque64

  describe "VariableOpaque64" do
    setup do
      %{
        variable_opaque64: VariableOpaque64.new("GCIZ3GSM5"),
        binary: <<0, 0, 0, 9, 71, 67, 73, 90, 51, 71, 83, 77, 53, 0, 0, 0>>
      }
    end

    test "new/1" do
      %VariableOpaque64{opaque: variable_opaque64} =
        VariableOpaque64.new(<<0, 0, 0, 9, 71, 67, 73, 90, 51, 71, 83, 77, 53, 0, 0, 0>>)

      16 = String.length(variable_opaque64)
    end

    test "encode_xdr/1", %{variable_opaque64: variable_opaque64, binary: binary} do
      {:ok, ^binary} = VariableOpaque64.encode_xdr(variable_opaque64)
    end

    test "encode_xdr!/1", %{variable_opaque64: variable_opaque64, binary: binary} do
      ^binary = VariableOpaque64.encode_xdr!(variable_opaque64)
    end

    test "decode_xdr/2", %{variable_opaque64: variable_opaque64, binary: binary} do
      {:ok, {^variable_opaque64, ""}} = VariableOpaque64.decode_xdr(binary)
    end

    test "decode_xdr!/2", %{variable_opaque64: variable_opaque64, binary: binary} do
      {^variable_opaque64, ""} = VariableOpaque64.decode_xdr!(binary)
    end

    test "invalid length" do
      {:error, :invalid_length} =
        VariableOpaque64.encode_xdr(%VariableOpaque64{
          opaque: "GCIZ3GSM5XL7OUS4UP64THMDZ7CZ3ZWNTMGKKUPT4V3UMXIKUS4UP64THMDZ7CZ3Z"
        })
    end
  end
end
