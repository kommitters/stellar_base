defmodule Stellar.XDR.Opaque12Test do
  use ExUnit.Case

  alias Stellar.XDR.Opaque12

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
end
