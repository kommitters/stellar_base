defmodule StellarBase.XDR.SignerKeyTypeTest do
  use ExUnit.Case

  alias StellarBase.XDR.SignerKeyType

  describe "SignerKeyType" do
    setup do
      %{
        encoded_binary: <<0, 0, 0, 1>>,
        identifier: :SIGNER_KEY_TYPE_PRE_AUTH_TX,
        xdr_type: SignerKeyType.new(:SIGNER_KEY_TYPE_PRE_AUTH_TX)
      }
    end

    test "new/1", %{identifier: type} do
      %SignerKeyType{identifier: ^type} = SignerKeyType.new(:SIGNER_KEY_TYPE_PRE_AUTH_TX)
    end

    test "encode_xdr/1", %{xdr_type: xdr_type, encoded_binary: binary} do
      {:ok, ^binary} = SignerKeyType.encode_xdr(xdr_type)
    end

    test "encode_xdr!/1", %{xdr_type: xdr_type, encoded_binary: binary} do
      ^binary = SignerKeyType.encode_xdr!(xdr_type)
    end

    test "decode_xdr/2", %{xdr_type: xdr_type, encoded_binary: binary} do
      {:ok, {^xdr_type, ""}} = SignerKeyType.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = SignerKeyType.decode_xdr(123)
    end

    test "decode_xdr!/2", %{xdr_type: xdr_type, encoded_binary: binary} do
      {^xdr_type, ^binary} = SignerKeyType.decode_xdr!(binary <> binary)
    end

    test "invalid identifier" do
      {:error, :invalid_key} =
        SignerKeyType.encode_xdr(%SignerKeyType{identifier: SECRET_KEY_TYPE_ED25519})
    end
  end
end
