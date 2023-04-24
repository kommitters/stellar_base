defmodule StellarBase.XDR.SCContractExecutableTest do
  use ExUnit.Case

  alias StellarBase.XDR.{SCContractExecutable, SCContractExecutableType, Hash}

  describe "SCContractExecutable" do
    setup do
      contract_executable = Hash.new("GCIZ3GSM5XL7OUS4UP64THMDZ7CZ3ZWN")

      sc_contract_executable_type = SCContractExecutableType.new(:SCCONTRACT_EXECUTABLE_WASM_REF)

      %{
        contract_executable: contract_executable,
        sc_contract_executable_type: sc_contract_executable_type,
        sc_contract_executable:
          SCContractExecutable.new(contract_executable, sc_contract_executable_type),
        binary:
          <<0, 0, 0, 0, 71, 67, 73, 90, 51, 71, 83, 77, 53, 88, 76, 55, 79, 85, 83, 52, 85, 80,
            54, 52, 84, 72, 77, 68, 90, 55, 67, 90, 51, 90, 87, 78>>
      }
    end

    test "new/1", %{
      contract_executable: contract_executable,
      sc_contract_executable_type: sc_contract_executable_type
    } do
      %SCContractExecutable{
        contract_executable: ^contract_executable,
        type: ^sc_contract_executable_type
      } = SCContractExecutable.new(contract_executable, sc_contract_executable_type)
    end

    test "encode_xdr/1", %{
      sc_contract_executable: sc_contract_executable,
      binary: binary
    } do
      {:ok, ^binary} = SCContractExecutable.encode_xdr(sc_contract_executable)
    end

    test "encode_xdr/1 with an invalid type", %{
      contract_executable: contract_executable
    } do
      sc_contract_executable_type = SCContractExecutableType.new(:NEW_CONTRACT)

      assert_raise XDR.EnumError,
                   "The key which you try to encode doesn't belong to the current declarations",
                   fn ->
                     contract_executable
                     |> SCContractExecutable.new(sc_contract_executable_type)
                     |> SCContractExecutable.encode_xdr()
                   end
    end

    test "encode_xdr!/1", %{
      sc_contract_executable: sc_contract_executable,
      binary: binary
    } do
      ^binary = SCContractExecutable.encode_xdr!(sc_contract_executable)
    end

    test "decode_xdr/2", %{
      sc_contract_executable: sc_contract_executable,
      binary: binary
    } do
      {:ok, {^sc_contract_executable, ""}} = SCContractExecutable.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = SCContractExecutable.decode_xdr(123)
    end

    test "decode_xdr!/2", %{
      sc_contract_executable: sc_contract_executable,
      binary: binary
    } do
      {^sc_contract_executable, ^binary} = SCContractExecutable.decode_xdr!(binary <> binary)
    end
  end
end
