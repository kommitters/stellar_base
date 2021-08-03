defmodule Stellar.XDR.CryptoKeyTypeTest do
  use ExUnit.Case

  alias Stellar.XDR.CryptoKeyType

  describe "CryptoKeyType" do
    setup do
      %{
        encoded_binary: <<0, 0, 1, 0>>,
        identifier: :KEY_TYPE_MUXED_ED25519,
        xdr_type: CryptoKeyType.new(:KEY_TYPE_MUXED_ED25519)
      }
    end

    test "new/1", %{identifier: type} do
      %CryptoKeyType{identifier: ^type} = CryptoKeyType.new(:KEY_TYPE_MUXED_ED25519)
    end

    test "encode_xdr/1", %{xdr_type: xdr_type, encoded_binary: binary} do
      {:ok, ^binary} = CryptoKeyType.encode_xdr(xdr_type)
    end

    test "encode_xdr!/1", %{xdr_type: xdr_type, encoded_binary: binary} do
      ^binary = CryptoKeyType.encode_xdr!(xdr_type)
    end

    test "decode_xdr/2", %{xdr_type: xdr_type, encoded_binary: binary} do
      {:ok, {^xdr_type, ""}} = CryptoKeyType.decode_xdr(binary)
    end

    test "decode_xdr!/2", %{xdr_type: xdr_type, encoded_binary: binary} do
      {^xdr_type, ^binary} = CryptoKeyType.decode_xdr!(binary <> binary)
    end

    test "invalid identifier" do
      {:error, :invalid_key} =
        CryptoKeyType.encode_xdr(%CryptoKeyType{identifier: SECRET_KEY_TYPE_ED25519})
    end
  end
end
