defmodule StellarBase.XDR.SorobanTransactionDataTest do
  use ExUnit.Case

  alias StellarBase.XDR.{
    ContractEntryBodyType,
    Hash,
    Int64,
    SorobanTransactionData,
    UInt32,
    SorobanResources,
    LedgerEntryType,
    LedgerKey,
    LedgerKeyContractCode,
    LedgerKeyList,
    LedgerFootprint,
    Void,
    ExtensionPoint
  }

  describe "SorobanResources" do
    setup do
      refundable_fee = Int64.new(10)
      ext = ExtensionPoint.new(Void.new(), 0)
      hash = Hash.new("GCIZ3GSM5XL7OUS4UP64THMDZ7CZ3ZWN")
      type = LedgerEntryType.new(:CONTRACT_CODE)
      ledger_key_data = LedgerKeyContractCode.new(hash, ContractEntryBodyType.new())
      ledger_key1 = LedgerKey.new(ledger_key_data, type)
      ledger_key2 = LedgerKey.new(ledger_key_data, type)
      ledger_key_list_read = LedgerKeyList.new([ledger_key1])
      ledger_key_list_write = LedgerKeyList.new([ledger_key2])
      footprint = LedgerFootprint.new(ledger_key_list_read, ledger_key_list_write)
      instructions = UInt32.new(10)
      read_bytes = UInt32.new(10)
      write_bytes = UInt32.new(10)
      extended_meta_data_size_bytes = UInt32.new(10)

      resources =
        SorobanResources.new(
          footprint,
          instructions,
          read_bytes,
          write_bytes,
          extended_meta_data_size_bytes
        )

      soroban_transaction_data = SorobanTransactionData.new(ext, resources, refundable_fee)

      %{
        resources: resources,
        refundable_fee: refundable_fee,
        ext: ext,
        soroban_transaction_data: soroban_transaction_data,
        binary:
          <<0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 7, 71, 67, 73, 90, 51, 71, 83, 77, 53, 88, 76, 55,
            79, 85, 83, 52, 85, 80, 54, 52, 84, 72, 77, 68, 90, 55, 67, 90, 51, 90, 87, 78, 0, 0,
            0, 0, 0, 0, 0, 1, 0, 0, 0, 7, 71, 67, 73, 90, 51, 71, 83, 77, 53, 88, 76, 55, 79, 85,
            83, 52, 85, 80, 54, 52, 84, 72, 77, 68, 90, 55, 67, 90, 51, 90, 87, 78, 0, 0, 0, 0, 0,
            0, 0, 10, 0, 0, 0, 10, 0, 0, 0, 10, 0, 0, 0, 10, 0, 0, 0, 0, 0, 0, 0, 10>>
      }
    end

    test "new/1", %{
      resources: resources,
      refundable_fee: refundable_fee,
      ext: ext
    } do
      %SorobanTransactionData{
        ext: ^ext,
        resources: ^resources,
        refundable_fee: ^refundable_fee
      } = SorobanTransactionData.new(ext, resources, refundable_fee)
    end

    test "encode_xdr/1", %{soroban_transaction_data: soroban_transaction_data, binary: binary} do
      {:ok, ^binary} = SorobanTransactionData.encode_xdr(soroban_transaction_data)
    end

    test "encode_xdr!/1", %{soroban_transaction_data: soroban_transaction_data, binary: binary} do
      ^binary = SorobanTransactionData.encode_xdr!(soroban_transaction_data)
    end

    test "decode_xdr/2", %{soroban_transaction_data: soroban_transaction_data, binary: binary} do
      {:ok, {^soroban_transaction_data, ""}} = SorobanTransactionData.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = SorobanTransactionData.decode_xdr(123)
    end

    test "decode_xdr!/2", %{soroban_transaction_data: soroban_transaction_data, binary: binary} do
      {^soroban_transaction_data, ^binary} = SorobanTransactionData.decode_xdr!(binary <> binary)
    end
  end
end
