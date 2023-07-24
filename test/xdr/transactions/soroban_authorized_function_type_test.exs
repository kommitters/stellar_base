defmodule StellarBase.XDR.SorobanAuthorizedFunctionTypeTest do
  use ExUnit.Case

  alias StellarBase.XDR.SorobanAuthorizedFunctionType

  describe "SorobanAuthorizedFunctionType" do
    setup do
      %{
        identifier: :SOROBAN_AUTHORIZED_FUNCTION_TYPE_CONTRACT_FN,
        soroban_credentials_type:
          SorobanAuthorizedFunctionType.new(:SOROBAN_AUTHORIZED_FUNCTION_TYPE_CONTRACT_FN),
        binary: <<0, 0, 0, 0>>
      }
    end

    test "new/1", %{identifier: type} do
      %SorobanAuthorizedFunctionType{identifier: ^type} = SorobanAuthorizedFunctionType.new(type)
    end

    test "new/1 with a default type" do
      %SorobanAuthorizedFunctionType{identifier: :SOROBAN_AUTHORIZED_FUNCTION_TYPE_CONTRACT_FN} =
        SorobanAuthorizedFunctionType.new()
    end

    test "encode_xdr/1", %{soroban_credentials_type: soroban_credentials_type, binary: binary} do
      {:ok, ^binary} = SorobanAuthorizedFunctionType.encode_xdr(soroban_credentials_type)
    end

    test "encode_xdr/1 with an invalid identifier" do
      {:error, :invalid_key} =
        SorobanAuthorizedFunctionType.encode_xdr(%SorobanAuthorizedFunctionType{
          identifier: TEST
        })
    end

    test "encode_xdr!/1", %{soroban_credentials_type: soroban_credentials_type, binary: binary} do
      ^binary = SorobanAuthorizedFunctionType.encode_xdr!(soroban_credentials_type)
    end

    test "decode_xdr/2", %{soroban_credentials_type: soroban_credentials_type, binary: binary} do
      {:ok, {^soroban_credentials_type, ""}} = SorobanAuthorizedFunctionType.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid declaration" do
      {:error, :invalid_key} = SorobanAuthorizedFunctionType.decode_xdr(<<1, 0, 0, 1>>)
    end

    test "decode_xdr!/2", %{soroban_credentials_type: soroban_credentials_type, binary: binary} do
      {^soroban_credentials_type, ^binary} =
        SorobanAuthorizedFunctionType.decode_xdr!(binary <> binary)
    end
  end
end
