defmodule Stellar.XDR.Opaque32Test do
  use ExUnit.Case

  alias Stellar.XDR.Opaque32

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

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = Opaque32.decode_xdr(123)
    end

    test "decode_xdr!/2", %{opaque32: opaque32, binary: binary} do
      {^opaque32, ""} = Opaque32.decode_xdr!(binary)
    end

    test "invalid length" do
      {:error, :invalid_length} = Opaque32.encode_xdr(%Opaque32{opaque: <<0, 0, 4, 210, 33>>})
    end
  end
end
