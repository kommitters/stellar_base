defmodule StellarBase.XDR.StructContractIDTest do
  use ExUnit.Case

  alias StellarBase.XDR.{StructContractID, Hash, UInt256}

  describe "StructContractID" do
    setup do
      network_id = Hash.new("GCIZ3GSM5XL7OUS4UP64THMDZ7CZ3ZWN")
      contract_id = Hash.new("GCIZ3GSM5XL7OUS4UP64THMDZ7CZ3ZWN")

      salt =
        UInt256.new(
          <<72, 101, 108, 108, 111, 32, 119, 111, 114, 108, 100, 0, 21, 0, 1, 0, 72, 101, 108,
            108, 111, 32, 119, 111, 114, 108, 100, 0, 21, 0, 1, 0>>
        )

      %{
        network_id: network_id,
        contract_id: contract_id,
        salt: salt,
        contract_id_contract_id: StructContractID.new(network_id, contract_id, salt),
        binary:
          <<71, 67, 73, 90, 51, 71, 83, 77, 53, 88, 76, 55, 79, 85, 83, 52, 85, 80, 54, 52, 84,
            72, 77, 68, 90, 55, 67, 90, 51, 90, 87, 78, 71, 67, 73, 90, 51, 71, 83, 77, 53, 88,
            76, 55, 79, 85, 83, 52, 85, 80, 54, 52, 84, 72, 77, 68, 90, 55, 67, 90, 51, 90, 87,
            78, 72, 101, 108, 108, 111, 32, 119, 111, 114, 108, 100, 0, 21, 0, 1, 0, 72, 101, 108,
            108, 111, 32, 119, 111, 114, 108, 100, 0, 21, 0, 1, 0>>
      }
    end

    test "new/1", %{
      network_id: network_id,
      contract_id: contract_id,
      salt: salt
    } do
      %StructContractID{
        network_id: ^network_id,
        contract_id: ^contract_id,
        salt: ^salt
      } = StructContractID.new(network_id, contract_id, salt)
    end

    test "encode_xdr/1", %{contract_id_contract_id: contract_id_contract_id, binary: binary} do
      {:ok, ^binary} = StructContractID.encode_xdr(contract_id_contract_id)
    end

    test "encode_xdr!/1", %{contract_id_contract_id: contract_id_contract_id, binary: binary} do
      ^binary = StructContractID.encode_xdr!(contract_id_contract_id)
    end

    test "decode_xdr/2", %{contract_id_contract_id: contract_id_contract_id, binary: binary} do
      {:ok, {^contract_id_contract_id, ""}} = StructContractID.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = StructContractID.decode_xdr(123)
    end

    test "decode_xdr!/2", %{contract_id_contract_id: contract_id_contract_id, binary: binary} do
      {^contract_id_contract_id, ""} = StructContractID.decode_xdr!(binary)
    end
  end
end
