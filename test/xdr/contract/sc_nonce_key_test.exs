defmodule StellarBase.XDR.SCNonceKeyTest do
  use ExUnit.Case

  alias StellarBase.XDR.{
    Int64,
    SCNonceKey
  }

  describe "SCNonceKey" do
    setup do
      nonce = Int64.new(231_385)

      %{
        nonce: nonce,
        sc_nonce_key: SCNonceKey.new(nonce),
        binary: <<0, 0, 0, 0, 0, 3, 135, 217>>
      }
    end

    test "new/1", %{nonce: nonce} do
      %SCNonceKey{nonce: ^nonce} = SCNonceKey.new(nonce)
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
