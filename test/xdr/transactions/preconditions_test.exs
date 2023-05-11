defmodule StellarBase.XDR.PreconditionsTest do
  use ExUnit.Case

  import StellarBase.Test.Utils

  alias StellarBase.XDR.{
    Duration,
    LedgerBounds,
    OptionalLedgerBounds,
    OptionalSequenceNumber,
    OptionalTimeBounds,
    PreconditionType,
    PreconditionsV2,
    Preconditions,
    SequenceNumber,
    SignerKey,
    SignerKeyList2,
    SignerKeyType,
    TimeBounds,
    TimePoint,
    Uint32
  }

  describe "Precondition Time Bound" do
    setup do
      precondition_type = PreconditionType.new(:PRECOND_TIME)

      min_time = TimePoint.new(123)
      max_time = TimePoint.new(321)

      time_bounds = TimeBounds.new(min_time, max_time)

      %{
        time_bounds: time_bounds,
        precondition_type: precondition_type,
        preconditions: Preconditions.new(time_bounds, precondition_type),
        binary: <<0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 123, 0, 0, 0, 0, 0, 0, 1, 65>>
      }
    end

    test "new/1", %{time_bounds: time_bounds, precondition_type: precondition_type} do
      %Preconditions{value: ^time_bounds, type: ^precondition_type} =
        Preconditions.new(time_bounds, precondition_type)
    end

    test "encode_xdr/1", %{preconditions: preconditions, binary: binary} do
      {:ok, ^binary} = Preconditions.encode_xdr(preconditions)
    end

    test "encode_xdr/1 with an invalid type", %{preconditions: preconditions} do
      precondition_type = PreconditionType.new(:NEW_PRECONDITION)

      assert_raise XDR.EnumError,
                   "The key which you try to encode doesn't belong to the current declarations",
                   fn ->
                     preconditions
                     |> Preconditions.new(precondition_type)
                     |> Preconditions.encode_xdr()
                   end
    end

    test "encode_xdr!/1", %{preconditions: preconditions, binary: binary} do
      ^binary = Preconditions.encode_xdr!(preconditions)
    end

    test "decode_xdr/2", %{preconditions: preconditions, binary: binary} do
      {:ok, {^preconditions, ""}} = Preconditions.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = Preconditions.decode_xdr(123)
    end

    test "decode_xdr!/2", %{preconditions: preconditions, binary: binary} do
      {^preconditions, ^binary} = Preconditions.decode_xdr!(binary <> binary)
    end
  end

  describe "Precondition PreconditionsV2" do
    setup do
      precondition_type = PreconditionType.new(:PRECOND_V2)
      key_type = SignerKeyType.new(:SIGNER_KEY_TYPE_PRE_AUTH_TX)

      min_time = TimePoint.new(123)
      max_time = TimePoint.new(321)
      min_ledger = Uint32.new(123)
      max_ledger = Uint32.new(321)

      signer_key_1 =
        "GCNY5OXYSY4FKHOPT2SPOQZAOEIGXB5LBYW3HVU3OWSTQITS65M5RCNY"
        |> ed25519_public_key()
        |> SignerKey.new(key_type)

      signer_key_2 =
        "GBZNLMUQMIN3VGUJISKZU7GNY3O3XLMYEHJCKCSMDHKLGSMKALRXOEZD"
        |> ed25519_public_key()
        |> SignerKey.new(key_type)

      signer_keys = [signer_key_1, signer_key_2]

      time_bounds =
        TimeBounds.new(min_time, max_time)
        |> OptionalTimeBounds.new()

      ledger_bounds =
        min_ledger
        |> LedgerBounds.new(max_ledger)
        |> OptionalLedgerBounds.new()

      min_seq_num =
        1234
        |> SequenceNumber.new()
        |> OptionalSequenceNumber.new()

      min_seq_age = Duration.new(1234)
      min_seq_ledger_gap = Uint32.new(4_294_967_295)
      extra_signers = SignerKeyList2.new(signer_keys)

      preconditions_v2 =
        PreconditionsV2.new(
          time_bounds,
          ledger_bounds,
          min_seq_num,
          min_seq_age,
          min_seq_ledger_gap,
          extra_signers
        )

      %{
        time_bounds: time_bounds,
        ledger_bounds: ledger_bounds,
        min_seq_num: min_seq_num,
        min_seq_age: min_seq_age,
        min_seq_ledger_gap: min_seq_ledger_gap,
        extra_signers: extra_signers,
        precondition_type: precondition_type,
        preconditions: Preconditions.new(preconditions_v2, precondition_type),
        binary:
          <<0, 0, 0, 2, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 123, 0, 0, 0, 0, 0, 0, 1, 65, 0, 0, 0, 1,
            0, 0, 0, 123, 0, 0, 1, 65, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 4, 210, 0, 0, 0, 0, 0, 0, 4,
            210, 255, 255, 255, 255, 0, 0, 0, 2, 0, 0, 0, 1, 155, 142, 186, 248, 150, 56, 85, 29,
            207, 158, 164, 247, 67, 32, 113, 16, 107, 135, 171, 14, 45, 179, 214, 155, 117, 165,
            56, 34, 114, 247, 89, 216, 0, 0, 0, 1, 114, 213, 178, 144, 98, 27, 186, 154, 137, 68,
            149, 154, 124, 205, 198, 221, 187, 173, 152, 33, 210, 37, 10, 76, 25, 212, 179, 73,
            138, 2, 227, 119>>
      }
    end

    test "new/1", %{preconditions: preconditions, precondition_type: precondition_type} do
      %Preconditions{value: ^preconditions, type: ^precondition_type} =
        Preconditions.new(preconditions, precondition_type)
    end

    test "encode_xdr/1", %{preconditions: preconditions, binary: binary} do
      {:ok, ^binary} = Preconditions.encode_xdr(preconditions)
    end

    test "encode_xdr/1 with an invalid type", %{preconditions: preconditions} do
      precondition_type = PreconditionType.new(:NEW_PRECONDITION)

      assert_raise XDR.EnumError,
                   "The key which you try to encode doesn't belong to the current declarations",
                   fn ->
                     preconditions
                     |> Preconditions.new(precondition_type)
                     |> Preconditions.encode_xdr()
                   end
    end

    test "encode_xdr!/1", %{preconditions: preconditions, binary: binary} do
      ^binary = Preconditions.encode_xdr!(preconditions)
    end

    test "decode_xdr/2", %{preconditions: preconditions, binary: binary} do
      {:ok, {^preconditions, ""}} = Preconditions.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = Preconditions.decode_xdr(123)
    end

    test "decode_xdr!/2", %{preconditions: preconditions, binary: binary} do
      {^preconditions, ^binary} = Preconditions.decode_xdr!(binary <> binary)
    end
  end
end
