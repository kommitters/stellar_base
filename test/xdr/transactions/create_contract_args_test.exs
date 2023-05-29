defmodule StellarBase.XDR.CreateContractArgsTest do
  use ExUnit.Case

  alias StellarBase.XDR.{
    ContractID,
    ContractIDType,
    CreateContractArgs,
    SCContractExecutable,
    SCContractExecutableType,
    Hash,
    UInt256
  }

  alias StellarBase.StrKey

  describe "CreateContractArgs" do
    setup do
      # SCContractExecutable
      contract_executable = Hash.new("GCIZ3GSM5XL7OUS4UP64THMDZ7CZ3ZWN")
      sc_contract_executable_type = SCContractExecutableType.new(:SCCONTRACT_EXECUTABLE_WASM_REF)

      sc_contract_executable =
        SCContractExecutable.new(contract_executable, sc_contract_executable_type)

      # ContractID
      salt =
        "GCJCFK7GZEOXVAWWOWYFTR5C5IZAQBYV5HIJUGVZPUBDJNRFVXXZEHHV"
        |> StrKey.decode!(:ed25519_public_key)
        |> UInt256.new()

      contract_id_type = ContractIDType.new(:CONTRACT_ID_FROM_SOURCE_ACCOUNT)
      contract_id = ContractID.new(salt, contract_id_type)

      %{
        sc_contract_executable: sc_contract_executable,
        contract_id: contract_id,
        create_contract_args: CreateContractArgs.new(contract_id, sc_contract_executable),
        binary:
          <<0, 0, 0, 0, 146, 34, 171, 230, 201, 29, 122, 130, 214, 117, 176, 89, 199, 162, 234,
            50, 8, 7, 21, 233, 208, 154, 26, 185, 125, 2, 52, 182, 37, 173, 239, 146, 0, 0, 0, 0,
            71, 67, 73, 90, 51, 71, 83, 77, 53, 88, 76, 55, 79, 85, 83, 52, 85, 80, 54, 52, 84,
            72, 77, 68, 90, 55, 67, 90, 51, 90, 87, 78>>
      }
    end

    test "new/1", %{contract_id: contract_id, sc_contract_executable: sc_contract_executable} do
      %CreateContractArgs{contract_id: ^contract_id, executable: ^sc_contract_executable} =
        CreateContractArgs.new(contract_id, sc_contract_executable)
    end

    test "encode_xdr/1", %{create_contract_args: create_contract_args, binary: binary} do
      {:ok, ^binary} = CreateContractArgs.encode_xdr(create_contract_args)
    end

    test "encode_xdr!/1", %{create_contract_args: create_contract_args, binary: binary} do
      ^binary = CreateContractArgs.encode_xdr!(create_contract_args)
    end

    test "decode_xdr/2", %{create_contract_args: create_contract_args, binary: binary} do
      {:ok, {^create_contract_args, ""}} = CreateContractArgs.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = CreateContractArgs.decode_xdr(1234)
    end

    test "decode_xdr!/2", %{create_contract_args: create_contract_args, binary: binary} do
      {^create_contract_args, ^binary} = CreateContractArgs.decode_xdr!(binary <> binary)
    end
  end
end
