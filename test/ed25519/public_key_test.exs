defmodule StellarBase.Ed25519.PublicKeyTest do
  use ExUnit.Case

  alias StellarBase.Ed25519.PublicKey

  describe "PublicKey" do
    setup do
      %{
        public_key: "GCGCSNUKFLG4O27V667FKJAPD2UEGPZUW7DGCOESEJ7VUFPGACWFT6CB",
        public_key_binary:
          <<140, 41, 54, 138, 42, 205, 199, 107, 245, 247, 190, 85, 36, 15, 30, 168, 67, 63, 52,
            183, 198, 97, 56, 146, 34, 127, 90, 21, 230, 0, 172, 89>>
      }
    end

    test "encode!/2 with nil data" do
      assert_raise ArgumentError, "cannot encode nil data", fn ->
        PublicKey.encode!(nil)
      end
    end

    test "encode!/2", %{public_key: public_key, public_key_binary: public_key_binary} do
      ^public_key = PublicKey.encode!(public_key_binary)
    end

    test "decode!/2 with nil data" do
      assert_raise ArgumentError, "cannot decode nil data", fn ->
        PublicKey.decode!(nil)
      end
    end

    test "decode!/2", %{public_key: public_key, public_key_binary: public_key_binary} do
      ^public_key_binary = PublicKey.decode!(public_key)
    end
  end
end
