defmodule StellarBase.XDR.HashIDPreimageRevokeIDTest do
  use ExUnit.Case

  import StellarBase.Test.Utils

  alias StellarBase.XDR.{HashIDPreimageRevokeID, PoolID, SequenceNumber, UInt32}

  describe "OperationID" do
    setup do
      source_account =
        create_account_id("GCNY5OXYSY4FKHOPT2SPOQZAOEIGXB5LBYW3HVU3OWSTQITS65M5RCNY")

      seq_num = SequenceNumber.new(123_456)
      op_num = UInt32.new(123_456)
      pool_id = PoolID.new("GCIZ3GSM5XL7OUS4UP64THMDZ7CZ3ZWN")

      asset =
        create_asset(:alpha_num4,
          code: "BTCN",
          issuer: "GBZNLMUQMIN3VGUJISKZU7GNY3O3XLMYEHJCKCSMDHKLGSMKALRXOEZD"
        )

      %{
        source_account: source_account,
        seq_num: seq_num,
        op_num: op_num,
        pool_id: pool_id,
        asset: asset,
        revoke_id: HashIDPreimageRevokeID.new(source_account, seq_num, op_num, pool_id, asset),
        binary:
          <<0, 0, 0, 0, 155, 142, 186, 248, 150, 56, 85, 29, 207, 158, 164, 247, 67, 32, 113, 16,
            107, 135, 171, 14, 45, 179, 214, 155, 117, 165, 56, 34, 114, 247, 89, 216, 0, 0, 0, 0,
            0, 1, 226, 64, 0, 1, 226, 64, 71, 67, 73, 90, 51, 71, 83, 77, 53, 88, 76, 55, 79, 85,
            83, 52, 85, 80, 54, 52, 84, 72, 77, 68, 90, 55, 67, 90, 51, 90, 87, 78, 0, 0, 0, 1,
            66, 84, 67, 78, 0, 0, 0, 0, 114, 213, 178, 144, 98, 27, 186, 154, 137, 68, 149, 154,
            124, 205, 198, 221, 187, 173, 152, 33, 210, 37, 10, 76, 25, 212, 179, 73, 138, 2, 227,
            119>>
      }
    end

    test "new/3", %{
      source_account: source_account,
      seq_num: seq_num,
      op_num: op_num,
      pool_id: pool_id,
      asset: asset
    } do
      %HashIDPreimageRevokeID{
        source_account: ^source_account,
        seq_num: ^seq_num,
        liquidity_pool_id: ^pool_id,
        asset: ^asset
      } = HashIDPreimageRevokeID.new(source_account, seq_num, op_num, pool_id, asset)
    end

    test "encode_xdr/1", %{revoke_id: revoke_id, binary: binary} do
      {:ok, ^binary} = HashIDPreimageRevokeID.encode_xdr(revoke_id)
    end

    test "encode_xdr!/1", %{revoke_id: revoke_id, binary: binary} do
      ^binary = HashIDPreimageRevokeID.encode_xdr!(revoke_id)
    end

    test "decode_xdr/2", %{revoke_id: revoke_id, binary: binary} do
      {:ok, {^revoke_id, ""}} = HashIDPreimageRevokeID.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = HashIDPreimageRevokeID.decode_xdr(123)
    end

    test "decode_xdr!/2", %{revoke_id: revoke_id, binary: binary} do
      {^revoke_id, ""} = HashIDPreimageRevokeID.decode_xdr!(binary)
    end
  end
end
