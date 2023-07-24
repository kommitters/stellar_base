defmodule StellarBase.XDR.ContractDataEntryBodyTest do
  use ExUnit.Case

  alias StellarBase.XDR.{
    ContractDataEntryBody,
    ContractEntryBodyType,
    ContractDataEntryData,
    UInt32,
    SCVal,
    SCValType,
    Int32
  }

  setup do
    flags = UInt32.new(123)

    sc_val = SCVal.new(Int32.new(42), SCValType.new(:SCV_I32))

    data_entry_data = %ContractDataEntryData{flags: flags, val: sc_val}
    type = ContractEntryBodyType.new(:DATA_ENTRY)
    data_entry_body = %ContractDataEntryBody{value: data_entry_data, type: type}

    binary = <<0, 0, 0, 0, 0, 0, 0, 123, 0, 0, 0, 4, 0, 0, 0, 42>>

    %{
      data_entry_data: data_entry_data,
      type: type,
      data_entry_body: data_entry_body,
      binary: binary
    }
  end

  test "new/2", %{data_entry_data: data_entry_data, type: type} do
    %ContractDataEntryBody{value: ^data_entry_data, type: ^type} =
      ContractDataEntryBody.new(data_entry_data, type)
  end

  test "encode_xdr/1", %{data_entry_body: data_entry_body, binary: binary} do
    {:ok, ^binary} = ContractDataEntryBody.encode_xdr(data_entry_body)
  end

  test "encode_xdr!/1", %{data_entry_body: data_entry_body, binary: binary} do
    ^binary = ContractDataEntryBody.encode_xdr!(data_entry_body)
  end

  test "decode_xdr/2", %{data_entry_body: data_entry_body} do
    {:ok, {^data_entry_body, ""}} =
      ContractDataEntryBody.decode_xdr(ContractDataEntryBody.encode_xdr!(data_entry_body))
  end

  test "decode_xdr!/2", %{data_entry_body: data_entry_body} do
    {^data_entry_body, ""} =
      ContractDataEntryBody.decode_xdr!(ContractDataEntryBody.encode_xdr!(data_entry_body))
  end

  test "decode_xdr!/2 with an invalid binary" do
    {:error, :not_binary} = ContractDataEntryBody.decode_xdr(123)
  end
end
