defmodule StellarBase.XDR.ContractAuthTest do
  use ExUnit.Case

  alias StellarBase.XDR.{
    AuthorizedInvocation,
    AuthorizedInvocationList,
    AccountID,
    AddressWithNonce,
    ContractAuth,
    Hash,
    Int64,
    PublicKey,
    PublicKeyType,
    SCAddress,
    SCAddressType,
    SCSymbol,
    SCVal,
    SCValType,
    SCVec,
    OptionalAddressWithNonce,
    Uint64,
    Uint256
  }

  alias StellarBase.StrKey

  describe "ContractAuthTest" do
    setup do
      # AddressWithNonce
      sc_address_type = SCAddressType.new(:SC_ADDRESS_TYPE_ACCOUNT)
      pk_type = PublicKeyType.new(:PUBLIC_KEY_TYPE_ED25519)

      account_id =
        "GBZNLMUQMIN3VGUJISKZU7GNY3O3XLMYEHJCKCSMDHKLGSMKALRXOEZD"
        |> StrKey.decode!(:ed25519_public_key)
        |> Uint256.new()
        |> PublicKey.new(pk_type)
        |> AccountID.new()

      sc_address = SCAddress.new(account_id, sc_address_type)
      nonce = Uint64.new(123)

      address_with_nonce =
        sc_address |> AddressWithNonce.new(nonce) |> OptionalAddressWithNonce.new()

      address_with_nonce_nil = OptionalAddressWithNonce.new()

      # SCVec
      scval1 = SCVal.new(Int64.new(3), SCValType.new(:SCV_I64))
      scval2 = SCVal.new(Int64.new(2), SCValType.new(:SCV_I64))
      sc_vals = [scval1, scval2]
      sc_vec = SCVec.new(sc_vals)

      # AuthorizedInvocation
      contract_id = Hash.new("GCIZ3GSM5XL7OUS4UP64THMDZ7CZ3ZWN")
      function_name = SCSymbol.new("Hello")

      authorized_invocation =
        AuthorizedInvocation.new(
          contract_id,
          function_name,
          sc_vec,
          AuthorizedInvocationList.new([])
        )

      discriminants = [
        %{
          address_with_nonce: address_with_nonce,
          authorized_invocation: authorized_invocation,
          sc_vec: sc_vec,
          contract_auth: ContractAuth.new(address_with_nonce, authorized_invocation, sc_vec),
          binary:
            <<0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 114, 213, 178, 144, 98, 27, 186, 154, 137, 68,
              149, 154, 124, 205, 198, 221, 187, 173, 152, 33, 210, 37, 10, 76, 25, 212, 179, 73,
              138, 2, 227, 119, 0, 0, 0, 0, 0, 0, 0, 123, 71, 67, 73, 90, 51, 71, 83, 77, 53, 88,
              76, 55, 79, 85, 83, 52, 85, 80, 54, 52, 84, 72, 77, 68, 90, 55, 67, 90, 51, 90, 87,
              78, 0, 0, 0, 5, 72, 101, 108, 108, 111, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 6, 0, 0, 0, 0,
              0, 0, 0, 3, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 6,
              0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 2>>
        },
        %{
          address_with_nonce: address_with_nonce_nil,
          authorized_invocation: authorized_invocation,
          sc_vec: sc_vec,
          contract_auth: ContractAuth.new(address_with_nonce_nil, authorized_invocation, sc_vec),
          binary:
            <<0, 0, 0, 0, 71, 67, 73, 90, 51, 71, 83, 77, 53, 88, 76, 55, 79, 85, 83, 52, 85, 80,
              54, 52, 84, 72, 77, 68, 90, 55, 67, 90, 51, 90, 87, 78, 0, 0, 0, 5, 72, 101, 108,
              108, 111, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 6, 0, 0,
              0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0,
              0, 6, 0, 0, 0, 0, 0, 0, 0, 2>>
        }
      ]

      %{discriminants: discriminants}
    end

    test "new/1", %{discriminants: discriminants} do
      for %{
            address_with_nonce: address_with_nonce,
            authorized_invocation: authorized_invocation,
            sc_vec: sc_vec
          } <-
            discriminants do
        %ContractAuth{
          address_with_nonce: ^address_with_nonce,
          root_invocation: ^authorized_invocation,
          signature_args: ^sc_vec
        } = ContractAuth.new(address_with_nonce, authorized_invocation, sc_vec)
      end
    end

    test "encode_xdr/1", %{discriminants: discriminants} do
      for %{contract_auth: contract_auth, binary: binary} <-
            discriminants do
        {:ok, ^binary} = ContractAuth.encode_xdr(contract_auth)
      end
    end

    test "encode_xdr!/1", %{discriminants: discriminants} do
      for %{contract_auth: contract_auth, binary: binary} <-
            discriminants do
        ^binary = ContractAuth.encode_xdr!(contract_auth)
      end
    end

    test "decode_xdr/2", %{discriminants: discriminants} do
      for %{contract_auth: contract_auth, binary: binary} <-
            discriminants do
        {:ok, {^contract_auth, ""}} = ContractAuth.decode_xdr(binary)
      end
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = ContractAuth.decode_xdr(1234)
    end

    test "decode_xdr!/2", %{discriminants: discriminants} do
      for %{contract_auth: contract_auth, binary: binary} <-
            discriminants do
        {^contract_auth, ""} = ContractAuth.decode_xdr!(binary)
      end
    end
  end
end
