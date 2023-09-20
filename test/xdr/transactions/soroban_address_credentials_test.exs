defmodule StellarBase.XDR.SorobanAddressCredentialsTest do
  use ExUnit.Case

  alias StellarBase.XDR.{
    AccountID,
    Int64,
    PublicKey,
    PublicKeyType,
    SCAddress,
    SCAddressType,
    SCVal,
    SCValType,
    SorobanAddressCredentials,
    UInt32,
    UInt256
  }

  alias StellarBase.StrKey

  describe "SorobanAddressCredentials" do
    setup do
      pk_type = PublicKeyType.new(:PUBLIC_KEY_TYPE_ED25519)

      account_id =
        "GBZNLMUQMIN3VGUJISKZU7GNY3O3XLMYEHJCKCSMDHKLGSMKALRXOEZD"
        |> StrKey.decode!(:ed25519_public_key)
        |> UInt256.new()
        |> PublicKey.new(pk_type)
        |> AccountID.new()

      sc_address_type = SCAddressType.new(:SC_ADDRESS_TYPE_ACCOUNT)

      address = SCAddress.new(account_id, sc_address_type)
      nonce = Int64.new(123_155)
      signature_expiration_ledger = UInt32.new(4_646_545)
      signature = SCVal.new(Int64.new(3), SCValType.new(:SCV_I64))

      soroban_address_credentials =
        SorobanAddressCredentials.new(address, nonce, signature_expiration_ledger, signature)

      %{
        address: address,
        nonce: nonce,
        signature_expiration_ledger: signature_expiration_ledger,
        signature: signature,
        soroban_address_credentials: soroban_address_credentials,
        binary:
          <<0, 0, 0, 0, 0, 0, 0, 0, 114, 213, 178, 144, 98, 27, 186, 154, 137, 68, 149, 154, 124,
            205, 198, 221, 187, 173, 152, 33, 210, 37, 10, 76, 25, 212, 179, 73, 138, 2, 227, 119,
            0, 0, 0, 0, 0, 1, 225, 19, 0, 70, 230, 145, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 3>>
      }
    end

    test "new/1", %{
      address: address,
      nonce: nonce,
      signature_expiration_ledger: signature_expiration_ledger,
      signature: signature
    } do
      %SorobanAddressCredentials{
        address: ^address,
        nonce: ^nonce,
        signature_expiration_ledger: ^signature_expiration_ledger,
        signature: ^signature
      } =
        SorobanAddressCredentials.new(
          address,
          nonce,
          signature_expiration_ledger,
          signature
        )
    end

    test "encode_xdr/1", %{
      soroban_address_credentials: soroban_address_credentials,
      binary: binary
    } do
      {:ok, ^binary} = SorobanAddressCredentials.encode_xdr(soroban_address_credentials)
    end

    test "encode_xdr!/1", %{
      soroban_address_credentials: soroban_address_credentials,
      binary: binary
    } do
      ^binary = SorobanAddressCredentials.encode_xdr!(soroban_address_credentials)
    end

    test "decode_xdr/2", %{
      soroban_address_credentials: soroban_address_credentials,
      binary: binary
    } do
      {:ok, {^soroban_address_credentials, ""}} = SorobanAddressCredentials.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = SorobanAddressCredentials.decode_xdr(123)
    end

    test "decode_xdr!/2", %{
      soroban_address_credentials: soroban_address_credentials,
      binary: binary
    } do
      {^soroban_address_credentials, ^binary} =
        SorobanAddressCredentials.decode_xdr!(binary <> binary)
    end
  end
end
