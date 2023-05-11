defmodule StellarBase.XDR.Uint64Test do
  use ExUnit.Case

  alias StellarBase.XDR.Uint64

  describe "Uint64" do
    setup do
      %{
        uint64: Uint64.new(18_446_744_073_709_551_615),
        binary: <<255, 255, 255, 255, 255, 255, 255, 255>>
      }
    end

    test "new/1" do
      %Uint64{datum: 18_446_744_073_709_551_615} = Uint64.new(18_446_744_073_709_551_615)
    end

    test "encode_xdr/1", %{uint64: uint64, binary: binary} do
      {:ok, ^binary} = Uint64.encode_xdr(uint64)
    end

    test "encode_xdr!/1", %{uint64: uint64, binary: binary} do
      ^binary = Uint64.encode_xdr!(uint64)
    end

    test "decode_xdr/2", %{uint64: uint64, binary: binary} do
      {:ok, {^uint64, ^binary}} = Uint64.decode_xdr(binary <> binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = Uint64.decode_xdr(123)
    end

    test "decode_xdr!/2", %{uint64: uint64, binary: binary} do
      {^uint64, ""} = Uint64.decode_xdr!(binary)
    end
  end
end
