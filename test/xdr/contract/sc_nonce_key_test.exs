defmodule StellarBase.XDR.SCNonceKeyTest do
  use ExUnit.Case

  alias StellarBase.StrKey

  alias StellarBase.XDR.{
    AccountID,
    SCNonceKey,
    PublicKeyType,
    PublicKey,
    SCAddressType,
    SCAddress,
    Uint256
  }

  describe "SCNonceKey" do
    setup do
      pk_type = PublicKeyType.new(:PUBLIC_KEY_TYPE_ED25519)

      account_id =
        "GBZNLMUQMIN3VGUJISKZU7GNY3O3XLMYEHJCKCSMDHKLGSMKALRXOEZD"
        |> StrKey.decode!(:ed25519_public_key)
        |> Uint256.new()
        |> PublicKey.new(pk_type)
        |> AccountID.new()

      sc_address_type = SCAddressType.new(:SC_ADDRESS_TYPE_ACCOUNT)

      sc_address = SCAddress.new(account_id, sc_address_type)

      %{
        sc_address: sc_address,
        sc_nonce_key: SCNonceKey.new(sc_address),
        binary:
          <<0, 0, 0, 0, 0, 0, 0, 0, 114, 213, 178, 144, 98, 27, 186, 154, 137, 68, 149, 154, 124,
            205, 198, 221, 187, 173, 152, 33, 210, 37, 10, 76, 25, 212, 179, 73, 138, 2, 227,
            119>>
      }
    end

    test "new/1", %{sc_address: sc_address} do
      %SCNonceKey{nonce_address: ^sc_address} = SCNonceKey.new(sc_address)
    end

    test "encode_xdr/1", %{sc_nonce_key: sc_nonce_key, binary: binary} do
      {:ok, ^binary} = SCNonceKey.encode_xdr(sc_nonce_key)
    end

    test "encode_xdr!/1", %{sc_nonce_key: sc_nonce_key, binary: binary} do
      ^binary = SCNonceKey.encode_xdr!(sc_nonce_key)
    end

    test "decode_xdr/2", %{sc_nonce_key: sc_nonce_key, binary: binary} do
      {:ok, {^sc_nonce_key, ""}} = SCNonceKey.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = SCNonceKey.decode_xdr(123)
    end

    test "decode_xdr!/2", %{sc_nonce_key: sc_nonce_key, binary: binary} do
      {^sc_nonce_key, ^binary} = SCNonceKey.decode_xdr!(binary <> binary)
    end
  end
end
