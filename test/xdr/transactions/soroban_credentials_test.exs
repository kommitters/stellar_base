defmodule StellarBase.XDR.SorobanCredentialsTest do
  use ExUnit.Case

  alias StellarBase.XDR.{
    SorobanCredentials,
    SorobanCredentialsType,
    Void
  }

  describe "SorobanCredentials" do
    setup do
      value = Void.new()
      type = SorobanCredentialsType.new(:SOROBAN_CREDENTIALS_SOURCE_ACCOUNT)

      %{
        value: value,
        type: type,
        soroban_credentials: SorobanCredentials.new(value, type),
        binary: <<0, 0, 0, 0>>
      }
    end

    test "new/1", %{value: value, type: type} do
      %SorobanCredentials{
        value: ^value,
        type: ^type
      } = SorobanCredentials.new(value, type)
    end

    test "encode_xdr/1", %{
      soroban_credentials: soroban_credentials,
      binary: binary
    } do
      {:ok, ^binary} = SorobanCredentials.encode_xdr(soroban_credentials)
    end

    test "encode_xdr!/1", %{
      soroban_credentials: soroban_credentials,
      binary: binary
    } do
      ^binary = SorobanCredentials.encode_xdr!(soroban_credentials)
    end

    test "decode_xdr/2", %{
      soroban_credentials: soroban_credentials,
      binary: binary
    } do
      {:ok, {^soroban_credentials, ""}} = SorobanCredentials.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = SorobanCredentials.decode_xdr(123)
    end

    test "decode_xdr!/2", %{
      soroban_credentials: soroban_credentials,
      binary: binary
    } do
      {^soroban_credentials, ^binary} = SorobanCredentials.decode_xdr!(binary <> binary)
    end
  end
end
