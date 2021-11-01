defmodule Stellar.XDR.Operations.ManageDataResultCodeTest do
  use ExUnit.Case

  alias Stellar.XDR.Operations.ManageDataResultCode

  describe "ManageDataResultCode" do
    setup do
      %{
        code: :MANAGE_DATA_SUCCESS,
        result: ManageDataResultCode.new(:MANAGE_DATA_SUCCESS),
        binary: <<0, 0, 0, 0>>
      }
    end

    test "new/1", %{code: type} do
      %ManageDataResultCode{identifier: ^type} = ManageDataResultCode.new(type)
    end

    test "encode_xdr/1", %{result: result, binary: binary} do
      {:ok, ^binary} = ManageDataResultCode.encode_xdr(result)
    end

    test "encode_xdr/1 with an invalid code" do
      {:error, :invalid_key} =
        ManageDataResultCode.encode_xdr(%ManageDataResultCode{identifier: :TEST})
    end

    test "encode_xdr!/1", %{result: result, binary: binary} do
      ^binary = ManageDataResultCode.encode_xdr!(result)
    end

    test "decode_xdr/2", %{result: result, binary: binary} do
      {:ok, {^result, ""}} = ManageDataResultCode.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid declaration" do
      {:error, :invalid_key} = ManageDataResultCode.decode_xdr(<<1, 0, 0, 1>>)
    end

    test "decode_xdr!/2", %{result: result, binary: binary} do
      {^result, ^binary} = ManageDataResultCode.decode_xdr!(binary <> binary)
    end

    test "decode_xdr!/2 with an error code" do
      {%ManageDataResultCode{identifier: :MANAGE_DATA_NAME_NOT_FOUND}, ""} =
        ManageDataResultCode.decode_xdr!(<<255, 255, 255, 254>>)
    end
  end
end
