defmodule StellarBase.XDR.ContractIDPreimageFromAddressTest do
  use ExUnit.Case

  alias StellarBase.XDR.{
    AccountID,
    ContractIDPreimageFromAddress,
    PublicKey,
    PublicKeyType,
    SCAddress,
    SCAddressType,
    UInt256
  }

  alias StellarBase.StrKey

  describe "ContractIDPreimageFromAddress" do
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

      salt =
        UInt256.new(
          <<72, 101, 108, 108, 111, 32, 119, 111, 114, 108, 100, 0, 21, 0, 1, 0, 72, 101, 108,
            108, 111, 32, 119, 111, 114, 108, 100, 0, 21, 0, 1, 0>>
        )

      %{
        address: address,
        salt: salt,
        contract_id_preimage_from_address: ContractIDPreimageFromAddress.new(address, salt),
        binary:
          <<0, 0, 0, 0, 0, 0, 0, 0, 114, 213, 178, 144, 98, 27, 186, 154, 137, 68, 149, 154, 124,
            205, 198, 221, 187, 173, 152, 33, 210, 37, 10, 76, 25, 212, 179, 73, 138, 2, 227, 119,
            72, 101, 108, 108, 111, 32, 119, 111, 114, 108, 100, 0, 21, 0, 1, 0, 72, 101, 108,
            108, 111, 32, 119, 111, 114, 108, 100, 0, 21, 0, 1, 0>>
      }
    end

    test "new/3", %{address: address, salt: salt} do
      %ContractIDPreimageFromAddress{
        address: ^address,
        salt: ^salt
      } = ContractIDPreimageFromAddress.new(address, salt)
    end

    test "encode_xdr/1", %{
      contract_id_preimage_from_address: contract_id_preimage_from_address,
      binary: binary
    } do
      {:ok, ^binary} = ContractIDPreimageFromAddress.encode_xdr(contract_id_preimage_from_address)
    end

    test "encode_xdr!/1", %{
      contract_id_preimage_from_address: contract_id_preimage_from_address,
      binary: binary
    } do
      ^binary = ContractIDPreimageFromAddress.encode_xdr!(contract_id_preimage_from_address)
    end

    test "decode_xdr/2", %{
      contract_id_preimage_from_address: contract_id_preimage_from_address,
      binary: binary
    } do
      {:ok, {^contract_id_preimage_from_address, ""}} =
        ContractIDPreimageFromAddress.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = ContractIDPreimageFromAddress.decode_xdr(123)
    end

    test "decode_xdr!/2", %{
      contract_id_preimage_from_address: contract_id_preimage_from_address,
      binary: binary
    } do
      {^contract_id_preimage_from_address, ""} = ContractIDPreimageFromAddress.decode_xdr!(binary)
    end
  end
end
