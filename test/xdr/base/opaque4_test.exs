defmodule Stellar.XDR.Opaque4Test do
  use ExUnit.Case

  alias Stellar.XDR.Opaque4

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

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = Opaque4.decode_xdr(123)
    end

    test "decode_xdr!/2", %{opaque4: opaque4, binary: binary} do
      {^opaque4, ""} = Opaque4.decode_xdr!(binary)
    end

    test "invalid length" do
      {:error, :invalid_length} = Opaque4.encode_xdr(%Opaque4{opaque: <<0, 0, 4, 210, 20>>})
    end
  end
end
