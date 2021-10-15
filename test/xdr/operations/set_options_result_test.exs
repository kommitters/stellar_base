defmodule Stellar.XDR.Operations.SetOptionsResultTest do
  use ExUnit.Case

  alias Stellar.XDR.Void
  alias Stellar.XDR.Operations.{SetOptionsResult, SetOptionsResultCode}

  describe "SetOptionsResult" do
    setup do
      code = SetOptionsResultCode.new(:SET_OPTIONS_SUCCESS)

      %{
        code: code,
        value: Void.new(),
        result: SetOptionsResult.new(Void.new(), code),
        binary: <<0, 0, 0, 0>>
      }
    end

    test "new/1", %{code: code, value: value} do
      %SetOptionsResult{code: ^code, result: ^value} = SetOptionsResult.new(value, code)
    end

    test "encode_xdr/1", %{result: result, binary: binary} do
      {:ok, ^binary} = SetOptionsResult.encode_xdr(result)
    end

    test "encode_xdr!/1", %{result: result, binary: binary} do
      ^binary = SetOptionsResult.encode_xdr!(result)
    end

    test "encode_xdr!/1 with a default value", %{code: code, binary: binary} do
      result = SetOptionsResult.new("TEST", code)
      ^binary = SetOptionsResult.encode_xdr!(result)
    end

    test "decode_xdr/2", %{result: result, binary: binary} do
      {:ok, {^result, ""}} = SetOptionsResult.decode_xdr(binary)
    end

    test "decode_xdr!/2", %{result: result, binary: binary} do
      {^result, ^binary} = SetOptionsResult.decode_xdr!(binary <> binary)
    end

    test "decode_xdr!/2 an error code" do
      {%SetOptionsResult{
         code: %SetOptionsResultCode{identifier: :SET_OPTIONS_TOO_MANY_SIGNERS}
       }, ""} = SetOptionsResult.decode_xdr!(<<255, 255, 255, 254>>)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = SetOptionsResult.decode_xdr(123)
    end
  end
end
