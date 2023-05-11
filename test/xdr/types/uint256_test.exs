defmodule StellarBase.XDR.Uint256Test do
  use ExUnit.Case

  alias StellarBase.XDR.Uint256

  describe "Uint256" do
    setup do
      %{
        uint256:
          Uint256.new(
            <<72, 101, 108, 108, 111, 32, 119, 111, 114, 108, 100, 0, 21, 0, 1, 0, 72, 101, 108,
              108, 111, 32, 119, 111, 114, 108, 100, 0, 21, 0, 1, 0>>
          ),
        binary:
          <<72, 101, 108, 108, 111, 32, 119, 111, 114, 108, 100, 0, 21, 0, 1, 0, 72, 101, 108,
            108, 111, 32, 119, 111, 114, 108, 100, 0, 21, 0, 1, 0>>
      }
    end

    test "new/1", %{binary: binary} do
      %Uint256{value: ^binary} = Uint256.new(binary)
    end

    test "encode_xdr/1", %{uint256: uint256, binary: binary} do
      {:ok, ^binary} = Uint256.encode_xdr(uint256)
    end

    test "encode_xdr!/1", %{uint256: uint256, binary: binary} do
      ^binary = Uint256.encode_xdr!(uint256)
    end

    test "decode_xdr/2", %{uint256: uint256, binary: binary} do
      {:ok, {^uint256, ^binary}} = Uint256.decode_xdr(binary <> binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = Uint256.decode_xdr(123)
    end

    test "decode_xdr!/2", %{uint256: uint256, binary: binary} do
      {^uint256, ""} = Uint256.decode_xdr!(binary)
    end
  end
end
