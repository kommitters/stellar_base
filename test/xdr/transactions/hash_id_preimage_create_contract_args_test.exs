defmodule StellarBase.XDR.HashIDPreimageCreateContractArgsTest do
  use ExUnit.Case

  alias StellarBase.XDR.{
    HashIDPreimageCreateContractArgs,
    Hash,
    UInt256,
    SCContractExecutable,
    SCContractExecutableType
  }

  describe "HashIDPreimageCreateContractArgs" do
    setup do
      network_id = Hash.new("GCIZ3GSM5XL7OUS4UP64THMDZ7CZ3ZWN")

      contract_executable = Hash.new("GCIZ3GSM5XL7OUS4UP64THMDZ7CZ3ZWK")
      sc_contract_executable_type = SCContractExecutableType.new(:SCCONTRACT_EXECUTABLE_WASM_REF)
      executable = SCContractExecutable.new(contract_executable, sc_contract_executable_type)

      salt =
        UInt256.new(
          <<72, 101, 108, 108, 111, 32, 119, 111, 114, 108, 100, 0, 21, 0, 1, 0, 72, 101, 108,
            108, 111, 32, 119, 111, 114, 108, 100, 0, 21, 0, 1, 0>>
        )

      %{
        network_id: network_id,
        executable: executable,
        salt: salt,
        hash_id_preimage_create_contract_args:
          HashIDPreimageCreateContractArgs.new(network_id, executable, salt),
        binary:
          <<71, 67, 73, 90, 51, 71, 83, 77, 53, 88, 76, 55, 79, 85, 83, 52, 85, 80, 54, 52, 84,
            72, 77, 68, 90, 55, 67, 90, 51, 90, 87, 78, 0, 0, 0, 0, 71, 67, 73, 90, 51, 71, 83,
            77, 53, 88, 76, 55, 79, 85, 83, 52, 85, 80, 54, 52, 84, 72, 77, 68, 90, 55, 67, 90,
            51, 90, 87, 75, 72, 101, 108, 108, 111, 32, 119, 111, 114, 108, 100, 0, 21, 0, 1, 0,
            72, 101, 108, 108, 111, 32, 119, 111, 114, 108, 100, 0, 21, 0, 1, 0>>
      }
    end

    test "new/1", %{
      network_id: network_id,
      executable: executable,
      salt: salt
    } do
      %HashIDPreimageCreateContractArgs{
        network_id: ^network_id,
        executable: ^executable,
        salt: ^salt
      } = HashIDPreimageCreateContractArgs.new(network_id, executable, salt)
    end

    test "encode_xdr/1", %{
      hash_id_preimage_create_contract_args: hash_id_preimage_create_contract_args,
      binary: binary
    } do
      {:ok, ^binary} =
        HashIDPreimageCreateContractArgs.encode_xdr(hash_id_preimage_create_contract_args)
    end

    test "encode_xdr!/1", %{
      hash_id_preimage_create_contract_args: hash_id_preimage_create_contract_args,
      binary: binary
    } do
      ^binary =
        HashIDPreimageCreateContractArgs.encode_xdr!(hash_id_preimage_create_contract_args)
    end

    test "decode_xdr/2", %{
      hash_id_preimage_create_contract_args: hash_id_preimage_create_contract_args,
      binary: binary
    } do
      {:ok, {^hash_id_preimage_create_contract_args, ""}} =
        HashIDPreimageCreateContractArgs.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = HashIDPreimageCreateContractArgs.decode_xdr(123)
    end

    test "decode_xdr!/2", %{
      hash_id_preimage_create_contract_args: hash_id_preimage_create_contract_args,
      binary: binary
    } do
      {^hash_id_preimage_create_contract_args, ""} =
        HashIDPreimageCreateContractArgs.decode_xdr!(binary)
    end
  end
end
