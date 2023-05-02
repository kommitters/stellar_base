defmodule StellarBase.StrKeyTest do
  use ExUnit.Case

  alias StellarBase.{StrKey, StrKeyError}

  setup do
    %{
      ed25519_public_key: "GCGCSNUKFLG4O27V667FKJAPD2UEGPZUW7DGCOESEJ7VUFPGACWFT6CB",
      ed25519_secret_seed: "SB72G7VGRAH2LAMX3WOIPSRNFW4TI35NAVNGOHSWLP6C4HSYOE3FLMOS",
      muxed_account: "MBGQQPI4ZY4MB4ALVOUBVZS6RYLZFA2GDZIFUJNKKPGK22N3XGAW2AAAAAAAAAAAAHRJ4",
      pre_auth_tx: "TBAUEQ2EIVDEOSCJJJFUYTKOJ5IFCUSTKRAUEQ2EIVDEOSCJJJAUCYSF",
      signed_payload:
        "PA7QYNF7SOWQ3GLR2BGMZEHXAVIRZA4KVWLTJJFC7MGXUA74P7UJUAAAAAQACAQDAQCQMBYIBEFAWDANBYHRAEISCMKBKFQXDAMRUGY4DUPB6IBZGM",
      contract: "CCEMOFO5TE7FGOAJOA3RDHPC6RW3CFXRVIGOFQPFE4ZGOKA2QEA636SN",
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
        <<77, 8, 61, 28, 206, 56, 192, 240, 11, 171, 168, 26, 230, 94, 142, 23, 146, 131, 70, 30,
          80, 90, 37, 170, 83, 204, 173, 105, 187, 185, 129, 109, 0, 0, 0, 0, 0, 0, 0, 1>>,
      signed_payload_binary:
        <<63, 12, 52, 191, 147, 173, 13, 153, 113, 208, 76, 204, 144, 247, 5, 81, 28, 131, 138,
          173, 151, 52, 164, 162, 251, 13, 122, 3, 252, 127, 232, 154, 0, 0, 0, 32, 1, 2, 3, 4, 5,
          6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28,
          29, 30, 31, 32>>,
      contract_binary:
        <<136, 199, 21, 221, 153, 62, 83, 56, 9, 112, 55, 17, 157, 226, 244, 109, 177, 22, 241,
          170, 12, 226, 193, 229, 39, 50, 103, 40, 26, 129, 1, 237>>
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

    test "signed_payload", %{signed_payload: signed_payload, signed_payload_binary: binary} do
      {:ok, ^signed_payload} = StrKey.encode(binary, :signed_payload)
    end

    test "contract", %{contract: contract, contract_binary: binary} do
      {:ok, ^contract} = StrKey.encode(binary, :contract)
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

    test "signed_payload", %{signed_payload: signed_payload, signed_payload_binary: binary} do
      ^signed_payload = StrKey.encode!(binary, :signed_payload)
    end

    test "contract", %{contract: contract, contract_binary: binary} do
      ^contract = StrKey.encode!(binary, :contract)
    end
  end

  describe "decode/2" do
    test "nil data" do
      {:error, :cant_decode_nil_data} = StrKey.decode(nil, :ed25519_public_key)
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

    test "signed_payload", %{signed_payload: signed_payload, signed_payload_binary: binary} do
      {:ok, ^binary} = StrKey.decode(signed_payload, :signed_payload)
    end

    test "contract", %{contract: contract, contract_binary: binary} do
      {:ok, ^binary} = StrKey.decode(contract, :contract)
    end

    test "invalid version byte", %{muxed_account: muxed_account} do
      {:error, :unmatched_version_bytes} = StrKey.decode(muxed_account, :ed25519_public_key)
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

    test "signed_payload", %{signed_payload: signed_payload, signed_payload_binary: binary} do
      ^binary = StrKey.decode!(signed_payload, :signed_payload)
    end

    test "contract", %{contract: contract, contract_binary: binary} do
      ^binary = StrKey.decode!(contract, :contract)
    end

    test "invalid version byte", %{muxed_account: muxed_account} do
      assert_raise StrKeyError, "version bytes does not match", fn ->
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
      assert_raise StrKeyError, "cannot decode data", fn ->
        StrKey.decode!("SB72G7VGRAH", :ed25519_public_key)
      end
    end
  end
end
