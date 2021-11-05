defmodule StellarBase.XDR.PublicKeyTest do
  use ExUnit.Case

  alias StellarBase.XDR.{UInt256, PublicKey, PublicKeyType}

  describe "PublicKey" do
    setup do
      key_type = PublicKeyType.new(:PUBLIC_KEY_TYPE_ED25519)

      public_key = %UInt256{
        datum:
          <<32, 0, 117, 126, 234, 229, 131, 252, 80, 221, 102, 159, 151, 103, 58, 204, 37, 236,
            114, 88, 35, 172, 115, 250, 246, 199, 223, 49, 173, 49, 229, 9>>
      }

      encoded_binary =
        <<0, 0, 0, 0, 32, 0, 117, 126, 234, 229, 131, 252, 80, 221, 102, 159, 151, 103, 58, 204,
          37, 236, 114, 88, 35, 172, 115, 250, 246, 199, 223, 49, 173, 49, 229, 9>>

      %{
        encoded_binary: encoded_binary,
        key_type: key_type,
        key_type_id: :PUBLIC_KEY_TYPE_ED25519,
        public_key: public_key,
        xdr_type: PublicKey.new(public_key, key_type)
      }
    end

    test "new/1", %{key_type_id: type_id, public_key: public_key, key_type: key_type} do
      %PublicKey{type: %PublicKeyType{identifier: ^type_id}} = PublicKey.new(public_key, key_type)
    end

    test "encode_xdr/1", %{xdr_type: xdr_type, encoded_binary: binary} do
      {:ok, ^binary} = PublicKey.encode_xdr(xdr_type)
    end

    test "encode_xdr!/1", %{xdr_type: xdr_type, encoded_binary: binary} do
      ^binary = PublicKey.encode_xdr!(xdr_type)
    end

    test "decode_xdr/2", %{xdr_type: xdr_type, encoded_binary: binary} do
      {:ok, {^xdr_type, ""}} = PublicKey.decode_xdr(binary)
    end

    test "decode_xdr!/2", %{xdr_type: xdr_type, encoded_binary: binary} do
      {^xdr_type, ^binary} = PublicKey.decode_xdr!(binary <> binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = PublicKey.decode_xdr(123)
    end

    test "invalid public key", %{key_type: key_type} do
      assert_raise XDR.FixedOpaqueError,
                   "The length that is passed through parameters must be equal or less to the byte size of the XDR to complete",
                   fn ->
                     %UInt256{datum: <<32, 0, 117>>}
                     |> PublicKey.new(key_type)
                     |> PublicKey.encode_xdr()
                   end
    end
  end
end
