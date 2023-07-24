defmodule StellarBase.XDR.SorobanAuthorizationEntryTest do
  use ExUnit.Case

  alias StellarBase.XDR.{
    AccountID,
    Int64,
    PublicKey,
    PublicKeyType,
    SCAddress,
    SCAddressType,
    SCAddress,
    SCSymbol,
    SCVal,
    SCValType,
    SCVec,
    SorobanAuthorizedInvocation,
    SorobanAuthorizedInvocationList,
    SorobanAuthorizationEntry,
    SorobanAuthorizedFunction,
    SorobanAuthorizedFunctionType,
    SorobanAuthorizedContractFunction,
    SorobanCredentials,
    SorobanCredentialsType,
    UInt256,
    Void
  }

  alias StellarBase.StrKey

  describe "SorobanAuthorizationEntry" do
    setup do
      pk_type = PublicKeyType.new(:PUBLIC_KEY_TYPE_ED25519)

      account_id =
        "GBZNLMUQMIN3VGUJISKZU7GNY3O3XLMYEHJCKCSMDHKLGSMKALRXOEZD"
        |> StrKey.decode!(:ed25519_public_key)
        |> UInt256.new()
        |> PublicKey.new(pk_type)
        |> AccountID.new()

      sc_address_type = SCAddressType.new(:SC_ADDRESS_TYPE_ACCOUNT)

      contract_address = SCAddress.new(account_id, sc_address_type)
      function_name = SCSymbol.new("Hello")
      scval1 = SCVal.new(Int64.new(3), SCValType.new(:SCV_I64))
      scval2 = SCVal.new(Int64.new(2), SCValType.new(:SCV_I64))

      sc_vals = [scval1, scval2]

      args = SCVec.new(sc_vals)

      soroban_auth_contract_function =
        SorobanAuthorizedContractFunction.new(contract_address, function_name, args)

      function =
        SorobanAuthorizedFunction.new(
          soroban_auth_contract_function,
          SorobanAuthorizedFunctionType.new(:SOROBAN_AUTHORIZED_FUNCTION_TYPE_CONTRACT_FN)
        )

      sub_invocations = SorobanAuthorizedInvocationList.new([])
      root_invocation = SorobanAuthorizedInvocation.new(function, sub_invocations)

      soroban_credentials =
        SorobanCredentials.new(
          Void.new(),
          SorobanCredentialsType.new(:SOROBAN_CREDENTIALS_SOURCE_ACCOUNT)
        )

      %{
        soroban_credentials: soroban_credentials,
        root_invocation: root_invocation,
        soroban_authorization_entry:
          SorobanAuthorizationEntry.new(soroban_credentials, root_invocation),
        binary:
          <<0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 114, 213, 178, 144, 98, 27, 186, 154,
            137, 68, 149, 154, 124, 205, 198, 221, 187, 173, 152, 33, 210, 37, 10, 76, 25, 212,
            179, 73, 138, 2, 227, 119, 0, 0, 0, 5, 72, 101, 108, 108, 111, 0, 0, 0, 0, 0, 0, 2, 0,
            0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0>>
      }
    end

    test "new/1", %{
      soroban_credentials: soroban_credentials,
      root_invocation: root_invocation
    } do
      %SorobanAuthorizationEntry{
        credentials: ^soroban_credentials,
        root_invocation: ^root_invocation
      } =
        SorobanAuthorizationEntry.new(
          soroban_credentials,
          root_invocation
        )
    end

    test "encode_xdr/1", %{
      soroban_authorization_entry: soroban_authorization_entry,
      binary: binary
    } do
      {:ok, ^binary} = SorobanAuthorizationEntry.encode_xdr(soroban_authorization_entry)
    end

    test "encode_xdr!/1", %{
      soroban_authorization_entry: soroban_authorization_entry,
      binary: binary
    } do
      ^binary = SorobanAuthorizationEntry.encode_xdr!(soroban_authorization_entry)
    end

    test "decode_xdr/2", %{
      soroban_authorization_entry: soroban_authorization_entry,
      binary: binary
    } do
      {:ok, {^soroban_authorization_entry, ""}} = SorobanAuthorizationEntry.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = SorobanAuthorizationEntry.decode_xdr(123)
    end

    test "decode_xdr!/2", %{
      soroban_authorization_entry: soroban_authorization_entry,
      binary: binary
    } do
      {^soroban_authorization_entry, ^binary} =
        SorobanAuthorizationEntry.decode_xdr!(binary <> binary)
    end
  end
end
