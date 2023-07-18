defmodule StellarBase.XDR.CreateContractArgsTest do
  use ExUnit.Case

  alias StellarBase.XDR.{
    ContractIDPreimage,
    ContractIDPreimageFromAddress,
    ContractIDPreimageType,
    CreateContractArgs,
    ContractExecutable,
    ContractExecutableType,
    Hash,
    SCAddress,
    SCAddressType,
    UInt256
  }

  alias StellarBase.StrKey

  describe "CreateContractArgs" do
    setup do
      # ContractExecutable
      address = Hash.new("CAWIIZPXNRY7X3FKFO4CWJT5DQOSEXQK")
      sc_address = SCAddress.new(address, SCAddressType.new(:SC_ADDRESS_TYPE_CONTRACT))

      salt =
        "GCJCFK7GZEOXVAWWOWYFTR5C5IZAQBYV5HIJUGVZPUBDJNRFVXXZEHHV"
        |> StrKey.decode!(:ed25519_public_key)
        |> UInt256.new()

      id_preimage_address =
        ContractIDPreimageFromAddress.new(
          sc_address,
          salt
        )

      # ContractID
      contract_id_preimage =
        ContractIDPreimage.new(id_preimage_address, ContractIDPreimageType.new())

      sc_contract_executable_type = ContractExecutableType.new(:CONTRACT_EXECUTABLE_WASM)

      sc_contract_executable = ContractExecutable.new(address, sc_contract_executable_type)

      %{
        sc_contract_executable: sc_contract_executable,
        contract_id_preimage: contract_id_preimage,
        create_contract_args:
          CreateContractArgs.new(contract_id_preimage, sc_contract_executable),
        binary:
          <<0, 0, 0, 0, 0, 0, 0, 1, 67, 65, 87, 73, 73, 90, 80, 88, 78, 82, 89, 55, 88, 51, 70,
            75, 70, 79, 52, 67, 87, 74, 84, 53, 68, 81, 79, 83, 69, 88, 81, 75, 146, 34, 171, 230,
            201, 29, 122, 130, 214, 117, 176, 89, 199, 162, 234, 50, 8, 7, 21, 233, 208, 154, 26,
            185, 125, 2, 52, 182, 37, 173, 239, 146, 0, 0, 0, 0, 67, 65, 87, 73, 73, 90, 80, 88,
            78, 82, 89, 55, 88, 51, 70, 75, 70, 79, 52, 67, 87, 74, 84, 53, 68, 81, 79, 83, 69,
            88, 81, 75>>
      }
    end

    test "new/1", %{
      contract_id_preimage: contract_id_preimage,
      sc_contract_executable: sc_contract_executable
    } do
      %CreateContractArgs{
        contract_id_preimage: ^contract_id_preimage,
        executable: ^sc_contract_executable
      } = CreateContractArgs.new(contract_id_preimage, sc_contract_executable)
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
