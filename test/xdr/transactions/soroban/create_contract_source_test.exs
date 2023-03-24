defmodule StellarBase.XDR.CreateContractSourceTest do
  use ExUnit.Case

  alias StellarBase.XDR.{
    SCContractCode,
    InstallContractCodeArgs,
    CreateContractSourceType,
    SCContractCodeType,
    Hash,
    CreateContractSource,
    VariableOpaque256000
  }

  describe "CreateContractSource" do
    setup do
      ## SCContractCode
      contract_code = Hash.new("GCIZ3GSM5XL7OUS4UP64THMDZ7CZ3ZWN")
      sc_contract_code_type = SCContractCodeType.new(:SCCONTRACT_CODE_WASM_REF)

      ## InstallContractCodeArgs
      code = VariableOpaque256000.new("GCIZ3GSM5")

      discriminants = [
        %{
          contract_source_type: CreateContractSourceType.new(:CONTRACT_SOURCE_REF),
          contract_source: SCContractCode.new(contract_code, sc_contract_code_type),
          binary:
            <<0, 0, 0, 0, 0, 0, 0, 0, 71, 67, 73, 90, 51, 71, 83, 77, 53, 88, 76, 55, 79, 85, 83,
              52, 85, 80, 54, 52, 84, 72, 77, 68, 90, 55, 67, 90, 51, 90, 87, 78>>
        },
        %{
          contract_source_type: CreateContractSourceType.new(:CONTRACT_SOURCE_INSTALLED),
          contract_source: InstallContractCodeArgs.new(code),
          binary: <<0, 0, 0, 1, 0, 0, 0, 9, 71, 67, 73, 90, 51, 71, 83, 77, 53, 0, 0, 0>>
        }
      ]

      %{discriminants: discriminants}
    end

    test "new/1", %{discriminants: discriminants} do
      for %{contract_source_type: contract_source_type, contract_source: contract_source} <-
            discriminants do
        %CreateContractSource{contract_source: ^contract_source, type: ^contract_source_type} =
          CreateContractSource.new(contract_source, contract_source_type)
      end
    end

    test "encode_xdr/1", %{discriminants: discriminants} do
      for %{
            contract_source: contract_source,
            contract_source_type: contract_source_type,
            binary: binary
          } <- discriminants do
        xdr = CreateContractSource.new(contract_source, contract_source_type)
        {:ok, ^binary} = CreateContractSource.encode_xdr(xdr)
      end
    end

    test "encode_xdr!/1", %{discriminants: discriminants} do
      for %{
            contract_source: contract_source,
            contract_source_type: contract_source_type,
            binary: binary
          } <- discriminants do
        xdr = CreateContractSource.new(contract_source, contract_source_type)
        ^binary = CreateContractSource.encode_xdr!(xdr)
      end
    end

    test "encode_xdr/1 with an invalid type", %{discriminants: [contract_source | _rest]} do
      contract_source_type = CreateContractSourceType.new(:NEW_ADDRESS)

      assert_raise XDR.EnumError,
                   "The key which you try to encode doesn't belong to the current declarations",
                   fn ->
                     contract_source
                     |> CreateContractSource.new(contract_source_type)
                     |> CreateContractSource.encode_xdr()
                   end
    end

    test "decode_xdr/2", %{discriminants: discriminants} do
      for %{
            contract_source: contract_source,
            contract_source_type: contract_source_type,
            binary: binary
          } <- discriminants do
        xdr = CreateContractSource.new(contract_source, contract_source_type)
        {:ok, {^xdr, ""}} = CreateContractSource.decode_xdr(binary)
      end
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = CreateContractSource.decode_xdr(123)
    end

    test "decode_xdr!/2", %{discriminants: discriminants} do
      for %{
            contract_source: contract_source,
            contract_source_type: contract_source_type,
            binary: binary
          } <- discriminants do
        xdr = CreateContractSource.new(contract_source, contract_source_type)
        {^xdr, ""} = CreateContractSource.decode_xdr!(binary)
      end
    end
  end
end
