defmodule StellarBase.XDR.SorobanCredentialsTypeTest do
  use ExUnit.Case

  alias StellarBase.XDR.SorobanCredentialsType

  describe "SorobanCredentialsType" do
    setup do
      %{
        identifier: :SOROBAN_CREDENTIALS_SOURCE_ACCOUNT,
        soroban_credentials_type: SorobanCredentialsType.new(:SOROBAN_CREDENTIALS_SOURCE_ACCOUNT),
        binary: <<0, 0, 0, 0>>
      }
    end

    test "new/1", %{identifier: type} do
      %SorobanCredentialsType{identifier: ^type} = SorobanCredentialsType.new(type)
    end

    test "new/1 with a default type" do
      %SorobanCredentialsType{identifier: :SOROBAN_CREDENTIALS_SOURCE_ACCOUNT} =
        SorobanCredentialsType.new()
    end

    test "encode_xdr/1", %{soroban_credentials_type: soroban_credentials_type, binary: binary} do
      {:ok, ^binary} = SorobanCredentialsType.encode_xdr(soroban_credentials_type)
    end

    test "encode_xdr/1 with an invalid identifier" do
      {:error, :invalid_key} =
        SorobanCredentialsType.encode_xdr(%SorobanCredentialsType{identifier: CREDENTIAL_TEST})
    end

    test "encode_xdr!/1", %{soroban)_credentials_type: soroban_credentials_type, binary: binary} do
      ^binary = SorobanCredentialsType.encode_xdr!(soroban_credentials_type)
    end

    test "decode_xdr/2", %{soroban_credentials_type: soroban_credentials_type, binary: binary} do
      {:ok, {^soroban_credentials_type, ""}} = SorobanCredentialsType.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid declaration" do
      {:error, :invalid_key} = SorobanCredentialsType.decode_xdr(<<1, 0, 0, 1>>)
    end

    test "decode_xdr!/2", %{soroban_credentials_type: soroban_credentials_type, binary: binary} do
      {^soroban_credentials_type, ^binary} = SorobanCredentialsType.decode_xdr!(binary <> binary)
    end
  end
end
