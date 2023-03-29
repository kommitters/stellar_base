defmodule StellarBase.XDR.HostFunctionTest do
  use ExUnit.Case

  alias StellarBase.XDR.{
    HostFunctionType,
    HostFunction,
    SCVal,
    Int64,
    SCValType,
    VariableOpaque256000,
    CreateContractArgs,
    SCVec,
    InstallContractCodeArgs,
    Hash,
    SCContractCodeType,
    SCContractCode,
    UInt256,
    ContractIDType,
    ContractID
  }

  alias StellarBase.StrKey

  describe "HostFunction" do
    setup do
      ## SCVec
      scval1 = SCVal.new(Int64.new(3), SCValType.new(:SCV_U63))
      scval2 = SCVal.new(Int64.new(2), SCValType.new(:SCV_U63))
      sc_vals = [scval1, scval2]
      sc_vec = SCVec.new(sc_vals)

      ## CreateContractArgs
      # SCContractCode
      contract_code = Hash.new("GCIZ3GSM5XL7OUS4UP64THMDZ7CZ3ZWN")
      sc_contract_code_type = SCContractCodeType.new(:SCCONTRACT_CODE_WASM_REF)

      sc_contract_code = SCContractCode.new(contract_code, sc_contract_code_type)

      # ContractID
      salt =
        "GCJCFK7GZEOXVAWWOWYFTR5C5IZAQBYV5HIJUGVZPUBDJNRFVXXZEHHV"
        |> StrKey.decode!(:ed25519_public_key)
        |> UInt256.new()

      contract_id_type = ContractIDType.new(:CONTRACT_ID_FROM_SOURCE_ACCOUNT)
      contract_id = ContractID.new(salt, contract_id_type)

      create_contract_args = CreateContractArgs.new(contract_id, sc_contract_code)

      ## InstallContractCodeArgs
      code = VariableOpaque256000.new("GCIZ3GSM5")
      install_contract_code_args = InstallContractCodeArgs.new(code)

      discriminants = [
        %{
          host_function_type: HostFunctionType.new(:HOST_FUNCTION_TYPE_INVOKE_CONTRACT),
          host_function: sc_vec,
          binary:
            <<0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0,
              0, 0, 0, 2>>
        },
        %{
          host_function_type: HostFunctionType.new(:HOST_FUNCTION_TYPE_CREATE_CONTRACT),
          host_function: create_contract_args,
          binary:
            <<0, 0, 0, 1, 0, 0, 0, 0, 146, 34, 171, 230, 201, 29, 122, 130, 214, 117, 176, 89,
              199, 162, 234, 50, 8, 7, 21, 233, 208, 154, 26, 185, 125, 2, 52, 182, 37, 173, 239,
              146, 0, 0, 0, 0, 71, 67, 73, 90, 51, 71, 83, 77, 53, 88, 76, 55, 79, 85, 83, 52, 85,
              80, 54, 52, 84, 72, 77, 68, 90, 55, 67, 90, 51, 90, 87, 78>>
        },
        %{
          host_function_type: HostFunctionType.new(:HOST_FUNCTION_TYPE_INSTALL_CONTRACT_CODE),
          host_function: install_contract_code_args,
          binary: <<0, 0, 0, 2, 0, 0, 0, 9, 71, 67, 73, 90, 51, 71, 83, 77, 53, 0, 0, 0>>
        }
      ]

      %{discriminants: discriminants}
    end

    test "new/1", %{discriminants: discriminants} do
      for %{host_function_type: host_function_type, host_function: host_function} <-
            discriminants do
        %HostFunction{host_function: ^host_function, type: ^host_function_type} =
          HostFunction.new(host_function, host_function_type)
      end
    end

    test "encode_xdr/1", %{discriminants: discriminants} do
      for %{
            host_function: host_function,
            host_function_type: host_function_type,
            binary: binary
          } <- discriminants do
        xdr = HostFunction.new(host_function, host_function_type)
        {:ok, ^binary} = HostFunction.encode_xdr(xdr)
      end
    end

    test "encode_xdr!/1", %{discriminants: discriminants} do
      for %{
            host_function: host_function,
            host_function_type: host_function_type,
            binary: binary
          } <- discriminants do
        xdr = HostFunction.new(host_function, host_function_type)
        ^binary = HostFunction.encode_xdr!(xdr)
      end
    end

    test "encode_xdr/1 with an invalid type", %{discriminants: [host_function | _rest]} do
      host_function_type = HostFunctionType.new(:NEW_ADDRESS)

      assert_raise XDR.EnumError,
                   "The key which you try to encode doesn't belong to the current declarations",
                   fn ->
                     host_function
                     |> HostFunction.new(host_function_type)
                     |> HostFunction.encode_xdr()
                   end
    end

    test "decode_xdr/2", %{discriminants: discriminants} do
      for %{
            host_function: host_function,
            host_function_type: host_function_type,
            binary: binary
          } <- discriminants do
        xdr = HostFunction.new(host_function, host_function_type)
        {:ok, {^xdr, ""}} = HostFunction.decode_xdr(binary)
      end
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = HostFunction.decode_xdr(123)
    end

    test "decode_xdr!/2", %{discriminants: discriminants} do
      for %{
            host_function: host_function,
            host_function_type: host_function_type,
            binary: binary
          } <- discriminants do
        xdr = HostFunction.new(host_function, host_function_type)
        {^xdr, ""} = HostFunction.decode_xdr!(binary)
      end
    end
  end
end
