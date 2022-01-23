defmodule StellarBase.XDR.Operations.CreateAccountResultCodeTest do
  use ExUnit.Case

  alias StellarBase.XDR.Operations.CreateAccountResultCode

  @codes [
    :CREATE_ACCOUNT_SUCCESS,
    :CREATE_ACCOUNT_MALFORMED,
    :CREATE_ACCOUNT_UNDERFUNDED,
    :CREATE_ACCOUNT_LOW_RESERVE,
    :CREATE_ACCOUNT_ALREADY_EXIST
  ]

  describe "CreateAccountResultCode" do
    setup do
      %{
        codes: @codes,
        result: CreateAccountResultCode.new(:CREATE_ACCOUNT_SUCCESS),
        binary: <<0, 0, 0, 0>>
      }
    end

    test "new/1", %{codes: types} do
      for type <- types,
          do: %CreateAccountResultCode{identifier: ^type} = CreateAccountResultCode.new(type)
    end

    test "encode_xdr/1", %{result: result, binary: binary} do
      {:ok, ^binary} = CreateAccountResultCode.encode_xdr(result)
    end

    test "encode_xdr/1 with an invalid code" do
      {:error, :invalid_key} =
        CreateAccountResultCode.encode_xdr(%CreateAccountResultCode{identifier: :TEST})
    end

    test "encode_xdr!/1", %{result: result, binary: binary} do
      ^binary = CreateAccountResultCode.encode_xdr!(result)
    end

    test "decode_xdr/2", %{result: result, binary: binary} do
      {:ok, {^result, ""}} = CreateAccountResultCode.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid declaration" do
      {:error, :invalid_key} = CreateAccountResultCode.decode_xdr(<<1, 0, 0, 1>>)
    end

    test "decode_xdr!/2", %{result: result, binary: binary} do
      {^result, ^binary} = CreateAccountResultCode.decode_xdr!(binary <> binary)
    end

    test "decode_xdr!/2 with an error code" do
      {%CreateAccountResultCode{identifier: :CREATE_ACCOUNT_UNDERFUNDED}, ""} =
        CreateAccountResultCode.decode_xdr!(<<255, 255, 255, 254>>)
    end
  end
end
