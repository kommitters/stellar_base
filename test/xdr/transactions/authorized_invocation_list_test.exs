defmodule StellarBase.XDR.AuthorizedInvocationListTest do
  use ExUnit.Case

  alias StellarBase.XDR.{
    AuthorizedInvocationList,
    AuthorizedInvocation,
    Hash,
    SCSymbol,
    SCVec,
    SCVal,
    SCValType,
    Int64
  }

  describe "AuthorizedInvocationList" do
    setup do
      contract_id = Hash.new("GCIZ3GSM5XL7OUS4UP64THMDZ7CZ3ZWN")
      function_name = SCSymbol.new("Hello")
      scval1 = SCVal.new(Int64.new(3), SCValType.new(:SCV_I64))
      scval2 = SCVal.new(Int64.new(2), SCValType.new(:SCV_I64))
      sc_vals = [scval1, scval2]
      args = SCVec.new(sc_vals)

      call_sub_invocation =
        AuthorizedInvocation.new(
          contract_id,
          function_name,
          args,
          AuthorizedInvocationList.new([])
        )

      sub_invocations =
        AuthorizedInvocationList.new([
          call_sub_invocation,
          call_sub_invocation,
          call_sub_invocation
        ])

      %{
        sub_invocations: sub_invocations,
        authorized_invocation_list: sub_invocations,
        binary:
          <<0, 0, 0, 3, 71, 67, 73, 90, 51, 71, 83, 77, 53, 88, 76, 55, 79, 85, 83, 52, 85, 80,
            54, 52, 84, 72, 77, 68, 90, 55, 67, 90, 51, 90, 87, 78, 0, 0, 0, 5, 72, 101, 108, 108,
            111, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 6, 0, 0, 0, 0,
            0, 0, 0, 2, 0, 0, 0, 0, 71, 67, 73, 90, 51, 71, 83, 77, 53, 88, 76, 55, 79, 85, 83,
            52, 85, 80, 54, 52, 84, 72, 77, 68, 90, 55, 67, 90, 51, 90, 87, 78, 0, 0, 0, 5, 72,
            101, 108, 108, 111, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0,
            6, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 71, 67, 73, 90, 51, 71, 83, 77, 53, 88, 76, 55,
            79, 85, 83, 52, 85, 80, 54, 52, 84, 72, 77, 68, 90, 55, 67, 90, 51, 90, 87, 78, 0, 0,
            0, 5, 72, 101, 108, 108, 111, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 3,
            0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0>>
      }
    end

    test "new/1", %{sub_invocations: sub_invocations} do
      %AuthorizedInvocationList{sub_invocations: ^sub_invocations} =
        AuthorizedInvocationList.new(sub_invocations)
    end

    test "encode_xdr/1", %{
      authorized_invocation_list: authorized_invocation_list,
      binary: binary
    } do
      {:ok, ^binary} = AuthorizedInvocationList.encode_xdr(authorized_invocation_list)
    end

    test "encode_xdr!/1", %{
      authorized_invocation_list: authorized_invocation_list,
      binary: binary
    } do
      ^binary = AuthorizedInvocationList.encode_xdr!(authorized_invocation_list)
    end

    test "decode_xdr/1", %{
      authorized_invocation_list: authorized_invocation_list,
      binary: binary
    } do
      {:ok, {^authorized_invocation_list, ""}} = AuthorizedInvocationList.decode_xdr(binary)
    end

    test "decode_xdr/1 with an invalid binary" do
      {:error, :not_binary} = AuthorizedInvocationList.decode_xdr(123)
    end

    test "decode_xdr!/1", %{
      authorized_invocation_list: authorized_invocation_list,
      binary: binary
    } do
      {^authorized_invocation_list, ""} = AuthorizedInvocationList.decode_xdr!(binary)
    end

    test "decode_xdr!/1 with an invalid binary" do
      assert_raise XDR.VariableArrayError,
                   "The value which you pass through parameters must be a binary value, for example: <<0, 0, 0, 5>>",
                   fn -> AuthorizedInvocationList.decode_xdr!(123) end
    end
  end
end
