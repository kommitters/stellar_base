defmodule StellarBase.XDR.PreconditionsV2Test do
  use ExUnit.Case

  import StellarBase.Test.Utils

  alias StellarBase.XDR.{
    Duration,
    PreconditionsV2,
    OptionalTimeBounds,
    OptionalLedgerBounds,
    OptionalSequenceNumber,
    UInt32,
    SignerKey,
    SignerKeyList,
    SignerKeyType,
    TimePoint,
    TimeBounds,
    SequenceNumber,
    LedgerBounds
  }

  describe "PreconditionsV2" do
    setup do
      key_type = SignerKeyType.new(:SIGNER_KEY_TYPE_PRE_AUTH_TX)

      min_time = TimePoint.new(123)
      max_time = TimePoint.new(321)
      min_ledger = UInt32.new(123)
      max_ledger = UInt32.new(321)

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
        min_time
        |> TimeBounds.new(max_time)
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
      min_seq_ledger_gap = UInt32.new(4_294_967_295)
      extra_signers = SignerKeyList.new(signer_keys)

      %{
        time_bounds: time_bounds,
        ledger_bounds: ledger_bounds,
        min_seq_num: min_seq_num,
        min_seq_age: min_seq_age,
        min_seq_ledger_gap: min_seq_ledger_gap,
        extra_signers: extra_signers,
        preconditions_v2:
          PreconditionsV2.new(
            time_bounds,
            ledger_bounds,
            min_seq_num,
            min_seq_age,
            min_seq_ledger_gap,
            extra_signers
          ),
        binary:
          <<0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 123, 0, 0, 0, 0, 0, 0, 1, 65, 0, 0, 0, 1, 0, 0, 0,
            123, 0, 0, 1, 65, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 4, 210, 0, 0, 0, 0, 0, 0, 4, 210, 255,
            255, 255, 255, 0, 0, 0, 2, 0, 0, 0, 1, 155, 142, 186, 248, 150, 56, 85, 29, 207, 158,
            164, 247, 67, 32, 113, 16, 107, 135, 171, 14, 45, 179, 214, 155, 117, 165, 56, 34,
            114, 247, 89, 216, 0, 0, 0, 1, 114, 213, 178, 144, 98, 27, 186, 154, 137, 68, 149,
            154, 124, 205, 198, 221, 187, 173, 152, 33, 210, 37, 10, 76, 25, 212, 179, 73, 138, 2,
            227, 119>>
      }
    end

    test "new/1", %{
      time_bounds: time_bounds,
      ledger_bounds: ledger_bounds,
      min_seq_num: min_seq_num,
      min_seq_age: min_seq_age,
      min_seq_ledger_gap: min_seq_ledger_gap,
      extra_signers: extra_signers
    } do
      %PreconditionsV2{
        time_bounds: ^time_bounds,
        ledger_bounds: ^ledger_bounds,
        min_seq_num: ^min_seq_num,
        min_seq_age: ^min_seq_age,
        min_seq_ledger_gap: ^min_seq_ledger_gap,
        extra_signers: ^extra_signers
      } =
        PreconditionsV2.new(
          time_bounds,
          ledger_bounds,
          min_seq_num,
          min_seq_age,
          min_seq_ledger_gap,
          extra_signers
        )
    end

    test "encode_xdr/1", %{preconditions_v2: preconditions_v2, binary: binary} do
      {:ok, ^binary} = PreconditionsV2.encode_xdr(preconditions_v2)
    end

    test "encode_xdr!/1", %{preconditions_v2: preconditions_v2, binary: binary} do
      ^binary = PreconditionsV2.encode_xdr!(preconditions_v2)
    end

    test "decode_xdr/2", %{preconditions_v2: preconditions_v2, binary: binary} do
      {:ok, {^preconditions_v2, ""}} = PreconditionsV2.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = PreconditionsV2.decode_xdr(1234)
    end

    test "decode_xdr!/2", %{preconditions_v2: preconditions_v2, binary: binary} do
      {^preconditions_v2, ^binary} = PreconditionsV2.decode_xdr!(binary <> binary)
    end
  end
end
