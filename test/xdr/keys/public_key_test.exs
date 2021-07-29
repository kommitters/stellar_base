defmodule Stellar.XDR.PublicKeyTest do
  use ExUnit.Case

  alias Stellar.XDR.PublicKey

  describe "PublicKey" do
    setup do
      public_key =
        <<72, 101, 108, 108, 111, 32, 119, 111, 114, 108, 100, 0, 21, 0, 1, 0, 72, 101, 108, 108,
          111, 32, 119, 111, 114, 108, 100, 0, 21, 0, 1, 0>>

      %{
        encoded_binary:
          <<0, 0, 0, 0, 72, 101, 108, 108, 111, 32, 119, 111, 114, 108, 100, 0, 21, 0, 1, 0, 72,
            101, 108, 108, 111, 32, 119, 111, 114, 108, 100, 0, 21, 0, 1, 0>>,
        type: :PUBLIC_KEY_TYPE_ED25519,
        public_key: public_key,
        xdr_type: PublicKey.new(public_key)
      }
    end

    test "new/1", %{type: type, public_key: public_key} do
      %PublicKey{type: ^type} = PublicKey.new(public_key)
    end

    test "encode_xdr/1", %{xdr_type: xdr_type, encoded_binary: binary} do
      {:ok, ^binary} = PublicKey.encode_xdr(xdr_type)
    end

    test "encode_xdr!/1", %{xdr_type: xdr_type, encoded_binary: binary} do
      ^binary = PublicKey.encode_xdr!(xdr_type)
    end

    test "decode_xdr/1", %{xdr_type: xdr_type, encoded_binary: binary} do
      {:ok, {^xdr_type, ""}} = PublicKey.decode_xdr(binary)
    end

    test "decode_xdr!/1", %{xdr_type: xdr_type, encoded_binary: binary} do
      {^xdr_type, ^binary} = PublicKey.decode_xdr!(binary <> binary)
    end

    test "invalid public key" do
      assert_raise XDR.Error.FixedOpaque,
                   "The length that is passed through parameters must be equal or less to the byte size of the XDR to complete",
                   fn ->
                     <<0, 0, 0, 0, 72>>
                     |> PublicKey.new()
                     |> PublicKey.encode_xdr()
                   end
    end
  end
end
