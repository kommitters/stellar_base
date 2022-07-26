defmodule StellarBase.XDR.SignerKeyListTest do
  use ExUnit.Case

  import StellarBase.Test.Utils

  alias StellarBase.XDR.{SignerKeyList, SignerKey, SignerKeyType}

  describe "SignerKeyList" do
    setup do
      key_type = SignerKeyType.new(:SIGNER_KEY_TYPE_PRE_AUTH_TX)

      signer_key_1 =
        "GCNY5OXYSY4FKHOPT2SPOQZAOEIGXB5LBYW3HVU3OWSTQITS65M5RCNY"
        |> ed25519_public_key()
        |> SignerKey.new(key_type)

      signer_key_2 =
        "GBZNLMUQMIN3VGUJISKZU7GNY3O3XLMYEHJCKCSMDHKLGSMKALRXOEZD"
        |> ed25519_public_key()
        |> SignerKey.new(key_type)

      signer_keys = [signer_key_1, signer_key_2]

      %{
        signer_keys: signer_keys,
        signer_key_list: SignerKeyList.new(signer_keys),
        binary:
          <<0, 0, 0, 2, 0, 0, 0, 1, 155, 142, 186, 248, 150, 56, 85, 29, 207, 158, 164, 247, 67,
            32, 113, 16, 107, 135, 171, 14, 45, 179, 214, 155, 117, 165, 56, 34, 114, 247, 89,
            216, 0, 0, 0, 1, 114, 213, 178, 144, 98, 27, 186, 154, 137, 68, 149, 154, 124, 205,
            198, 221, 187, 173, 152, 33, 210, 37, 10, 76, 25, 212, 179, 73, 138, 2, 227, 119>>
      }
    end

    test "new/1", %{signer_keys: signer_keys} do
      %SignerKeyList{signer_keys: ^signer_keys} = SignerKeyList.new(signer_keys)
    end

    test "encode_xdr/1", %{signer_key_list: signer_key_list, binary: binary} do
      {:ok, ^binary} = SignerKeyList.encode_xdr(signer_key_list)
    end

    test "encode_xdr!/1", %{signer_key_list: signer_key_list, binary: binary} do
      ^binary = SignerKeyList.encode_xdr!(signer_key_list)
    end

    test "decode_xdr/1", %{signer_key_list: signer_key_list, binary: binary} do
      {:ok, {^signer_key_list, ""}} = SignerKeyList.decode_xdr(binary)
    end

    test "decode_xdr/1 with an invalid binary" do
      {:error, :not_binary} = SignerKeyList.decode_xdr(123)
    end

    test "decode_xdr!/1", %{signer_key_list: signer_key_list, binary: binary} do
      {^signer_key_list, ""} = SignerKeyList.decode_xdr!(binary)
    end

    test "decode_xdr!/1 with an invalid binary" do
      assert_raise XDR.VariableArrayError,
                   "The value which you pass through parameters must be a binary value, for example: <<0, 0, 0, 5>>",
                   fn -> SignerKeyList.decode_xdr!(123) end
    end
  end
end
