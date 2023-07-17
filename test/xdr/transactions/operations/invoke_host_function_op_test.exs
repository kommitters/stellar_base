defmodule StellarBase.XDR.InvokeHostFunctionTest do
  use ExUnit.Case

  alias StellarBase.XDR.{
    SCVal,
    SCValType,
    SCVec,
    InvokeHostFunctionOp,
    Int64,
    HostFunction,
    HostFunctionType,
    Hash,
    SCAddress,
    SCAddressType,
    SCSymbol,
    SorobanAuthorizedContractFunction,
    SorobanAuthorizationEntryList,
    SorobanAuthorizationEntry,
    SorobanAuthorizedFunction,
    SorobanAuthorizedFunctionType,
    SorobanAuthorizedInvocation,
    SorobanAuthorizedInvocationList,
    SorobanCredentials,
    SorobanCredentialsType,
    Void
  }

  describe "InvokeHostFunctionOp" do
    setup do
      ## HostFunction
      scval1 = SCVal.new(Int64.new(3), SCValType.new(:SCV_I64))
      scval2 = SCVal.new(Int64.new(2), SCValType.new(:SCV_I64))
      sc_vals = [scval1, scval2]
      args = SCVec.new(sc_vals)

      function_name = SCSymbol.new("Hello")

      sc_address =
        "CAWIIZPXNRY7X3FKFO4CWJT5DQOSEXQK"
        |> Hash.new()
        |> SCAddress.new(SCAddressType.new(:SC_ADDRESS_TYPE_CONTRACT))

      contract_function = SorobanAuthorizedContractFunction.new(sc_address, function_name, args)

      auth_function =
        SorobanAuthorizedFunction.new(contract_function, SorobanAuthorizedFunctionType.new())

      host_function = HostFunction.new(args, HostFunctionType.new())

      invocation =
        SorobanAuthorizedInvocation.new(auth_function, SorobanAuthorizedInvocationList.new([]))

      credentials = SorobanCredentials.new(Void.new(), SorobanCredentialsType.new())
      entry = SorobanAuthorizationEntry.new(credentials, invocation)
      auth = SorobanAuthorizationEntryList.new([entry])

      %{
        host_function: host_function,
        auth: auth,
        invoke_host_function_op: InvokeHostFunctionOp.new(host_function, auth),
        binary:
          <<0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 6, 0, 0, 0, 0, 0,
            0, 0, 2, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 67, 65, 87, 73, 73, 90, 80,
            88, 78, 82, 89, 55, 88, 51, 70, 75, 70, 79, 52, 67, 87, 74, 84, 53, 68, 81, 79, 83,
            69, 88, 81, 75, 0, 0, 0, 5, 72, 101, 108, 108, 111, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 6,
            0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0>>
      }
    end

    test "new/1", %{host_function: host_function, auth: auth} do
      %InvokeHostFunctionOp{host_function: ^host_function, auth: ^auth} =
        InvokeHostFunctionOp.new(host_function, auth)
    end

    test "encode_xdr/1", %{
      invoke_host_function_op: invoke_host_function_op,
      binary: binary
    } do
      {:ok, ^binary} = InvokeHostFunctionOp.encode_xdr(invoke_host_function_op)
    end

    test "encode_xdr!/1", %{
      invoke_host_function_op: invoke_host_function_op,
      binary: binary
    } do
      ^binary = InvokeHostFunctionOp.encode_xdr!(invoke_host_function_op)
    end

    test "decode_xdr/2", %{
      invoke_host_function_op: invoke_host_function_op,
      binary: binary
    } do
      {:ok, {^invoke_host_function_op, ""}} = InvokeHostFunctionOp.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = InvokeHostFunctionOp.decode_xdr(123)
    end

    test "decode_xdr!/2", %{
      invoke_host_function_op: invoke_host_function_op,
      binary: binary
    } do
      {^invoke_host_function_op, ^binary} = InvokeHostFunctionOp.decode_xdr!(binary <> binary)
    end
  end
end
