defmodule Stellar.XDR.MuxedAccountMed25519Test do
  use ExUnit.Case

  alias Stellar.XDR.{UInt64, UInt256, MuxedAccountMed25519}

  describe "Stellar.XDR.MuxedAccountMed25519" do
    setup do
      account_id =
        UInt256.new(
          <<18, 27, 249, 51, 160, 215, 152, 50, 153, 222, 53, 177, 115, 224, 92, 243, 51, 242,
            249, 40, 118, 78, 128, 109, 86, 239, 171, 232, 42, 171, 210, 35>>
        )

      account_derived_id = UInt64.new(123)

      %{
        account_derived_id: account_derived_id,
        account_id: account_id,
        muxed_account: MuxedAccountMed25519.new(account_derived_id, account_id),
        encoded_binary:
          <<0, 0, 0, 0, 0, 0, 0, 123, 18, 27, 249, 51, 160, 215, 152, 50, 153, 222, 53, 177, 115,
            224, 92, 243, 51, 242, 249, 40, 118, 78, 128, 109, 86, 239, 171, 232, 42, 171, 210,
            35>>
      }
    end

    test "new/1", %{account_id: account_id, account_derived_id: account_derived_id} do
      %MuxedAccountMed25519{ed25519: ^account_id} =
        MuxedAccountMed25519.new(account_derived_id, account_id)
    end

    test "encode_xdr/1", %{muxed_account: muxed_account, encoded_binary: binary} do
      {:ok, ^binary} = MuxedAccountMed25519.encode_xdr(muxed_account)
    end

    test "encode_xdr!/1", %{muxed_account: muxed_account, encoded_binary: binary} do
      ^binary = MuxedAccountMed25519.encode_xdr!(muxed_account)
    end

    test "decode_xdr/2", %{muxed_account: muxed_account, encoded_binary: binary} do
      {:ok, {^muxed_account, ""}} = MuxedAccountMed25519.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = MuxedAccountMed25519.decode_xdr(123)
    end

    test "decode_xdr!/2", %{muxed_account: muxed_account, encoded_binary: binary} do
      {^muxed_account, ^binary} = MuxedAccountMed25519.decode_xdr!(binary <> binary)
    end

    test "invalid ed25519 value" do
      assert_raise FunctionClauseError,
                   "no function clause matching in Stellar.XDR.MuxedAccountMed25519.new/2",
                   fn ->
                     account_derived_id = UInt64.new(123)
                     account_id = UInt64.new(321)

                     MuxedAccountMed25519.new(account_derived_id, account_id)
                   end
    end
  end
end
