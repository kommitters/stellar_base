defmodule Stellar.Ed25519.StrKeyTest do
  use ExUnit.Case

  import Bitwise

  alias Stellar.Ed25519.StrKey

  @pk_version_bytes 6 <<< 3
  @sk_version_bytes 18 <<< 3

  setup do
    %{
      public_key: "GCGCSNUKFLG4O27V667FKJAPD2UEGPZUW7DGCOESEJ7VUFPGACWFT6CB",
      secret_seed: "SB72G7VGRAH2LAMX3WOIPSRNFW4TI35NAVNGOHSWLP6C4HSYOE3FLMOS",
      public_key_binary:
        <<140, 41, 54, 138, 42, 205, 199, 107, 245, 247, 190, 85, 36, 15, 30, 168, 67, 63, 52,
          183, 198, 97, 56, 146, 34, 127, 90, 21, 230, 0, 172, 89>>,
      secret_seed_binary:
        <<127, 163, 126, 166, 136, 15, 165, 129, 151, 221, 156, 135, 202, 45, 45, 185, 52, 111,
          173, 5, 90, 103, 30, 86, 91, 252, 46, 30, 88, 113, 54, 85>>
    }
  end

  describe "encode!/2" do
    test "nil data" do
      assert_raise ArgumentError, "cannot encode nil data", fn -> StrKey.encode!(nil, @pk_version_bytes) end
    end

    test "public key", %{public_key: public_key, public_key_binary: public_key_binary} do
      ^public_key = StrKey.encode!(public_key_binary, @pk_version_bytes)
    end

    test "secret", %{secret_seed: secret_seed, secret_seed_binary: secret_seed_binary} do
      ^secret_seed = StrKey.encode!(secret_seed_binary, @sk_version_bytes)
    end
  end

  describe "decode/2" do
    test "public key", %{public_key: public_key, public_key_binary: public_key_binary} do
      ^public_key_binary = StrKey.decode!(public_key, @pk_version_bytes)
    end

    test "secret", %{secret_seed: secret_seed, secret_seed_binary: secret_seed_binary} do
      ^secret_seed_binary = StrKey.decode!(secret_seed, @sk_version_bytes)
    end

    test "invalid version byte", %{secret_seed: secret_seed} do
      assert_raise ArgumentError, "invalid version byte. Expected 48, got 144", fn ->
        StrKey.decode!(secret_seed, @pk_version_bytes)
      end
    end

    test "invalid checksum" do
      bad_secret_key = "SB72G7VGRAH2LAMX3WOIPSRNFW4TI35NAVNGOHSWLP6C4HSYOE3FLMSS"
      assert_raise ArgumentError, "invalid checksum", fn ->
        StrKey.decode!(bad_secret_key, @sk_version_bytes)
      end
    end

    test "incorrect padding" do
      assert_raise ArgumentError, "incorrect padding", fn ->
        StrKey.decode!("SB72G7VGRAH", @sk_version_bytes)
      end
    end
  end
end
