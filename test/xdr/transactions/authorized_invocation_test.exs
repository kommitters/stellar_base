defmodule StellarBase.XDR.AuthorizedInvocationTest do
  use ExUnit.Case

  alias StellarBase.XDR.{
    AuthorizedInvocation,
    AuthorizedInvocationList,
    Hash,
    SCSymbol,
    SCVec,
    SCVal,
    SCValType,
    Int64
  }

  describe "AuthorizedInvocation" do
    setup do
      contract_id = Hash.new("GCIZ3GSM5XL7OUS4UP64THMDZ7CZ3ZWN")
      function_name = SCSymbol.new("Hello")
      scval1 = SCVal.new(Int64.new(3), SCValType.new(:SCV_U63))
      scval2 = SCVal.new(Int64.new(2), SCValType.new(:SCV_U63))
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

      %{
        contract_id: contract_id,
        function_name: function_name,
        args: args,
        sub_invocations: sub_invocations,
        authorized_invocation:
          AuthorizedInvocation.new(contract_id, function_name, args, sub_invocations),
        binary:
          <<71, 67, 73, 90, 51, 71, 83, 77, 53, 88, 76, 55, 79, 85, 83, 52, 85, 80, 54, 52, 84,
            72, 77, 68, 90, 55, 67, 90, 51, 90, 87, 78, 0, 0, 0, 5, 72, 101, 108, 108, 111, 0, 0,
            0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2,
            0, 0, 0, 3, 71, 67, 73, 90, 51, 71, 83, 77, 53, 88, 76, 55, 79, 85, 83, 52, 85, 80,
            54, 52, 84, 72, 77, 68, 90, 55, 67, 90, 51, 90, 87, 78, 0, 0, 0, 5, 72, 101, 108, 108,
            111, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 2, 0, 0, 0, 0, 71, 67, 73, 90, 51, 71, 83, 77, 53, 88, 76, 55, 79, 85, 83,
            52, 85, 80, 54, 52, 84, 72, 77, 68, 90, 55, 67, 90, 51, 90, 87, 78, 0, 0, 0, 5, 72,
            101, 108, 108, 111, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 71, 67, 73, 90, 51, 71, 83, 77, 53, 88, 76, 55,
            79, 85, 83, 52, 85, 80, 54, 52, 84, 72, 77, 68, 90, 55, 67, 90, 51, 90, 87, 78, 0, 0,
            0, 5, 72, 101, 108, 108, 111, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0>>
      }
    end

    test "new/1", %{
      contract_id: contract_id,
      function_name: function_name,
      args: args,
      sub_invocations: sub_invocations
    } do
      %AuthorizedInvocation{
        contract_id: ^contract_id,
        function_name: ^function_name,
        args: ^args,
        sub_invocations: ^sub_invocations
      } = AuthorizedInvocation.new(contract_id, function_name, args, sub_invocations)
    end

    test "encode_xdr/1", %{
      authorized_invocation: authorized_invocation,
      binary: binary
    } do
      {:ok, ^binary} = AuthorizedInvocation.encode_xdr(authorized_invocation)
    end

    test "encode_xdr!/1", %{
      authorized_invocation: authorized_invocation,
      binary: binary
    } do
      ^binary = AuthorizedInvocation.encode_xdr!(authorized_invocation)
    end

    test "decode_xdr/2", %{
      authorized_invocation: authorized_invocation,
      binary: binary
    } do
      {:ok, {^authorized_invocation, ""}} = AuthorizedInvocation.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = AuthorizedInvocation.decode_xdr(123)
    end

    test "decode_xdr!/2", %{
      authorized_invocation: authorized_invocation,
      binary: binary
    } do
      {^authorized_invocation, ^binary} = AuthorizedInvocation.decode_xdr!(binary <> binary)
    end
  end
end
