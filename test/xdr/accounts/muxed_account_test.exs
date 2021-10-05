defmodule Stellar.XDR.MuxedAccountTest do
  use ExUnit.Case

  alias Stellar.XDR.{UInt64, UInt256, MuxedAccount, MuxedAccountMed25519, CryptoKeyType}

  describe "MuxedAccount" do
    setup do
      type = CryptoKeyType.new(:KEY_TYPE_ED25519)

      ed25519_account =
        UInt256.new(
          <<18, 27, 249, 51, 160, 215, 152, 50, 153, 222, 53, 177, 115, 224, 92, 243, 51, 242,
            249, 40, 118, 78, 128, 109, 86, 239, 171, 232, 42, 171, 210, 35>>
        )

      %{
        type: type,
        ed25519_account: ed25519_account,
        muxed_account: MuxedAccount.new(type, ed25519_account),
        encoded_binary:
          <<0, 0, 0, 0, 18, 27, 249, 51, 160, 215, 152, 50, 153, 222, 53, 177, 115, 224, 92, 243,
            51, 242, 249, 40, 118, 78, 128, 109, 86, 239, 171, 232, 42, 171, 210, 35>>
      }
    end

    test "new/1", %{type: type, ed25519_account: ed25519_account} do
      %MuxedAccount{account: ^ed25519_account} = MuxedAccount.new(type, ed25519_account)
    end

    test "new/1 with an invalid account", %{ed25519_account: ed25519_account} do
      type = CryptoKeyType.new(:KEY_TYPE_HASH_X)
      {:error, :invalid_key_type} = MuxedAccount.new(type, ed25519_account)
    end

    test "encode_xdr/1", %{muxed_account: muxed_account, encoded_binary: binary} do
      {:ok, ^binary} = MuxedAccount.encode_xdr(muxed_account)
    end

    test "encode_xdr!/1", %{muxed_account: muxed_account, encoded_binary: binary} do
      ^binary = MuxedAccount.encode_xdr!(muxed_account)
    end

    test "decode_xdr/2", %{muxed_account: muxed_account, encoded_binary: binary} do
      {:ok, {^muxed_account, ""}} = MuxedAccount.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = MuxedAccount.decode_xdr(123)
    end

    test "decode_xdr!/2 with an invalid binary" do
      assert_raise XDR.UnionError,
                   "The :identifier received by parameter must be a binary value, for example: <<0, 0, 0, 5>>",
                   fn ->
                     MuxedAccount.decode_xdr!(123)
                   end
    end

    test "decode_xdr!/2", %{muxed_account: muxed_account, encoded_binary: binary} do
      {^muxed_account, ^binary} = MuxedAccount.decode_xdr!(binary <> binary)
    end
  end

  describe "med25519 MuxedAccount" do
    setup do
      type = CryptoKeyType.new(:KEY_TYPE_MUXED_ED25519)
      med25519_derived_id = UInt64.new(123)

      med25519_account_id =
        UInt256.new(
          <<18, 27, 249, 51, 160, 215, 152, 50, 153, 222, 53, 177, 115, 224, 92, 243, 51, 242,
            249, 40, 118, 78, 128, 109, 86, 239, 171, 232, 42, 171, 210, 35>>
        )

      med25519_account = MuxedAccountMed25519.new(med25519_derived_id, med25519_account_id)

      %{
        type: type,
        med25519_account: med25519_account,
        muxed_account: MuxedAccount.new(type, med25519_account),
        encoded_binary:
          <<0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 123, 18, 27, 249, 51, 160, 215, 152, 50, 153, 222,
            53, 177, 115, 224, 92, 243, 51, 242, 249, 40, 118, 78, 128, 109, 86, 239, 171, 232,
            42, 171, 210, 35>>
      }
    end

    test "new/1", %{type: type, med25519_account: med25519_account} do
      %MuxedAccount{account: ^med25519_account} = MuxedAccount.new(type, med25519_account)
    end

    test "encode_xdr/1", %{muxed_account: muxed_account, encoded_binary: binary} do
      {:ok, ^binary} = MuxedAccount.encode_xdr(muxed_account)
    end

    test "encode_xdr!/1", %{muxed_account: muxed_account, encoded_binary: binary} do
      ^binary = MuxedAccount.encode_xdr!(muxed_account)
    end

    test "decode_xdr/2", %{muxed_account: muxed_account, encoded_binary: binary} do
      {:ok, {^muxed_account, ""}} = MuxedAccount.decode_xdr(binary)
    end

    test "decode_xdr!/2", %{muxed_account: muxed_account, encoded_binary: binary} do
      {^muxed_account, ^binary} = MuxedAccount.decode_xdr!(binary <> binary)
    end
  end
end
