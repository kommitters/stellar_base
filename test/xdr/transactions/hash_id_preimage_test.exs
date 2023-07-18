defmodule StellarBase.XDR.HashIDPreimageTest do
  use ExUnit.Case

  import StellarBase.Test.Utils

  alias StellarBase.XDR.{
    EnvelopeType,
    HashIDPreimage,
    HashIDPreimageOperationID,
    PoolID,
    HashIDPreimageRevokeID,
    SequenceNumber,
    UInt32
  }

  setup do
    account_id = create_account_id("GCNY5OXYSY4FKHOPT2SPOQZAOEIGXB5LBYW3HVU3OWSTQITS65M5RCNY")
    seq_number = SequenceNumber.new(123_456)
    op_num = UInt32.new(123_456)

    {:ok,
     %{
       account_id: account_id,
       seq_number: seq_number,
       op_num: op_num
     }}
  end

  describe "OperationID" do
    setup %{account_id: account_id, seq_number: seq_number, op_num: op_num} do
      envelope_type = EnvelopeType.new(:ENVELOPE_TYPE_OP_ID)
      operation_id = HashIDPreimageOperationID.new(account_id, seq_number, op_num)

      %{
        envelope_type: envelope_type,
        operation_id: operation_id,
        hash_id_preimage: HashIDPreimage.new(operation_id, envelope_type),
        binary:
          <<0, 0, 0, 6, 0, 0, 0, 0, 155, 142, 186, 248, 150, 56, 85, 29, 207, 158, 164, 247, 67,
            32, 113, 16, 107, 135, 171, 14, 45, 179, 214, 155, 117, 165, 56, 34, 114, 247, 89,
            216, 0, 0, 0, 0, 0, 1, 226, 64, 0, 1, 226, 64>>
      }
    end

    test "new/1", %{operation_id: operation_id, envelope_type: envelope_type} do
      %HashIDPreimage{value: ^operation_id, type: ^envelope_type} =
        HashIDPreimage.new(operation_id, envelope_type)
    end

    test "encode_xdr/1", %{hash_id_preimage: hash_id_preimage, binary: binary} do
      {:ok, ^binary} = HashIDPreimage.encode_xdr(hash_id_preimage)
    end

    test "encode_xdr!/1", %{hash_id_preimage: hash_id_preimage, binary: binary} do
      ^binary = HashIDPreimage.encode_xdr!(hash_id_preimage)
    end

    test "decode_xdr/2", %{hash_id_preimage: hash_id_preimage, binary: binary} do
      {:ok, {^hash_id_preimage, ""}} = HashIDPreimage.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = HashIDPreimage.decode_xdr(123)
    end

    test "decode_xdr!/2", %{hash_id_preimage: hash_id_preimage, binary: binary} do
      {^hash_id_preimage, ^binary} = HashIDPreimage.decode_xdr!(binary <> binary)
    end
  end

  describe "RevokeID" do
    setup %{account_id: account_id, seq_number: seq_number, op_num: op_num} do
      envelope_type = EnvelopeType.new(:ENVELOPE_TYPE_POOL_REVOKE_OP_ID)
      liquidity_pool_id = PoolID.new("GCIZ3GSM5XL7OUS4UP64THMDZ7CZ3ZWN")

      asset =
        create_asset(:alpha_num4,
          code: "BTCN",
          issuer: "GBZNLMUQMIN3VGUJISKZU7GNY3O3XLMYEHJCKCSMDHKLGSMKALRXOEZD"
        )

      revoke_id =
        HashIDPreimageRevokeID.new(account_id, seq_number, op_num, liquidity_pool_id, asset)

      %{
        envelope_type: envelope_type,
        revoke_id: revoke_id,
        hash_id_preimage: HashIDPreimage.new(revoke_id, envelope_type),
        binary:
          <<0, 0, 0, 7, 0, 0, 0, 0, 155, 142, 186, 248, 150, 56, 85, 29, 207, 158, 164, 247, 67,
            32, 113, 16, 107, 135, 171, 14, 45, 179, 214, 155, 117, 165, 56, 34, 114, 247, 89,
            216, 0, 0, 0, 0, 0, 1, 226, 64, 0, 1, 226, 64, 71, 67, 73, 90, 51, 71, 83, 77, 53, 88,
            76, 55, 79, 85, 83, 52, 85, 80, 54, 52, 84, 72, 77, 68, 90, 55, 67, 90, 51, 90, 87,
            78, 0, 0, 0, 1, 66, 84, 67, 78, 0, 0, 0, 0, 114, 213, 178, 144, 98, 27, 186, 154, 137,
            68, 149, 154, 124, 205, 198, 221, 187, 173, 152, 33, 210, 37, 10, 76, 25, 212, 179,
            73, 138, 2, 227, 119>>
      }
    end

    test "new/1", %{revoke_id: revoke_id, envelope_type: envelope_type} do
      %HashIDPreimage{value: ^revoke_id, type: ^envelope_type} =
        HashIDPreimage.new(revoke_id, envelope_type)
    end

    test "encode_xdr/1", %{hash_id_preimage: hash_id_preimage, binary: binary} do
      {:ok, ^binary} = HashIDPreimage.encode_xdr(hash_id_preimage)
    end

    test "encode_xdr!/1", %{hash_id_preimage: hash_id_preimage, binary: binary} do
      ^binary = HashIDPreimage.encode_xdr!(hash_id_preimage)
    end

    test "decode_xdr/2", %{hash_id_preimage: hash_id_preimage, binary: binary} do
      {:ok, {^hash_id_preimage, ""}} = HashIDPreimage.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = HashIDPreimage.decode_xdr(123)
    end

    test "decode_xdr!/2", %{hash_id_preimage: hash_id_preimage, binary: binary} do
      {^hash_id_preimage, ^binary} = HashIDPreimage.decode_xdr!(binary <> binary)
    end
  end
end
