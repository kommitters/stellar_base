defmodule Stellar.XDR.OpaqueTest do
  use ExUnit.Case

  alias Stellar.XDR.{Opaque4, Opaque12, Opaque32, VariableOpaque64, Hash}

  describe "Opaque4" do
    setup do
      %{binary: <<0, 0, 4, 210>>}
    end

    test "new/1", %{binary: binary} do
      %Opaque4{opaque: ^binary, length: 4} = Opaque4.new(binary)
    end

    test "encode_xdr/1", %{binary: binary} do
      {:ok, ^binary} = Opaque4.encode_xdr(binary)
    end

    test "encode_xdr!/1", %{binary: binary} do
      ^binary = Opaque4.encode_xdr!(binary)
    end

    test "decode_xdr/1", %{binary: binary} do
      {:ok, {%Opaque4{opaque: ^binary}, ""}} = Opaque4.decode_xdr(binary)
    end

    test "decode_xdr!/1", %{binary: binary} do
      {%Opaque4{opaque: ^binary}, ""} = Opaque4.decode_xdr!(binary)
    end

    test "invalid length" do
      {:error, :invalid_length} = Opaque4.encode_xdr(<<0, 0, 4, 210, 33>>)
    end
  end

  describe "Opaque12" do
    setup do
      %{binary: <<0, 0, 4, 6, 0, 10, 4, 210, 1, 3, 6, 99>>}
    end

    test "new/1", %{binary: binary} do
      %Opaque12{opaque: ^binary, length: 12} = Opaque12.new(binary)
    end

    test "encode_xdr/1", %{binary: binary} do
      {:ok, ^binary} = Opaque12.encode_xdr(binary)
    end

    test "encode_xdr!/1", %{binary: binary} do
      ^binary = Opaque12.encode_xdr!(binary)
    end

    test "decode_xdr/1", %{binary: binary} do
      {:ok, {%Opaque12{opaque: ^binary}, ""}} = Opaque12.decode_xdr(binary)
    end

    test "decode_xdr!/1", %{binary: binary} do
      {%Opaque12{opaque: ^binary}, ""} = Opaque12.decode_xdr!(binary)
    end

    test "invalid length" do
      {:error, :invalid_length} = Opaque12.encode_xdr(<<0, 0, 4, 210, 33>>)
    end
  end

  describe "Opaque32" do
    setup do
      %{binary: "GCIZ3GSM5XL7OUS4UP64THMDZ7CZ3ZWN"}
    end

    test "new/1", %{binary: binary} do
      %Opaque32{opaque: ^binary, length: 32} = Opaque32.new(binary)
    end

    test "encode_xdr/1", %{binary: binary} do
      {:ok, ^binary} = Opaque32.encode_xdr(binary)
    end

    test "encode_xdr!/1", %{binary: binary} do
      ^binary = Opaque32.encode_xdr!(binary)
    end

    test "decode_xdr/1", %{binary: binary} do
      {:ok, {%Opaque32{opaque: ^binary}, ""}} = Opaque32.decode_xdr(binary)
    end

    test "decode_xdr!/1", %{binary: binary} do
      {%Opaque32{opaque: ^binary}, ""} = Opaque32.decode_xdr!(binary)
    end

    test "invalid length" do
      {:error, :invalid_length} = Opaque32.encode_xdr(<<0, 0, 4, 210, 33>>)
    end
  end

  describe "VariableOpaque64" do
    setup do
      %{
        opaque: "GCIZ3GSM5",
        binary: <<0, 0, 0, 9, 71, 67, 73, 90, 51, 71, 83, 77, 53, 0, 0, 0>>
      }
    end

    test "new/1", %{opaque: opaque} do
      %VariableOpaque64{opaque: ^opaque, max_size: 64} = VariableOpaque64.new(opaque)
    end

    test "encode_xdr/1", %{opaque: opaque, binary: binary} do
      {:ok, ^binary} = VariableOpaque64.encode_xdr(opaque)
    end

    test "encode_xdr!/1", %{opaque: opaque, binary: binary} do
      ^binary = VariableOpaque64.encode_xdr!(opaque)
    end

    test "decode_xdr/1", %{opaque: opaque, binary: binary} do
      {:ok, {%VariableOpaque64{opaque: ^opaque}, ""}} = VariableOpaque64.decode_xdr(binary)
    end

    test "decode_xdr!/1", %{opaque: opaque, binary: binary} do
      {%VariableOpaque64{opaque: ^opaque}, ""} = VariableOpaque64.decode_xdr!(binary)
    end

    test "invalid length" do
      {:error, :invalid_length} =
        VariableOpaque64.encode_xdr(
          "GCIZ3GSM5XL7OUS4UP64THMDZ7CZ3ZWNTMGKKUPT4V3UMXIKUS4UP64THMDZ7CZ3Z"
        )
    end
  end

  describe "Hash" do
    setup do
      %{binary: "GCIZ3GSM5XL7OUS4UP64THMDZ7CZ3ZWN"}
    end

    test "new/1", %{binary: binary} do
      %Hash{hash: ^binary} = Hash.new(binary)
    end

    test "encode_xdr/1", %{binary: binary} do
      {:ok, ^binary} = Hash.encode_xdr(binary)
    end

    test "encode_xdr!/1", %{binary: binary} do
      ^binary = Hash.encode_xdr!(binary)
    end

    test "decode_xdr/1", %{binary: binary} do
      {:ok, {%Hash{hash: ^binary}, ""}} = Hash.decode_xdr(binary)
    end

    test "decode_xdr!/1", %{binary: binary} do
      {%Hash{hash: ^binary}, ""} = Hash.decode_xdr!(binary)
    end

    test "invalid length" do
      {:error, :invalid_length} = Hash.encode_xdr(<<0, 0, 4, 210, 33>>)
    end
  end
end
