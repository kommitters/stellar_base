defmodule StellarBase.XDR.SorobanResourcesTest do
  use ExUnit.Case

  alias StellarBase.XDR.LedgerFootprint

  alias StellarBase.XDR.{
    ContractCode,
    Hash,
    UInt32,
    SorobanResources,
    LedgerEntryType,
    LedgerKey,
    LedgerKeyList,
    LedgerFootprint
  }

  describe "SorobanResources" do
    setup do
      hash = Hash.new("GCIZ3GSM5XL7OUS4UP64THMDZ7CZ3ZWN")
      type = LedgerEntryType.new(:CONTRACT_CODE)
      ledger_key_data = ContractCode.new(hash)
      ledger_key1 = LedgerKey.new(ledger_key_data, type)
      ledger_key2 = LedgerKey.new(ledger_key_data, type)
      ledger_key_list_read = LedgerKeyList.new([ledger_key1])
      ledger_key_list_write = LedgerKeyList.new([ledger_key2])
      footprint = LedgerFootprint.new(ledger_key_list_read, ledger_key_list_write)
      instructions = UInt32.new(10)
      read_bytes = UInt32.new(10)
      write_bytes = UInt32.new(10)
      extended_meta_data_size_bytes = UInt32.new(10)

      soroban_resources =
        SorobanResources.new(
          footprint,
          instructions,
          read_bytes,
          write_bytes,
          extended_meta_data_size_bytes
        )

      %{
        footprint: footprint,
        instructions: instructions,
        read_bytes: read_bytes,
        write_bytes: write_bytes,
        extended_meta_data_size_bytes: extended_meta_data_size_bytes,
        soroban_resources: soroban_resources,
        binary:
          <<0, 0, 0, 1, 0, 0, 0, 7, 71, 67, 73, 90, 51, 71, 83, 77, 53, 88, 76, 55, 79, 85, 83,
            52, 85, 80, 54, 52, 84, 72, 77, 68, 90, 55, 67, 90, 51, 90, 87, 78, 0, 0, 0, 1, 0, 0,
            0, 7, 71, 67, 73, 90, 51, 71, 83, 77, 53, 88, 76, 55, 79, 85, 83, 52, 85, 80, 54, 52,
            84, 72, 77, 68, 90, 55, 67, 90, 51, 90, 87, 78, 0, 0, 0, 10, 0, 0, 0, 10, 0, 0, 0, 10,
            0, 0, 0, 10>>
      }
    end

    test "new/1", %{
      footprint: footprint,
      instructions: instructions,
      read_bytes: read_bytes,
      write_bytes: write_bytes,
      extended_meta_data_size_bytes: extended_meta_data_size_bytes
    } do
      %SorobanResources{
        footprint: ^footprint,
        instructions: ^instructions,
        read_bytes: ^read_bytes,
        write_bytes: ^write_bytes,
        extended_meta_data_size_bytes: ^extended_meta_data_size_bytes
      } =
        SorobanResources.new(
          footprint,
          instructions,
          read_bytes,
          write_bytes,
          extended_meta_data_size_bytes
        )
    end

    test "encode_xdr/1", %{soroban_resources: soroban_resources, binary: binary} do
      {:ok, ^binary} = SorobanResources.encode_xdr(soroban_resources)
    end

    test "encode_xdr!/1", %{soroban_resources: soroban_resources, binary: binary} do
      ^binary = SorobanResources.encode_xdr!(soroban_resources)
    end

    test "decode_xdr/2", %{soroban_resources: soroban_resources, binary: binary} do
      {:ok, {^soroban_resources, ""}} = SorobanResources.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = SorobanResources.decode_xdr(123)
    end

    test "decode_xdr!/2", %{soroban_resources: soroban_resources, binary: binary} do
      {^soroban_resources, ^binary} = SorobanResources.decode_xdr!(binary <> binary)
    end
  end
end
