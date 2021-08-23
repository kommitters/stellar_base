defmodule Stellar.Ed25519.SecretSeedTest do
  use ExUnit.Case

  alias Stellar.Ed25519.SecretSeed

  describe "PublicKey" do
    setup do
      %{
        secret_seed: "SB72G7VGRAH2LAMX3WOIPSRNFW4TI35NAVNGOHSWLP6C4HSYOE3FLMOS",
        secret_seed_binary:
          <<127, 163, 126, 166, 136, 15, 165, 129, 151, 221, 156, 135, 202, 45, 45, 185, 52, 111,
            173, 5, 90, 103, 30, 86, 91, 252, 46, 30, 88, 113, 54, 85>>
      }
    end

    test "encode!/2 with nil data" do
      assert_raise ArgumentError, "cannot encode nil data", fn ->
        SecretSeed.encode!(nil)
      end
    end

    test "encode!/2", %{secret_seed: secret_seed, secret_seed_binary: secret_seed_binary} do
      ^secret_seed = SecretSeed.encode!(secret_seed_binary)
    end

    test "decode!/2 with nil data" do
      assert_raise ArgumentError, "cannot decode nil data", fn ->
        SecretSeed.decode!(nil)
      end
    end

    test "decode!/2", %{secret_seed: secret_seed, secret_seed_binary: secret_seed_binary} do
      ^secret_seed_binary = SecretSeed.decode!(secret_seed)
    end
  end
end
