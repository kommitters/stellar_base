defmodule Stellar.StrKeyTest do
  use ExUnit.Case

  describe "encode/2" do
    setup do
      %{
        public_key:
          <<140, 41, 54, 138, 42, 205, 199, 107, 245, 247, 190, 85, 36, 15, 30, 168, 67, 63, 52,
            183, 198, 97, 56, 146, 34, 127, 90, 21, 230, 0, 172, 89>>,
        secret:
          <<127, 163, 126, 166, 136, 15, 165, 129, 151, 221, 156, 135, 202, 45, 45, 185, 52, 111,
            173, 5, 90, 103, 30, 86, 91, 252, 46, 30, 88, 113, 54, 85>>
      }
    end

    test "nil data" do
      assert_raise ArgumentError, "cannot encode nil data", fn ->
        Stellar.StrKey.encode!(:ed25519PublicKey, nil)
      end
    end

    test "invalid version name", %{public_key: public_key} do
      assert_raise ArgumentError,
                   "ed25519Test is not a valid version byte name. Expected one of ed25519PublicKey, ed25519SecretSeed.",
                   fn ->
                     Stellar.StrKey.encode!(:ed25519Test, public_key)
                   end
    end

    test "public key", %{public_key: public_key} do
      "GCGCSNUKFLG4O27V667FKJAPD2UEGPZUW7DGCOESEJ7VUFPGACWFT6CB" =
        Stellar.StrKey.encode!(:ed25519PublicKey, public_key)
    end

    test "secret", %{secret: secret} do
      "SB72G7VGRAH2LAMX3WOIPSRNFW4TI35NAVNGOHSWLP6C4HSYOE3FLMOS" =
        Stellar.StrKey.encode!(:ed25519SecretSeed, secret)
    end
  end

  describe "decode/2" do
    setup do
      %{
        public_key: "GCGCSNUKFLG4O27V667FKJAPD2UEGPZUW7DGCOESEJ7VUFPGACWFT6CB",
        secret: "SB72G7VGRAH2LAMX3WOIPSRNFW4TI35NAVNGOHSWLP6C4HSYOE3FLMOS"
      }
    end

    test "public key", %{public_key: public_key} do
      <<140, 41, 54, 138, 42, 205, 199, 107, 245, 247, 190, 85, 36, 15, 30, 168, 67, 63, 52, 183,
        198, 97, 56, 146, 34, 127, 90, 21, 230, 0, 172,
        89>> = Stellar.StrKey.decode!(:ed25519PublicKey, public_key)
    end

    test "secret", %{secret: secret} do
      <<127, 163, 126, 166, 136, 15, 165, 129, 151, 221, 156, 135, 202, 45, 45, 185, 52, 111, 173,
        5, 90, 103, 30, 86, 91, 252, 46, 30, 88, 113, 54,
        85>> = Stellar.StrKey.decode!(:ed25519SecretSeed, secret)
    end

    test "invalid version byte", %{secret: secret} do
      assert_raise ArgumentError, "invalid version byte. Expected 48, got 144", fn ->
        Stellar.StrKey.decode!(:ed25519PublicKey, secret)
      end
    end

    test "invalid version name", %{public_key: public_key} do
      assert_raise ArgumentError,
                   "ed25519Test is not a valid version byte name. Expected one of ed25519PublicKey, ed25519SecretSeed.",
                   fn ->
                     Stellar.StrKey.decode!(:ed25519Test, public_key)
                   end
    end

    test "invalid checksum" do
      assert_raise ArgumentError, "invalid checksum", fn ->
        Stellar.StrKey.decode!(
          :ed25519SecretSeed,
          "SB72G7VGRAH2LAMX3WOIPSRNFW4TI35NAVNGOHSWLP6C4HSYOE3FLMSS"
        )
      end
    end

    test "incorrect padding" do
      assert_raise ArgumentError, "incorrect padding", fn ->
        Stellar.StrKey.decode!(:ed25519PublicKey, "SB72G7VGRAH")
      end
    end
  end
end
