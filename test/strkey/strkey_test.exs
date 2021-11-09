defmodule StellarBase.StrKeyTest do
  use ExUnit.Case

  alias StellarBase.{StrKey, StrKeyError}

  setup do
    %{
      ed25519_public_key: "GCGCSNUKFLG4O27V667FKJAPD2UEGPZUW7DGCOESEJ7VUFPGACWFT6CB",
      ed25519_secret_seed: "SB72G7VGRAH2LAMX3WOIPSRNFW4TI35NAVNGOHSWLP6C4HSYOE3FLMOS",
      muxed_account: "MB72G7VGRAH2LAMX3WOIPSRNFW4TI35NAVNGOHSWLP6C4HSYOE3FL2US",
      pre_auth_tx: "TBAUEQ2EIVDEOSCJJJFUYTKOJ5IFCUSTKRAUEQ2EIVDEOSCJJJAUCYSF",
      ed25519_public_key_binary:
        <<140, 41, 54, 138, 42, 205, 199, 107, 245, 247, 190, 85, 36, 15, 30, 168, 67, 63, 52,
          183, 198, 97, 56, 146, 34, 127, 90, 21, 230, 0, 172, 89>>,
      ed25519_secret_seed_binary:
        <<127, 163, 126, 166, 136, 15, 165, 129, 151, 221, 156, 135, 202, 45, 45, 185, 52, 111,
          173, 5, 90, 103, 30, 86, 91, 252, 46, 30, 88, 113, 54, 85>>,
      pre_auth_tx_binary:
        <<65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 65, 66,
          67, 68, 69, 70, 71, 72, 73, 74, 65, 65>>,
      muxed_account_binary:
        <<127, 163, 126, 166, 136, 15, 165, 129, 151, 221, 156, 135, 202, 45, 45, 185, 52, 111,
          173, 5, 90, 103, 30, 86, 91, 252, 46, 30, 88, 113, 54, 85>>
    }
  end

  describe "encode/2" do
    test "nil data" do
      {:error, :invalid_binary} = StrKey.encode(nil, :ed25519_public_key)
    end

    test "ed25519_public_key", %{ed25519_public_key: key, ed25519_public_key_binary: binary} do
      {:ok, ^key} = StrKey.encode(binary, :ed25519_public_key)
    end

    test "ed25519_secret_seed", %{ed25519_secret_seed: seed, ed25519_secret_seed_binary: binary} do
      {:ok, ^seed} = StrKey.encode(binary, :ed25519_secret_seed)
    end

    test "muxed_account", %{muxed_account: muxed_account, muxed_account_binary: binary} do
      {:ok, ^muxed_account} = StrKey.encode(binary, :muxed_account)
    end

    test "pre_auth_tx", %{pre_auth_tx: pre_auth_tx, pre_auth_tx_binary: binary} do
      {:ok, ^pre_auth_tx} = StrKey.encode(binary, :pre_auth_tx)
    end
  end

  describe "encode!/2" do
    test "nil data" do
      assert_raise StrKeyError, "cannot encode nil data", fn ->
        StrKey.encode!(nil, :ed25519_public_key)
      end
    end

    test "ed25519_public_key", %{ed25519_public_key: key, ed25519_public_key_binary: binary} do
      ^key = StrKey.encode!(binary, :ed25519_public_key)
    end

    test "ed25519_secret_seed", %{ed25519_secret_seed: seed, ed25519_secret_seed_binary: binary} do
      ^seed = StrKey.encode!(binary, :ed25519_secret_seed)
    end

    test "muxed_account", %{muxed_account: muxed_account, muxed_account_binary: binary} do
      ^muxed_account = StrKey.encode!(binary, :muxed_account)
    end

    test "pre_auth_tx", %{pre_auth_tx: pre_auth_tx, pre_auth_tx_binary: binary} do
      ^pre_auth_tx = StrKey.encode!(binary, :pre_auth_tx)
    end
  end

  describe "decode/2" do
    test "nil data" do
      {:error, :invalid_data} = StrKey.decode(nil, :ed25519_public_key)
    end

    test "ed25519_public_key", %{ed25519_public_key: key, ed25519_public_key_binary: binary} do
      {:ok, ^binary} = StrKey.decode(key, :ed25519_public_key)
    end

    test "ed25519_secret_seed", %{ed25519_secret_seed: seed, ed25519_secret_seed_binary: binary} do
      {:ok, ^binary} = StrKey.decode(seed, :ed25519_secret_seed)
    end

    test "muxed_account", %{muxed_account: muxed_account, muxed_account_binary: binary} do
      {:ok, ^binary} = StrKey.decode(muxed_account, :muxed_account)
    end

    test "pre_auth_tx", %{pre_auth_tx: pre_auth_tx, pre_auth_tx_binary: binary} do
      {:ok, ^binary} = StrKey.decode(pre_auth_tx, :pre_auth_tx)
    end

    test "invalid version byte", %{muxed_account: muxed_account} do
      {:error, :unmatched_version_byte} = StrKey.decode(muxed_account, :ed25519_public_key)
    end

    test "invalid checksum" do
      {:error, :invalid_checksum} =
        StrKey.decode(
          "SB72G7VGRAH2LAMX3WOIPSRNFW4TI35NAVNGOHSWLP6C4HPYOE3FLMSS",
          :ed25519_secret_seed
        )
    end
  end

  describe "decode!/2" do
    test "nil data" do
      assert_raise StrKeyError, "cannot decode nil data", fn ->
        StrKey.decode!(nil, :ed25519_public_key)
      end
    end

    test "ed25519_public_key", %{ed25519_public_key: key, ed25519_public_key_binary: binary} do
      ^binary = StrKey.decode!(key, :ed25519_public_key)
    end

    test "ed25519_secret_seed", %{ed25519_secret_seed: seed, ed25519_secret_seed_binary: binary} do
      ^binary = StrKey.decode!(seed, :ed25519_secret_seed)
    end

    test "muxed_account", %{muxed_account: muxed_account, muxed_account_binary: binary} do
      ^binary = StrKey.decode!(muxed_account, :muxed_account)
    end

    test "pre_auth_tx", %{pre_auth_tx: pre_auth_tx, pre_auth_tx_binary: binary} do
      ^binary = StrKey.decode!(pre_auth_tx, :pre_auth_tx)
    end

    test "invalid version byte", %{muxed_account: muxed_account} do
      assert_raise StrKeyError, "version byte does not match", fn ->
        StrKey.decode!(muxed_account, :ed25519_public_key)
      end
    end

    test "invalid checksum" do
      assert_raise StrKeyError, "invalid checksum", fn ->
        StrKey.decode!(
          "SB72G7VGRAH2LAMX3WOIPSRNFW4TI35NAVNGOHSWLP6P4HSYOE3FLMSS",
          :ed25519_secret_seed
        )
      end
    end

    test "incorrect padding" do
      assert_raise ArgumentError, "incorrect padding", fn ->
        StrKey.decode!("SB72G7VGRAH", :ed25519_public_key)
      end
    end
  end
end
