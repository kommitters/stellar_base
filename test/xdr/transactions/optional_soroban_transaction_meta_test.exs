defmodule StellarBase.XDR.OptionalSorobanTransactionMetaTest do
  use ExUnit.Case

  alias StellarBase.XDR.{
    Bool,
    ContractEvent,
    ContractEventBody,
    ContractEventList,
    ContractEventType,
    ContractEventV0,
    DiagnosticEvent,
    DiagnosticEventList,
    ExtensionPoint,
    Int64,
    OptionalHash,
    OptionalSorobanTransactionMeta,
    SCVal,
    SCValType,
    SCValList,
    SorobanTransactionMeta,
    SorobanTransactionMetaExt,
    Void
  }

  describe "OptionalSorobanTransactionMeta" do
    setup do
      contract_id = OptionalHash.new()

      extension_point_type = 0
      void = Void.new()
      ext = ExtensionPoint.new(void, extension_point_type)
      soroban_tx_ext = SorobanTransactionMetaExt.new(void, extension_point_type)

      type = ContractEventType.new()

      scval1 = SCVal.new(Int64.new(3), SCValType.new(:SCV_I64))
      scval2 = SCVal.new(Int64.new(2), SCValType.new(:SCV_I64))
      sc_vals = [scval1, scval2]
      topics = SCValList.new(sc_vals)
      data = SCVal.new(Int64.new(3), SCValType.new(:SCV_I64))
      contract_event_v0 = ContractEventV0.new(topics, data)
      body = ContractEventBody.new(contract_event_v0, 0)
      event = ContractEvent.new(ext, contract_id, type, body)
      events = ContractEventList.new([event])

      in_successful_contract_call = Bool.new(true)
      diagnostic_event = DiagnosticEvent.new(in_successful_contract_call, event)
      diagnostic_events = DiagnosticEventList.new([diagnostic_event])

      return_value = SCVal.new(Int64.new(100), SCValType.new(:SCV_I64))

      soroban_transaction_meta =
        SorobanTransactionMeta.new(soroban_tx_ext, events, return_value, diagnostic_events)

      %{
        soroban_transaction_meta: soroban_transaction_meta,
        optional_soroban_transaction_meta:
          OptionalSorobanTransactionMeta.new(soroban_transaction_meta),
        default_optional_soroban_transaction_meta: OptionalSorobanTransactionMeta.new(),
        binary:
          <<0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 2, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0,
            0, 6, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0, 0, 1, 0, 0,
            0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 6, 0, 0, 0,
            0, 0, 0, 0, 3, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0,
            3>>,
        binary_default_meta: <<0, 0, 0, 0>>
      }
    end

    test "new/1 with soroban tx meta", %{soroban_transaction_meta: soroban_transaction_meta} do
      %OptionalSorobanTransactionMeta{
        soroban_transaction_meta: ^soroban_transaction_meta
      } = OptionalSorobanTransactionMeta.new(soroban_transaction_meta)
    end

    test "new/1 without soroban tx meta" do
      %OptionalSorobanTransactionMeta{
        soroban_transaction_meta: nil
      } = OptionalSorobanTransactionMeta.new()
    end

    test "encode_xdr/1", %{
      optional_soroban_transaction_meta: optional_soroban_transaction_meta,
      binary: binary
    } do
      {:ok, ^binary} =
        OptionalSorobanTransactionMeta.encode_xdr(optional_soroban_transaction_meta)
    end

    test "encode_xdr!/1", %{
      optional_soroban_transaction_meta: optional_soroban_transaction_meta,
      binary: binary
    } do
      ^binary = OptionalSorobanTransactionMeta.encode_xdr!(optional_soroban_transaction_meta)
    end

    test "encode_xdr!/1 with default meta", %{
      default_optional_soroban_transaction_meta: default_optional_soroban_transaction_meta,
      binary_default_meta: binary_default_meta
    } do
      ^binary_default_meta =
        OptionalSorobanTransactionMeta.encode_xdr!(default_optional_soroban_transaction_meta)
    end

    test "decode_xdr/2", %{
      optional_soroban_transaction_meta: optional_soroban_transaction_meta,
      binary: binary
    } do
      {:ok, {^optional_soroban_transaction_meta, ""}} =
        OptionalSorobanTransactionMeta.decode_xdr(binary)
    end

    test "decode_xdr!/2", %{
      optional_soroban_transaction_meta: optional_soroban_transaction_meta,
      binary: binary
    } do
      {^optional_soroban_transaction_meta, ^binary} =
        OptionalSorobanTransactionMeta.decode_xdr!(binary <> binary)
    end

    test "decode_xdr/2 default meta", %{
      default_optional_soroban_transaction_meta: default_optional_soroban_transaction_meta,
      binary_default_meta: binary_default_meta
    } do
      {:ok, {^default_optional_soroban_transaction_meta, ""}} =
        OptionalSorobanTransactionMeta.decode_xdr(binary_default_meta)
    end

    test "decode_xdr!/2 default meta", %{
      default_optional_soroban_transaction_meta: default_optional_soroban_transaction_meta,
      binary_default_meta: binary_default_meta
    } do
      {^default_optional_soroban_transaction_meta, ^binary_default_meta} =
        OptionalSorobanTransactionMeta.decode_xdr!(binary_default_meta <> binary_default_meta)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = OptionalSorobanTransactionMeta.decode_xdr(123)
    end
  end
end
