defmodule StellarBase.XDR.InvokeHostFunctionResultTest do
  use ExUnit.Case

  alias StellarBase.XDR.{
    InvokeHostFunctionResult,
    Int64,
    InvokeHostFunctionResultCode,
    SCVal,
    SCValType,
    Void
  }

  describe "InvokeHostFunctionResult" do
    setup do
      invoke_host_function_result_success =
        InvokeHostFunctionResultCode.new(:INVOKE_HOST_FUNCTION_SUCCESS)

      invoke_host_function_result_malformed =
        InvokeHostFunctionResultCode.new(:INVOKE_HOST_FUNCTION_MALFORMED)

      invoke_host_function_result_trapped =
        InvokeHostFunctionResultCode.new(:INVOKE_HOST_FUNCTION_TRAPPED)

      void = Void.new()

      int_64 = Int64.new(3)
      scval_type = SCValType.new(:SCV_I64)
      scval = SCVal.new(int_64, scval_type)

      discriminants = [
        %{
          value: scval,
          invoke_host_function_result_code: invoke_host_function_result_success,
          invoke_host_function_result:
            InvokeHostFunctionResult.new(scval, invoke_host_function_result_success),
          binary: <<0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 3>>
        },
        %{
          value: void,
          invoke_host_function_result_code: invoke_host_function_result_malformed,
          invoke_host_function_result:
            InvokeHostFunctionResult.new(void, invoke_host_function_result_malformed),
          binary: <<255, 255, 255, 255>>
        },
        %{
          value: void,
          invoke_host_function_result_code: invoke_host_function_result_trapped,
          invoke_host_function_result:
            InvokeHostFunctionResult.new(void, invoke_host_function_result_trapped),
          binary: <<255, 255, 255, 254>>
        }
      ]

      %{discriminants: discriminants}
    end

    test "new/1", %{discriminants: discriminants} do
      for %{value: value, invoke_host_function_result_code: invoke_host_function_result_code} <-
            discriminants do
        %InvokeHostFunctionResult{value: ^value, type: ^invoke_host_function_result_code} =
          InvokeHostFunctionResult.new(value, invoke_host_function_result_code)
      end
    end

    test "encode_xdr/1", %{discriminants: discriminants} do
      for %{invoke_host_function_result: invoke_host_function_result, binary: binary} <-
            discriminants do
        {:ok, ^binary} = InvokeHostFunctionResult.encode_xdr(invoke_host_function_result)
      end
    end

    test "encode_xdr/1 with an invalid type" do
      invoke_host_function_result_code = InvokeHostFunctionResultCode.new(:INVALID_CODE)

      value = Void.new()

      assert_raise XDR.EnumError,
                   "The key which you try to encode doesn't belong to the current declarations",
                   fn ->
                     value
                     |> InvokeHostFunctionResult.new(invoke_host_function_result_code)
                     |> InvokeHostFunctionResult.encode_xdr()
                   end
    end

    test "encode_xdr!/1", %{discriminants: discriminants} do
      for %{invoke_host_function_result: invoke_host_function_result, binary: binary} <-
            discriminants do
        ^binary = InvokeHostFunctionResult.encode_xdr!(invoke_host_function_result)
      end
    end

    test "decode_xdr/2", %{discriminants: discriminants} do
      for %{invoke_host_function_result: invoke_host_function_result, binary: binary} <-
            discriminants do
        {:ok, {^invoke_host_function_result, ""}} = InvokeHostFunctionResult.decode_xdr(binary)
      end
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = InvokeHostFunctionResult.decode_xdr(123)
    end

    test "decode_xdr!/2", %{discriminants: discriminants} do
      for %{invoke_host_function_result: invoke_host_function_result, binary: binary} <-
            discriminants do
        {^invoke_host_function_result, ""} = InvokeHostFunctionResult.decode_xdr!(binary)
      end
    end
  end
end
