defmodule StellarBase.XDR.CreateAccountResultTest do
  use ExUnit.Case

  alias StellarBase.XDR.Void
  alias StellarBase.XDR.{CreateAccountResult, CreateAccountResultCode}

  describe "CreateAccountResult" do
    setup do
      code = CreateAccountResultCode.new(:CREATE_ACCOUNT_SUCCESS)

      %{
        code: code,
        value: Void.new(),
        result: CreateAccountResult.new(Void.new(), code),
        binary: <<0, 0, 0, 0>>
      }
    end

    test "new/1", %{code: code, value: value} do
      %CreateAccountResult{value: ^value, type: ^code} = CreateAccountResult.new(value, code)
    end

    test "encode_xdr/1", %{result: result, binary: binary} do
      {:ok, ^binary} = CreateAccountResult.encode_xdr(result)
    end

    test "encode_xdr!/1", %{result: result, binary: binary} do
      ^binary = CreateAccountResult.encode_xdr!(result)
    end

    test "encode_xdr!/1 with a default value", %{code: code, binary: binary} do
      result = CreateAccountResult.new("TEST", code)
      ^binary = CreateAccountResult.encode_xdr!(result)
    end

    test "decode_xdr/2", %{result: result, binary: binary} do
      {:ok, {^result, ""}} = CreateAccountResult.decode_xdr(binary)
    end

    test "decode_xdr!/2", %{result: result, binary: binary} do
      {^result, ^binary} = CreateAccountResult.decode_xdr!(binary <> binary)
    end

    test "decode_xdr!/2 an error code" do
      {%CreateAccountResult{
          value: %Void{value: nil},
         type: %CreateAccountResultCode{identifier: :CREATE_ACCOUNT_UNDERFUNDED}
       }, ""} = CreateAccountResult.decode_xdr!(<<255, 255, 255, 254>>)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = CreateAccountResult.decode_xdr(123)
    end
  end
end
