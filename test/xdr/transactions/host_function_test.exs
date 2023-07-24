defmodule StellarBase.XDR.Operations.HostFunctionTest do
  use ExUnit.Case

  alias StellarBase.XDR.{
    ContractIDPreimage,
    ContractIDPreimageFromAddress,
    ContractIDPreimageType,
    CreateContractArgs,
    ContractExecutable,
    ContractExecutableType,
    SCAddress,
    SCAddressType,
    SCVal,
    SCValType,
    SCVec,
    Int64,
    Hash,
    HostFunctionType,
    HostFunction,
    Int64,
    SCVal,
    SCValType,
    SCVec,
    UInt256
  }

  alias StellarBase.StrKey

  describe "HostFunction" do
    setup do
      ## HostFunction
      scval1 = SCVal.new(Int64.new(3), SCValType.new(:SCV_I64))
      scval2 = SCVal.new(Int64.new(2), SCValType.new(:SCV_I64))
      sc_vals = [scval1, scval2]
      sc_vec = SCVec.new(sc_vals)
      host_function_type = HostFunctionType.new()
      host_function = HostFunction.new(sc_vec, host_function_type)

      host_function_create_type = HostFunctionType.new(:HOST_FUNCTION_TYPE_CREATE_CONTRACT)

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

      contract_id_preimage =
        ContractIDPreimage.new(id_preimage_address, ContractIDPreimageType.new())

      sc_contract_executable_type = ContractExecutableType.new(:CONTRACT_EXECUTABLE_WASM)

      sc_contract_executable = ContractExecutable.new(address, sc_contract_executable_type)

      host_function_create_value =
        CreateContractArgs.new(contract_id_preimage, sc_contract_executable)

      host_function_create_contract =
        HostFunction.new(host_function_create_value, host_function_create_type)

      %{
        host_function_args: sc_vals,
        host_function_create_type: host_function_create_type,
        host_function_create_value: host_function_create_value,
        host_function_create_contract: host_function_create_contract,
        host_function_type: host_function_type,
        host_function: host_function,
        binary:
          <<0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 6, 0, 0, 0, 0, 0,
            0, 0, 2>>,
        create_contact_binary:
          <<0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 67, 65, 87, 73, 73, 90, 80, 88, 78, 82, 89, 55,
            88, 51, 70, 75, 70, 79, 52, 67, 87, 74, 84, 53, 68, 81, 79, 83, 69, 88, 81, 75, 146,
            34, 171, 230, 201, 29, 122, 130, 214, 117, 176, 89, 199, 162, 234, 50, 8, 7, 21, 233,
            208, 154, 26, 185, 125, 2, 52, 182, 37, 173, 239, 146, 0, 0, 0, 0, 67, 65, 87, 73, 73,
            90, 80, 88, 78, 82, 89, 55, 88, 51, 70, 75, 70, 79, 52, 67, 87, 74, 84, 53, 68, 81,
            79, 83, 69, 88, 81, 75>>
      }
    end

    test "new/1", %{
      host_function_args: host_function_args,
      host_function_type: host_function_type
    } do
      %HostFunction{value: ^host_function_args, type: ^host_function_type} =
        HostFunction.new(host_function_args, host_function_type)
    end

    test "new create contract /1", %{
      host_function_create_value: host_function_create_value,
      host_function_create_type: host_function_create_type
    } do
      %HostFunction{value: ^host_function_create_value, type: ^host_function_create_type} =
        HostFunction.new(host_function_create_value, host_function_create_type)
    end

    test "encode_xdr/1", %{
      host_function: host_function,
      binary: binary
    } do
      {:ok, ^binary} = HostFunction.encode_xdr(host_function)
    end

    test "encode_xdr/1 with create contract type", %{
      host_function_create_contract: host_function_create_contract,
      create_contact_binary: create_contact_binary
    } do
      {:ok, ^create_contact_binary} = HostFunction.encode_xdr(host_function_create_contract)
    end

    test "encode_xdr!/1", %{
      host_function: host_function,
      binary: binary
    } do
      ^binary = HostFunction.encode_xdr!(host_function)
    end

    test "encode_xdr!/1 with create contract type", %{
      host_function_create_contract: host_function_create_contract,
      create_contact_binary: create_contact_binary
    } do
      ^create_contact_binary = HostFunction.encode_xdr!(host_function_create_contract)
    end

    test "decode_xdr/2", %{
      host_function: host_function,
      binary: binary
    } do
      {:ok, {^host_function, ""}} = HostFunction.decode_xdr(binary)
    end

    test "decode_xdr/2 with create contract type", %{
      host_function_create_contract: host_function_create_contract,
      create_contact_binary: create_contact_binary
    } do
      {:ok, {^host_function_create_contract, ""}} = HostFunction.decode_xdr(create_contact_binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = HostFunction.decode_xdr(123)
    end

    test "decode_xdr!/2", %{
      host_function: host_function,
      binary: binary
    } do
      {^host_function, ^binary} = HostFunction.decode_xdr!(binary <> binary)
    end

    test "decode_xdr!/2 with create contract type", %{
      host_function_create_contract: host_function_create_contract,
      create_contact_binary: create_contact_binary
    } do
      {^host_function_create_contract, ^create_contact_binary} =
        HostFunction.decode_xdr!(create_contact_binary <> create_contact_binary)
    end
  end
end
