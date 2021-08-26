defmodule Stellar.XDR.PublicKeyTypeTest do
  use ExUnit.Case

  alias Stellar.XDR.PublicKeyType

  describe "PublicKeyType" do
    setup do
      %{
        encoded_binary: <<0, 0, 0, 0>>,
        identifier: :PUBLIC_KEY_TYPE_ED25519,
        xdr_type: PublicKeyType.new(:PUBLIC_KEY_TYPE_ED25519)
      }
    end

    test "new/1", %{identifier: type} do
      %PublicKeyType{identifier: ^type} = PublicKeyType.new(:PUBLIC_KEY_TYPE_ED25519)
    end

    test "encode_xdr/1", %{xdr_type: xdr_type, encoded_binary: binary} do
      {:ok, ^binary} = PublicKeyType.encode_xdr(xdr_type)
    end

    test "encode_xdr!/1", %{xdr_type: xdr_type, encoded_binary: binary} do
      ^binary = PublicKeyType.encode_xdr!(xdr_type)
    end

    test "decode_xdr/2", %{xdr_type: xdr_type, encoded_binary: binary} do
      {:ok, {^xdr_type, ""}} = PublicKeyType.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = PublicKeyType.decode_xdr(123)
    end

    test "decode_xdr!/2", %{xdr_type: xdr_type, encoded_binary: binary} do
      {^xdr_type, ^binary} = PublicKeyType.decode_xdr!(binary <> binary)
    end

    test "invalid identifier" do
      {:error, :invalid_key} =
        PublicKeyType.encode_xdr(%PublicKeyType{identifier: SECRET_KEY_TYPE_ED25519})
    end
  end
end
