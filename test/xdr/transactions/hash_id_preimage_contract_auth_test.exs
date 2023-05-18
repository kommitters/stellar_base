defmodule StellarBase.XDR.HashIDPreimageContractAuthTest do
  use ExUnit.Case

  alias StellarBase.XDR.{
    HashIDPreimageContractAuth,
    Hash,
    Uint64,
    AuthorizedInvocation,
    AuthorizedInvocationList,
    SCSymbol,
    SCVal,
    SCValType,
    SCVec,
    Int64
  }

  describe "HashIDPreimageContractAuth" do
    setup do
      network_id = Hash.new("GCIZ3GSM5XL7OUS4UP64THMDZ7CZ3ZWN")

      nonce = Uint64.new(18_446_744_073_709_551_615)

      contract_id = Hash.new("GCIZ3GSM5XL7OUS4UP64THMDZ7CZ3ZWK")
      function_name = SCSymbol.new("Hello")
      scval1 = SCVal.new(Int64.new(3), SCValType.new(:SCV_I64))
      scval2 = SCVal.new(Int64.new(2), SCValType.new(:SCV_I64))
      sc_vals = [scval1, scval2]
      args = SCVec.new(sc_vals)

      auth_sub_invocation =
        AuthorizedInvocation.new(
          contract_id,
          function_name,
          args,
          AuthorizedInvocationList.new([])
        )

      sub_invocations =
        AuthorizedInvocationList.new([
          auth_sub_invocation,
          auth_sub_invocation,
          auth_sub_invocation
        ])

      invocation = AuthorizedInvocation.new(contract_id, function_name, args, sub_invocations)

      %{
        network_id: network_id,
        nonce: nonce,
        invocation: invocation,
        hash_id_preimage_contract_auth:
          HashIDPreimageContractAuth.new(network_id, nonce, invocation),
        binary:
          <<71, 67, 73, 90, 51, 71, 83, 77, 53, 88, 76, 55, 79, 85, 83, 52, 85, 80, 54, 52, 84,
            72, 77, 68, 90, 55, 67, 90, 51, 90, 87, 78, 255, 255, 255, 255, 255, 255, 255, 255,
            71, 67, 73, 90, 51, 71, 83, 77, 53, 88, 76, 55, 79, 85, 83, 52, 85, 80, 54, 52, 84,
            72, 77, 68, 90, 55, 67, 90, 51, 90, 87, 75, 0, 0, 0, 5, 72, 101, 108, 108, 111, 0, 0,
            0, 0, 0, 0, 2, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 2,
            0, 0, 0, 3, 71, 67, 73, 90, 51, 71, 83, 77, 53, 88, 76, 55, 79, 85, 83, 52, 85, 80,
            54, 52, 84, 72, 77, 68, 90, 55, 67, 90, 51, 90, 87, 75, 0, 0, 0, 5, 72, 101, 108, 108,
            111, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 6, 0, 0, 0, 0,
            0, 0, 0, 2, 0, 0, 0, 0, 71, 67, 73, 90, 51, 71, 83, 77, 53, 88, 76, 55, 79, 85, 83,
            52, 85, 80, 54, 52, 84, 72, 77, 68, 90, 55, 67, 90, 51, 90, 87, 75, 0, 0, 0, 5, 72,
            101, 108, 108, 111, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0,
            6, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 71, 67, 73, 90, 51, 71, 83, 77, 53, 88, 76, 55,
            79, 85, 83, 52, 85, 80, 54, 52, 84, 72, 77, 68, 90, 55, 67, 90, 51, 90, 87, 75, 0, 0,
            0, 5, 72, 101, 108, 108, 111, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 3,
            0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0>>
      }
    end

    test "new/1", %{
      network_id: network_id,
      nonce: nonce,
      invocation: invocation
    } do
      %HashIDPreimageContractAuth{
        network_id: ^network_id,
        nonce: ^nonce,
        invocation: ^invocation
      } = HashIDPreimageContractAuth.new(network_id, nonce, invocation)
    end

    test "encode_xdr/1", %{
      hash_id_preimage_contract_auth: hash_id_preimage_contract_auth,
      binary: binary
    } do
      {:ok, ^binary} = HashIDPreimageContractAuth.encode_xdr(hash_id_preimage_contract_auth)
    end

    test "encode_xdr!/1", %{
      hash_id_preimage_contract_auth: hash_id_preimage_contract_auth,
      binary: binary
    } do
      ^binary = HashIDPreimageContractAuth.encode_xdr!(hash_id_preimage_contract_auth)
    end

    test "decode_xdr/2", %{
      hash_id_preimage_contract_auth: hash_id_preimage_contract_auth,
      binary: binary
    } do
      {:ok, {^hash_id_preimage_contract_auth, ""}} = HashIDPreimageContractAuth.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = HashIDPreimageContractAuth.decode_xdr(123)
    end

    test "decode_xdr!/2", %{
      hash_id_preimage_contract_auth: hash_id_preimage_contract_auth,
      binary: binary
    } do
      {^hash_id_preimage_contract_auth, ""} = HashIDPreimageContractAuth.decode_xdr!(binary)
    end
  end
end
