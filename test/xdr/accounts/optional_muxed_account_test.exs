defmodule StellarBase.XDR.OptionalMuxedAccountTest do
  use ExUnit.Case

  alias StellarBase.XDR.{CryptoKeyType, MuxedAccount, OptionalMuxedAccount, UInt256}

  describe "OptionalMuxedAccount" do
    setup do
      type = CryptoKeyType.new(:KEY_TYPE_ED25519)

      ed25519_key =
        UInt256.new(
          <<18, 27, 249, 51, 160, 215, 152, 50, 153, 222, 53, 177, 115, 224, 92, 243, 51, 242,
            249, 40, 118, 78, 128, 109, 86, 239, 171, 232, 42, 171, 210, 35>>
        )

      muxed_account = MuxedAccount.new(ed25519_key, type)

      %{
        ed25519_key: ed25519_key,
        optional_muxed_account: OptionalMuxedAccount.new(muxed_account),
        empty_muxed_account: OptionalMuxedAccount.new(nil),
        binary:
          <<0, 0, 0, 1, 0, 0, 0, 0, 18, 27, 249, 51, 160, 215, 152, 50, 153, 222, 53, 177, 115,
            224, 92, 243, 51, 242, 249, 40, 118, 78, 128, 109, 86, 239, 171, 232, 42, 171, 210,
            35>>
      }
    end

    test "new/1", %{optional_muxed_account: optional_muxed_account} do
      %OptionalMuxedAccount{source_account: ^optional_muxed_account} =
        OptionalMuxedAccount.new(optional_muxed_account)
    end

    test "new/1 no source_account opted" do
      %OptionalMuxedAccount{source_account: nil} = OptionalMuxedAccount.new(nil)
    end

    test "encode_xdr/1", %{optional_muxed_account: optional_muxed_account, binary: binary} do
      {:ok, ^binary} = OptionalMuxedAccount.encode_xdr(optional_muxed_account)
    end

    test "encode_xdr/1 no source_account opted", %{empty_muxed_account: empty_muxed_account} do
      {:ok, <<0, 0, 0, 0>>} = OptionalMuxedAccount.encode_xdr(empty_muxed_account)
    end

    test "encode_xdr!/1", %{optional_muxed_account: optional_muxed_account, binary: binary} do
      ^binary = OptionalMuxedAccount.encode_xdr!(optional_muxed_account)
    end

    test "decode_xdr/2", %{optional_muxed_account: optional_muxed_account, binary: binary} do
      {:ok, {^optional_muxed_account, ""}} = OptionalMuxedAccount.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = OptionalMuxedAccount.decode_xdr(1234)
    end

    test "decode_xdr/2 when source_account is not opted" do
      {:ok, {%OptionalMuxedAccount{source_account: nil}, ""}} =
        OptionalMuxedAccount.decode_xdr(<<0, 0, 0, 0>>)
    end

    test "decode_xdr!/2", %{optional_muxed_account: optional_muxed_account, binary: binary} do
      {^optional_muxed_account, ^binary} = OptionalMuxedAccount.decode_xdr!(binary <> binary)
    end

    test "decode_xdr!/2 when source_account is not opted" do
      {%OptionalMuxedAccount{source_account: nil}, ""} =
        OptionalMuxedAccount.decode_xdr!(<<0, 0, 0, 0>>)
    end
  end
end
