defmodule Stellar.XDR.OpaqueTest do
  use ExUnit.Case

  alias Stellar.XDR.{Opaque4, Opaque12, Opaque32, VariableOpaque64, Hash}

  describe "Opaque4" do
    setup do
      %{
        opaque4: Opaque4.new(<<0, 0, 4, 210>>),
        binary: <<0, 0, 4, 210>>
      }
    end

    test "new/1" do
      %Opaque4{opaque: opaque} = Opaque4.new(<<0, 0, 4, 210>>)
      4 = String.length(opaque)
    end

    test "encode_xdr/1", %{opaque4: opaque4, binary: binary} do
      {:ok, ^binary} = Opaque4.encode_xdr(opaque4)
    end

    test "encode_xdr!/1", %{opaque4: opaque4, binary: binary} do
      ^binary = Opaque4.encode_xdr!(opaque4)
    end

    test "decode_xdr/2", %{opaque4: opaque4, binary: binary} do
      {:ok, {^opaque4, ""}} = Opaque4.decode_xdr(binary)
    end

    test "decode_xdr!/2", %{opaque4: opaque4, binary: binary} do
      {^opaque4, ""} = Opaque4.decode_xdr!(binary)
    end

    test "invalid length" do
      {:error, :invalid_length} = Opaque4.encode_xdr(%Opaque4{opaque: <<0, 0, 4, 210, 20>>})
    end
  end

  describe "Opaque12" do
    setup do
      %{
        opaque12: Opaque12.new(<<0, 0, 4, 6, 0, 10, 4, 210, 1, 3, 6, 99>>),
        binary: <<0, 0, 4, 6, 0, 10, 4, 210, 1, 3, 6, 99>>
      }
    end

    test "new/1" do
      %Opaque12{opaque: opaque} = Opaque12.new(<<0, 0, 4, 6, 0, 10, 4, 210, 1, 3, 6, 99>>)
      12 = String.length(opaque)
    end

    test "encode_xdr/1", %{opaque12: opaque12, binary: binary} do
      {:ok, ^binary} = Opaque12.encode_xdr(opaque12)
    end

    test "encode_xdr!/1", %{opaque12: opaque12, binary: binary} do
      ^binary = Opaque12.encode_xdr!(opaque12)
    end

    test "decode_xdr/2", %{opaque12: opaque12, binary: binary} do
      {:ok, {^opaque12, ""}} = Opaque12.decode_xdr(binary)
    end

    test "decode_xdr!/2", %{opaque12: opaque12, binary: binary} do
      {^opaque12, ""} = Opaque12.decode_xdr!(binary)
    end

    test "invalid length" do
      {:error, :invalid_length} = Opaque12.encode_xdr(%Opaque12{opaque: <<0, 0, 33>>})
    end
  end

  describe "Opaque32" do
    setup do
      %{
        opaque32: Opaque32.new("GCIZ3GSM5XL7OUS4UP64THMDZ7CZ3ZWN"),
        binary: "GCIZ3GSM5XL7OUS4UP64THMDZ7CZ3ZWN"
      }
    end

    test "new/1" do
      %Opaque32{opaque: opaque} = Opaque32.new("GCIZ3GSM5XL7OUS4UP64THMDZ7CZ3ZWN")
      32 = String.length(opaque)
    end

    test "encode_xdr/1", %{opaque32: opaque32, binary: binary} do
      {:ok, ^binary} = Opaque32.encode_xdr(opaque32)
    end

    test "encode_xdr!/1", %{opaque32: opaque32, binary: binary} do
      ^binary = Opaque32.encode_xdr!(opaque32)
    end

    test "decode_xdr/2", %{opaque32: opaque32, binary: binary} do
      {:ok, {^opaque32, ""}} = Opaque32.decode_xdr(binary)
    end

    test "decode_xdr!/2", %{opaque32: opaque32, binary: binary} do
      {^opaque32, ""} = Opaque32.decode_xdr!(binary)
    end

    test "invalid length" do
      {:error, :invalid_length} = Opaque32.encode_xdr(%Opaque32{opaque: <<0, 0, 4, 210, 33>>})
    end
  end

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

  describe "Hash" do
    setup do
      %{
        hash: Hash.new("GCIZ3GSM5XL7OUS4UP64THMDZ7CZ3ZWN"),
        binary: "GCIZ3GSM5XL7OUS4UP64THMDZ7CZ3ZWN"
      }
    end

    test "new/1" do
      %Hash{hash: "GCIZ3GSM5XL7OUS4UP64THMDZ7CZ3ZWN"} =
        Hash.new("GCIZ3GSM5XL7OUS4UP64THMDZ7CZ3ZWN")
    end

    test "encode_xdr/1", %{hash: hash, binary: binary} do
      {:ok, ^binary} = Hash.encode_xdr(hash)
    end

    test "encode_xdr!/1", %{hash: hash, binary: binary} do
      ^binary = Hash.encode_xdr!(hash)
    end

    test "decode_xdr/2", %{hash: hash, binary: binary} do
      {:ok, {^hash, ""}} = Hash.decode_xdr(binary)
    end

    test "decode_xdr!/2", %{hash: hash, binary: binary} do
      {^hash, ""} = Hash.decode_xdr!(binary)
    end

    test "invalid length" do
      {:error, :invalid_length} = Hash.encode_xdr(%Hash{hash: <<0, 0, 4, 210, 33>>})
    end
  end
end
