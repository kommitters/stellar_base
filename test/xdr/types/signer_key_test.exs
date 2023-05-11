defmodule StellarBase.XDR.SignerKeyTest do
  use ExUnit.Case

  alias StellarBase.XDR.{
    Uint256,
    SignerKey,
    SignerKeyType,
    VariableOpaque64,
    SignerKeyEd25519SignedPayload
  }

  describe "SignerKey" do
    setup do
      key_type = SignerKeyType.new(:SIGNER_KEY_TYPE_PRE_AUTH_TX)

      signer_key = %Uint256{
        value:
          <<212, 0, 101, 81, 198, 125, 231, 7, 52, 169, 69, 41, 203, 220, 194, 236, 237, 53, 66,
            44, 182, 180, 40, 82, 226, 20, 174, 51, 61, 35, 235, 218>>
      }

      encoded_binary =
        <<0, 0, 0, 1, 212, 0, 101, 81, 198, 125, 231, 7, 52, 169, 69, 41, 203, 220, 194, 236, 237,
          53, 66, 44, 182, 180, 40, 82, 226, 20, 174, 51, 61, 35, 235, 218>>

      %{
        encoded_binary: encoded_binary,
        key_type: key_type,
        key_type_id: :SIGNER_KEY_TYPE_PRE_AUTH_TX,
        signer_key: signer_key,
        xdr_type: SignerKey.new(signer_key, key_type)
      }
    end

    test "new/1", %{key_type_id: type_id, signer_key: signer_key, key_type: key_type} do
      %SignerKey{type: %SignerKeyType{identifier: ^type_id}} = SignerKey.new(signer_key, key_type)
    end

    test "encode_xdr/1", %{xdr_type: xdr_type, encoded_binary: binary} do
      {:ok, ^binary} = SignerKey.encode_xdr(xdr_type)
    end

    test "encode_xdr!/1", %{xdr_type: xdr_type, encoded_binary: binary} do
      ^binary = SignerKey.encode_xdr!(xdr_type)
    end

    test "decode_xdr/2", %{xdr_type: xdr_type, encoded_binary: binary} do
      {:ok, {^xdr_type, ""}} = SignerKey.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = SignerKey.decode_xdr(123)
    end

    test "decode_xdr!/2", %{xdr_type: xdr_type, encoded_binary: binary} do
      {^xdr_type, ^binary} = SignerKey.decode_xdr!(binary <> binary)
    end

    test "invalid public key", %{key_type: key_type} do
      assert_raise XDR.FixedOpaqueError,
                   "The length that is passed through parameters must be equal or less to the byte size of the XDR to complete",
                   fn ->
                     %Uint256{value: <<32, 0, 117>>}
                     |> SignerKey.new(key_type)
                     |> SignerKey.encode_xdr()
                   end
    end
  end

  describe "SignerKey with ED25519_SIGNED_PAYLOAD" do
    setup do
      key_type = SignerKeyType.new(:SIGNER_KEY_TYPE_ED25519_SIGNED_PAYLOAD)

      ed25519 = %Uint256{
        value:
          <<212, 0, 101, 81, 198, 125, 231, 7, 52, 169, 69, 41, 203, 220, 194, 236, 237, 53, 66,
            44, 182, 180, 40, 82, 226, 20, 174, 51, 61, 35, 235, 218>>
      }

      payload = VariableOpaque64.new("0102030405060708090a0b")

      signer_key = SignerKeyEd25519SignedPayload.new(ed25519, payload)

      encoded_binary =
        <<0, 0, 0, 3, 212, 0, 101, 81, 198, 125, 231, 7, 52, 169, 69, 41, 203, 220, 194, 236, 237,
          53, 66, 44, 182, 180, 40, 82, 226, 20, 174, 51, 61, 35, 235, 218, 0, 0, 0, 22, 48, 49,
          48, 50, 48, 51, 48, 52, 48, 53, 48, 54, 48, 55, 48, 56, 48, 57, 48, 97, 48, 98, 0, 0>>

      %{
        ed25519: ed25519,
        payload: payload,
        encoded_binary: encoded_binary,
        key_type: key_type,
        key_type_id: :SIGNER_KEY_TYPE_ED25519_SIGNED_PAYLOAD,
        signer_key: signer_key,
        xdr_type: SignerKey.new(signer_key, key_type)
      }
    end

    test "new/1", %{key_type_id: type_id, signer_key: signer_key, key_type: key_type} do
      %SignerKey{type: %SignerKeyType{identifier: ^type_id}} = SignerKey.new(signer_key, key_type)
    end

    test "encode_xdr/1", %{xdr_type: xdr_type, encoded_binary: binary} do
      {:ok, ^binary} = SignerKey.encode_xdr(xdr_type)
    end

    test "encode_xdr!/1", %{xdr_type: xdr_type, encoded_binary: binary} do
      ^binary = SignerKey.encode_xdr!(xdr_type)
    end

    test "decode_xdr/2", %{xdr_type: xdr_type, encoded_binary: binary} do
      {:ok, {^xdr_type, ""}} = SignerKey.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = SignerKey.decode_xdr(123)
    end

    test "decode_xdr!/2", %{xdr_type: xdr_type, encoded_binary: binary} do
      {^xdr_type, ^binary} = SignerKey.decode_xdr!(binary <> binary)
    end

    test "invalid public key", %{key_type: key_type} do
      assert_raise XDR.FixedOpaqueError,
                   "The length that is passed through parameters must be equal or less to the byte size of the XDR to complete",
                   fn ->
                     %SignerKeyEd25519SignedPayload{
                       ed25519: %Uint256{
                         value: <<32, 0, 117>>
                       },
                       payload: %VariableOpaque64{
                         opaque: "0102030405060708090a0b"
                       }
                     }
                     |> SignerKey.new(key_type)
                     |> SignerKey.encode_xdr()
                   end
    end
  end
end
