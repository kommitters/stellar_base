defmodule StellarBase.XDR.ContractDataFlagsTest do
  use ExUnit.Case

  alias StellarBase.XDR.ContractDataFlags

  setup do
    %{
      identifier: :NO_AUTOBUMP,
      contract_data_flags: ContractDataFlags.new(),
      binary: <<0, 0, 0, 1>>
    }
  end

  test "new/2", %{identifier: identifier} do
    %ContractDataFlags{identifier: ^identifier} = ContractDataFlags.new()
  end

  test "encode_xdr/1", %{contract_data_flags: contract_data_flags, binary: binary} do
    {:ok, ^binary} = ContractDataFlags.encode_xdr(contract_data_flags)
  end

  test "encode_xdr!/1", %{contract_data_flags: contract_data_flags, binary: binary} do
    ^binary = ContractDataFlags.encode_xdr!(contract_data_flags)
  end

  test "decode_xdr/2", %{contract_data_flags: contract_data_flags} do
    {:ok, {^contract_data_flags, ""}} =
      ContractDataFlags.decode_xdr(ContractDataFlags.encode_xdr!(contract_data_flags))
  end

  test "decode_xdr!/2", %{contract_data_flags: contract_data_flags} do
    {^contract_data_flags, ""} =
      ContractDataFlags.decode_xdr!(ContractDataFlags.encode_xdr!(contract_data_flags))
  end

  test "decode_xdr!/2 with an invalid binary" do
    {:error, :not_binary} = ContractDataFlags.decode_xdr(123)
  end
end
