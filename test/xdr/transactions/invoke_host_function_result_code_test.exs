defmodule StellarBase.XDR.InvokeHostFunctionResultCodeTest do
  use ExUnit.Case

  alias StellarBase.XDR.InvokeHostFunctionResultCode

  describe "InvokeHostFunctionResultCode" do
    setup do
      discriminants = [
        %{
          identifier: :INVOKE_HOST_FUNCTION_SUCCESS,
          invoke_host_function_result_code:
            InvokeHostFunctionResultCode.new(:INVOKE_HOST_FUNCTION_SUCCESS),
          binary: <<0, 0, 0, 0>>
        },
        %{
          identifier: :INVOKE_HOST_FUNCTION_MALFORMED,
          invoke_host_function_result_code:
            InvokeHostFunctionResultCode.new(:INVOKE_HOST_FUNCTION_MALFORMED),
          binary: <<255, 255, 255, 255>>
        },
        %{
          identifier: :INVOKE_HOST_FUNCTION_TRAPPED,
          invoke_host_function_result_code:
            InvokeHostFunctionResultCode.new(:INVOKE_HOST_FUNCTION_TRAPPED),
          binary: <<255, 255, 255, 254>>
        }
      ]

      %{discriminants: discriminants}
    end

    test "new/1", %{discriminants: discriminants} do
      for %{identifier: identifier} <- discriminants do
        %InvokeHostFunctionResultCode{identifier: ^identifier} =
          InvokeHostFunctionResultCode.new(identifier)
      end
    end

    test "new/1 with a default type" do
      %InvokeHostFunctionResultCode{identifier: :INVOKE_HOST_FUNCTION_SUCCESS} =
        InvokeHostFunctionResultCode.new()
    end

    test "encode_xdr/1", %{discriminants: discriminants} do
      for %{invoke_host_function_result_code: invoke_host_function_result_code, binary: binary} <-
            discriminants do
        {:ok, ^binary} = InvokeHostFunctionResultCode.encode_xdr(invoke_host_function_result_code)
      end
    end

    test "encode_xdr/1 with an invalid identifier" do
      {:error, :invalid_key} =
        InvokeHostFunctionResultCode.encode_xdr(%InvokeHostFunctionResultCode{
          identifier: MEMO_TEST
        })
    end

    test "encode_xdr!/1", %{discriminants: discriminants} do
      for %{invoke_host_function_result_code: invoke_host_function_result_code, binary: binary} <-
            discriminants do
        ^binary = InvokeHostFunctionResultCode.encode_xdr!(invoke_host_function_result_code)
      end
    end

    test "decode_xdr/2", %{discriminants: discriminants} do
      for %{invoke_host_function_result_code: invoke_host_function_result_code, binary: binary} <-
            discriminants do
        {:ok, {^invoke_host_function_result_code, ""}} =
          InvokeHostFunctionResultCode.decode_xdr(binary)
      end
    end

    test "decode_xdr/2 with an invalid declaration" do
      {:error, :invalid_key} = InvokeHostFunctionResultCode.decode_xdr(<<1, 0, 0, 1>>)
    end

    test "decode_xdr!/2", %{discriminants: discriminants} do
      for %{invoke_host_function_result_code: invoke_host_function_result_code, binary: binary} <-
            discriminants do
        {^invoke_host_function_result_code, ^binary} =
          InvokeHostFunctionResultCode.decode_xdr!(binary <> binary)
      end
    end
  end
end
