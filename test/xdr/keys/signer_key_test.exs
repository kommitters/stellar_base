defmodule Stellar.XDR.SignerKeyTest do
  use ExUnit.Case

  alias Stellar.XDR.{UInt256, SignerKey, SignerKeyType}

  describe "SignerKey" do
    setup do
      key_type = SignerKeyType.new(:SIGNER_KEY_TYPE_PRE_AUTH_TX)

      signer_key = %UInt256{
        datum:
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

    test "decode_xdr/1", %{xdr_type: xdr_type, encoded_binary: binary} do
      {:ok, {^xdr_type, ""}} = SignerKey.decode_xdr(binary)
    end

    test "decode_xdr!/1", %{xdr_type: xdr_type, encoded_binary: binary} do
      {^xdr_type, ^binary} = SignerKey.decode_xdr!(binary <> binary)
    end

    test "invalid public key", %{key_type: key_type} do
      assert_raise XDR.Error.FixedOpaque,
                   "The length that is passed through parameters must be equal or less to the byte size of the XDR to complete",
                   fn ->
                     %UInt256{datum: <<32, 0, 117>>}
                     |> SignerKey.new(key_type)
                     |> SignerKey.encode_xdr()
                   end
    end
  end
end
