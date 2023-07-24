defmodule StellarBase.XDR.ContractCodeEntryBodyTest do
  use ExUnit.Case

  alias StellarBase.XDR.{ContractCodeEntryBody, ContractEntryBodyType, VariableOpaque, Void}

  setup do
    data = <<1, 2, 3, 4, 5>>
    expiration_extension = Void.new()
    data_entry_type = %ContractEntryBodyType{identifier: :DATA_ENTRY}
    expiration_extension_type = %ContractEntryBodyType{identifier: :EXPIRATION_EXTENSION}

    expiration_extension_body =
      ContractCodeEntryBody.new(expiration_extension, expiration_extension_type)

    variable_opaque =
      VariableOpaque.new(<<0, 0, 0, 9, 71, 67, 73, 90, 51, 71, 83, 77, 53, 0, 0, 0>>)

    encoded_result_data_entry =
      <<0, 0, 0, 0, 0, 0, 0, 16, 0, 0, 0, 9, 71, 67, 73, 90, 51, 71, 83, 77, 53, 0, 0, 0>>

    encoded_result_expiration_extension = <<0, 0, 0, 1>>
    data_entry_body = ContractCodeEntryBody.new(variable_opaque, data_entry_type)

    %{
      data: data,
      data_entry_type: data_entry_type,
      expiration_extension: expiration_extension,
      expiration_extension_type: expiration_extension_type,
      data_entry_body: data_entry_body,
      expiration_extension_body: expiration_extension_body,
      variable_opaque: variable_opaque,
      encoded_result_data_entry: encoded_result_data_entry,
      encoded_result_expiration_extension: encoded_result_expiration_extension
    }
  end

  test "new/2 with data entry", %{
    data_entry_type: data_entry_type,
    variable_opaque: variable_opaque
  } do
    %ContractCodeEntryBody{value: ^variable_opaque, type: ^data_entry_type} =
      ContractCodeEntryBody.new(variable_opaque, data_entry_type)
  end

  test "new/2 with expiration extension", %{
    expiration_extension: expiration_extension,
    expiration_extension_type: expiration_extension_type
  } do
    %ContractCodeEntryBody{value: %Void{}, type: ^expiration_extension_type} =
      ContractCodeEntryBody.new(expiration_extension, expiration_extension_type)
  end

  test "encode_xdr/1 with data entry", %{
    data_entry_body: data_entry_body,
    encoded_result_data_entry: encoded_result_data_entry
  } do
    {:ok, ^encoded_result_data_entry} = ContractCodeEntryBody.encode_xdr(data_entry_body)
  end

  test "encode_xdr/1 with expiration extension", %{
    expiration_extension_body: expiration_extension_body,
    encoded_result_expiration_extension: encoded_result_expiration_extension
  } do
    {:ok, ^encoded_result_expiration_extension} =
      ContractCodeEntryBody.encode_xdr(expiration_extension_body)
  end

  test "encode_xdr!/1 with data entry", %{
    data_entry_body: data_entry_body,
    encoded_result_data_entry: encoded_result_data_entry
  } do
    ^encoded_result_data_entry = ContractCodeEntryBody.encode_xdr!(data_entry_body)
  end

  test "encode_xdr!/1 with expiration extension", %{
    expiration_extension_body: expiration_extension_body,
    encoded_result_expiration_extension: encoded_result_expiration_extension
  } do
    ^encoded_result_expiration_extension =
      ContractCodeEntryBody.encode_xdr!(expiration_extension_body)
  end

  test "decode_xdr/2 with data entry", %{data_entry_body: data_entry_body} do
    {:ok, {^data_entry_body, ""}} =
      ContractCodeEntryBody.decode_xdr(ContractCodeEntryBody.encode_xdr!(data_entry_body))
  end

  test "decode_xdr/2 with expiration extension", %{
    expiration_extension_body: expiration_extension_body
  } do
    {:ok, {^expiration_extension_body, ""}} =
      ContractCodeEntryBody.decode_xdr(
        ContractCodeEntryBody.encode_xdr!(expiration_extension_body)
      )
  end

  test "decode_xdr!/2 with data entry", %{data_entry_body: data_entry_body} do
    {^data_entry_body, ""} =
      ContractCodeEntryBody.decode_xdr!(ContractCodeEntryBody.encode_xdr!(data_entry_body))
  end

  test "decode_xdr!/2 with expiration extension", %{
    expiration_extension_body: expiration_extension_body
  } do
    {^expiration_extension_body, ""} =
      ContractCodeEntryBody.decode_xdr!(
        ContractCodeEntryBody.encode_xdr!(expiration_extension_body)
      )
  end

  test "decode_xdr!/2 with an invalid binary" do
    {:error, :not_binary} = ContractCodeEntryBody.decode_xdr(123)
  end
end
