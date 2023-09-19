defmodule StellarBase.XDR.HashIDPreimageSorobanAuthorizationTest do
  use ExUnit.Case

  alias StellarBase.XDR.{
    HashIDPreimageSorobanAuthorization,
    Hash,
    Int64,
    UInt32,
    SCAddress,
    SCAddressType,
    SCSymbol,
    SCVal,
    SCValType,
    SCValList,
    InvokeContractArgs,
    SorobanAuthorizedFunction,
    SorobanAuthorizedFunctionType,
    SorobanAuthorizedInvocation,
    SorobanAuthorizedInvocationList
  }

  describe "HashIDPreimageSorobanAuthorization" do
    setup do
      network_id = Hash.new("GCIZ3GSM5XL7OUS4UP64THMDZ7CZ3ZWN")

      nonce = Int64.new(9_223_372_036_854_775_806)
      signature_expiration_ledger = UInt32.new(123_154)
      function_name = SCSymbol.new("Hello")
      scval1 = SCVal.new(Int64.new(3), SCValType.new(:SCV_I64))
      scval2 = SCVal.new(Int64.new(2), SCValType.new(:SCV_I64))
      sc_vals = [scval1, scval2]
      args = SCValList.new(sc_vals)

      address = Hash.new("CAWIIZPXNRY7X3FKFO4CWJT5DQOSEXQK")
      sc_address = SCAddress.new(address, SCAddressType.new(:SC_ADDRESS_TYPE_CONTRACT))

      contract_function = InvokeContractArgs.new(sc_address, function_name, args)

      auth_function =
        SorobanAuthorizedFunction.new(contract_function, SorobanAuthorizedFunctionType.new())

      auth_sub_invocation =
        contract_function
        |> SorobanAuthorizedFunction.new(SorobanAuthorizedFunctionType.new())
        |> SorobanAuthorizedInvocation.new(SorobanAuthorizedInvocationList.new([]))

      sub_invocations =
        SorobanAuthorizedInvocationList.new([
          auth_sub_invocation,
          auth_sub_invocation
        ])

      invocation = SorobanAuthorizedInvocation.new(auth_function, sub_invocations)

      %{
        network_id: network_id,
        nonce: nonce,
        invocation: invocation,
        signature_expiration_ledger: signature_expiration_ledger,
        hash_id_preimage_contract_auth:
          HashIDPreimageSorobanAuthorization.new(
            network_id,
            nonce,
            signature_expiration_ledger,
            invocation
          ),
        binary:
          <<71, 67, 73, 90, 51, 71, 83, 77, 53, 88, 76, 55, 79, 85, 83, 52, 85, 80, 54, 52, 84,
            72, 77, 68, 90, 55, 67, 90, 51, 90, 87, 78, 127, 255, 255, 255, 255, 255, 255, 254, 0,
            1, 225, 18, 0, 0, 0, 0, 0, 0, 0, 1, 67, 65, 87, 73, 73, 90, 80, 88, 78, 82, 89, 55,
            88, 51, 70, 75, 70, 79, 52, 67, 87, 74, 84, 53, 68, 81, 79, 83, 69, 88, 81, 75, 0, 0,
            0, 5, 72, 101, 108, 108, 111, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 3,
            0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 1, 67, 65, 87,
            73, 73, 90, 80, 88, 78, 82, 89, 55, 88, 51, 70, 75, 70, 79, 52, 67, 87, 74, 84, 53,
            68, 81, 79, 83, 69, 88, 81, 75, 0, 0, 0, 5, 72, 101, 108, 108, 111, 0, 0, 0, 0, 0, 0,
            2, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 1, 67, 65, 87, 73, 73, 90, 80, 88, 78, 82, 89, 55, 88, 51, 70,
            75, 70, 79, 52, 67, 87, 74, 84, 53, 68, 81, 79, 83, 69, 88, 81, 75, 0, 0, 0, 5, 72,
            101, 108, 108, 111, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0,
            6, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0>>
      }
    end

    test "new/1", %{
      network_id: network_id,
      nonce: nonce,
      signature_expiration_ledger: signature_expiration_ledger,
      invocation: invocation
    } do
      %HashIDPreimageSorobanAuthorization{
        network_id: ^network_id,
        nonce: ^nonce,
        signature_expiration_ledger: ^signature_expiration_ledger,
        invocation: ^invocation
      } =
        HashIDPreimageSorobanAuthorization.new(
          network_id,
          nonce,
          signature_expiration_ledger,
          invocation
        )
    end

    test "encode_xdr/1", %{
      hash_id_preimage_contract_auth: hash_id_preimage_contract_auth,
      binary: binary
    } do
      {:ok, ^binary} =
        HashIDPreimageSorobanAuthorization.encode_xdr(hash_id_preimage_contract_auth)
    end

    test "encode_xdr!/1", %{
      hash_id_preimage_contract_auth: hash_id_preimage_contract_auth,
      binary: binary
    } do
      ^binary = HashIDPreimageSorobanAuthorization.encode_xdr!(hash_id_preimage_contract_auth)
    end

    test "decode_xdr/2", %{
      hash_id_preimage_contract_auth: hash_id_preimage_contract_auth,
      binary: binary
    } do
      {:ok, {^hash_id_preimage_contract_auth, ""}} =
        HashIDPreimageSorobanAuthorization.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = HashIDPreimageSorobanAuthorization.decode_xdr(123)
    end

    test "decode_xdr!/2", %{
      hash_id_preimage_contract_auth: hash_id_preimage_contract_auth,
      binary: binary
    } do
      {^hash_id_preimage_contract_auth, ""} =
        HashIDPreimageSorobanAuthorization.decode_xdr!(binary)
    end
  end
end
