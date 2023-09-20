defmodule StellarBase.XDR.SorobanAuthorizedContractFunctionTest do
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
    SCValList,
    InvokeContractArgs,
    InvokeContractArgs,
    UInt256
  }

  alias StellarBase.StrKey

  describe "InvokeContractArgs" do
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

      args = SCValList.new(sc_vals)

      %{
        contract_address: contract_address,
        function_name: function_name,
        args: args,
        soroban_authorized_contract_function:
          InvokeContractArgs.new(contract_address, function_name, args),
        binary:
          <<0, 0, 0, 0, 0, 0, 0, 0, 114, 213, 178, 144, 98, 27, 186, 154, 137, 68, 149, 154, 124,
            205, 198, 221, 187, 173, 152, 33, 210, 37, 10, 76, 25, 212, 179, 73, 138, 2, 227, 119,
            0, 0, 0, 5, 72, 101, 108, 108, 111, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0,
            0, 3, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 2>>
      }
    end

    test "new/1", %{
      contract_address: contract_address,
      function_name: function_name,
      args: args
    } do
      %InvokeContractArgs{
        contract_address: ^contract_address,
        function_name: ^function_name,
        args: ^args
      } =
        InvokeContractArgs.new(
          contract_address,
          function_name,
          args
        )
    end

    test "encode_xdr/1", %{
      soroban_authorized_contract_function: soroban_authorized_contract_function,
      binary: binary
    } do
      {:ok, ^binary} = InvokeContractArgs.encode_xdr(soroban_authorized_contract_function)
    end

    test "encode_xdr!/1", %{
      soroban_authorized_contract_function: soroban_authorized_contract_function,
      binary: binary
    } do
      ^binary = InvokeContractArgs.encode_xdr!(soroban_authorized_contract_function)
    end

    test "decode_xdr/2", %{
      soroban_authorized_contract_function: soroban_authorized_contract_function,
      binary: binary
    } do
      {:ok, {^soroban_authorized_contract_function, ""}} = InvokeContractArgs.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = InvokeContractArgs.decode_xdr(123)
    end

    test "decode_xdr!/2", %{
      soroban_authorized_contract_function: soroban_authorized_contract_function,
      binary: binary
    } do
      {^soroban_authorized_contract_function, ^binary} =
        InvokeContractArgs.decode_xdr!(binary <> binary)
    end
  end
end
