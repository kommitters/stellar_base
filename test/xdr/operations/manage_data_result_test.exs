defmodule Stellar.XDR.Operations.ManageDataResultTest do
  use ExUnit.Case

  alias Stellar.XDR.Void
  alias Stellar.XDR.Operations.{ManageDataResult, ManageDataResultCode}

  describe "ManageDataResult" do
    setup do
      code = ManageDataResultCode.new(:MANAGE_DATA_SUCCESS)

      %{
        code: code,
        value: Void.new(),
        result: ManageDataResult.new(Void.new(), code),
        binary: <<0, 0, 0, 0>>
      }
    end

    test "new/1", %{code: code, value: value} do
      %ManageDataResult{code: ^code, result: ^value} = ManageDataResult.new(value, code)
    end

    test "encode_xdr/1", %{result: result, binary: binary} do
      {:ok, ^binary} = ManageDataResult.encode_xdr(result)
    end

    test "encode_xdr!/1", %{result: result, binary: binary} do
      ^binary = ManageDataResult.encode_xdr!(result)
    end

    test "encode_xdr!/1 with a default value", %{code: code, binary: binary} do
      result = ManageDataResult.new("TEST", code)
      ^binary = ManageDataResult.encode_xdr!(result)
    end

    test "decode_xdr/2", %{result: result, binary: binary} do
      {:ok, {^result, ""}} = ManageDataResult.decode_xdr(binary)
    end

    test "decode_xdr!/2", %{result: result, binary: binary} do
      {^result, ^binary} = ManageDataResult.decode_xdr!(binary <> binary)
    end

    test "decode_xdr!/2 an error code" do
      {%ManageDataResult{
         code: %ManageDataResultCode{identifier: :MANAGE_DATA_NAME_NOT_FOUND}
       }, ""} = ManageDataResult.decode_xdr!(<<255, 255, 255, 254>>)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = ManageDataResult.decode_xdr(123)
    end
  end
end
