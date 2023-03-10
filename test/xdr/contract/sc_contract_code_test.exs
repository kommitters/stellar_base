defmodule StellarBase.XDR.SCContractCodeTest do
  use ExUnit.Case

  alias StellarBase.XDR.SCContractCode
  alias StellarBase.XDR.SCContractCodeType

  alias StellarBase.XDR.{
    AccountID,
    PublicKey,
    PublicKeyType,
    UInt256,
    Hash
  }

  alias StellarBase.StrKey

  describe "SCContractCode" do
    setup do
      contract_code = Hash.new("GCIZ3GSM5XL7OUS4UP64THMDZ7CZ3ZWN")

      sc_contract_code_type = SCContractCodeType.new(:SCCONTRACT_CODE_WASM_REF)

      %{
        contract_code: contract_code,
        sc_contract_code_type: sc_contract_code_type,
        sc_contract_code: SCContractCode.new(contract_code, sc_contract_code_type),
        binary:
          <<0, 0, 0, 0, 71, 67, 73, 90, 51, 71, 83, 77, 53, 88, 76, 55, 79, 85, 83, 52, 85, 80,
            54, 52, 84, 72, 77, 68, 90, 55, 67, 90, 51, 90, 87, 78>>
      }
    end

    test "new/1", %{contract_code: contract_code, sc_contract_code_type: sc_contract_code_type} do
      %SCContractCode{contract_code: ^contract_code, type: ^sc_contract_code_type} =
        SCContractCode.new(contract_code, sc_contract_code_type)
    end

    test "encode_xdr/1", %{sc_contract_code: sc_contract_code, binary: binary} do
      {:ok, ^binary} = SCContractCode.encode_xdr(sc_contract_code)
    end

    test "encode_xdr/1 with an invalid type", %{contract_code: contract_code} do
      sc_contract_code_type = SCContractCodeType.new(:NEW_CONTRACT)

      assert_raise XDR.EnumError,
                   "The key which you try to encode doesn't belong to the current declarations",
                   fn ->
                     contract_code
                     |> SCContractCode.new(sc_contract_code_type)
                     |> SCContractCode.encode_xdr()
                   end
    end

    test "encode_xdr!/1", %{sc_contract_code: sc_contract_code, binary: binary} do
      ^binary = SCContractCode.encode_xdr!(sc_contract_code)
    end

    test "decode_xdr/2", %{sc_contract_code: sc_contract_code, binary: binary} do
      {:ok, {^sc_contract_code, ""}} = SCContractCode.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = SCContractCode.decode_xdr(123)
    end

    test "decode_xdr!/2", %{sc_contract_code: sc_contract_code, binary: binary} do
      {^sc_contract_code, ^binary} = SCContractCode.decode_xdr!(binary <> binary)
    end
  end
end
