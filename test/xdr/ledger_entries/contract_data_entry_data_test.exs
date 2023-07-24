defmodule StellarBase.XDR.ContractDataEntryDataTest do
  use ExUnit.Case

  alias StellarBase.XDR.{ContractDataEntryData, Int32, SCVal, SCValType, UInt32}

  setup do
    flags = UInt32.new(123)
    sc_val = SCVal.new(Int32.new(42), SCValType.new(:SCV_I32))

    %{
      flags: flags,
      sc_val: sc_val,
      data_entry_data: ContractDataEntryData.new(flags, sc_val),
      binary: <<0, 0, 0, 123, 0, 0, 0, 4, 0, 0, 0, 42>>
    }
  end

  test "new/2", %{flags: flags, sc_val: sc_val} do
    %ContractDataEntryData{flags: ^flags, val: ^sc_val} = ContractDataEntryData.new(flags, sc_val)
  end

  test "encode_xdr/1", %{data_entry_data: data_entry_data, binary: binary} do
    {:ok, ^binary} = ContractDataEntryData.encode_xdr(data_entry_data)
  end

  test "encode_xdr!/1", %{data_entry_data: data_entry_data, binary: binary} do
    ^binary = ContractDataEntryData.encode_xdr!(data_entry_data)
  end

  test "decode_xdr/2", %{data_entry_data: data_entry_data, binary: binary} do
    {:ok, {^data_entry_data, ""}} = ContractDataEntryData.decode_xdr(binary)
  end

  test "decode_xdr!/2", %{data_entry_data: data_entry_data, binary: binary} do
    {^data_entry_data, ""} = ContractDataEntryData.decode_xdr!(binary)
  end

  test "decode_xdr!/2 with an invalid binary" do
    {:error, :not_binary} = ContractDataEntryData.decode_xdr(123)
  end
end
