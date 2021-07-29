defmodule Stellar.XDR.SignerKeyTest do
  use ExUnit.Case

  alias Stellar.XDR.SignerKey

  describe "SignerKey" do
    setup do
      signer_key =
        <<72, 101, 108, 108, 111, 32, 119, 111, 114, 108, 100, 0, 21, 0, 1, 0, 72, 101, 108, 108,
          111, 32, 119, 111, 114, 108, 100, 0, 21, 0, 1, 0>>

      %{
        encoded_binary:
          <<0, 0, 0, 0, 72, 101, 108, 108, 111, 32, 119, 111, 114, 108, 100, 0, 21, 0, 1, 0, 72,
            101, 108, 108, 111, 32, 119, 111, 114, 108, 100, 0, 21, 0, 1, 0>>,
        type: :SIGNER_KEY_TYPE_PRE_AUTH_TX,
        signer_key: signer_key,
        xdr_type: SignerKey.new(signer_key)
      }
    end

    test "new/1", %{type: type, signer_key: signer_key} do
      %SignerKey{type: ^type} = SignerKey.new(signer_key, :SIGNER_KEY_TYPE_PRE_AUTH_TX)
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

    test "invalid signer key" do
      assert_raise XDR.Error.FixedOpaque,
                   "The length that is passed through parameters must be equal or less to the byte size of the XDR to complete",
                   fn ->
                     <<0, 0, 0, 0, 72>>
                     |> SignerKey.new()
                     |> SignerKey.encode_xdr()
                   end
    end
  end
end
