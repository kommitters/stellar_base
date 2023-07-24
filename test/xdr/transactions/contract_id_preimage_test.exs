defmodule StellarBase.XDR.ContractIDPreimageTest do
  use ExUnit.Case

  alias StellarBase.XDR.{
    AccountID,
    ContractIDPreimage,
    ContractIDPreimageType,
    ContractIDPreimageFromAddress,
    PublicKey,
    PublicKeyType,
    SCAddress,
    SCAddressType,
    UInt256
  }

  alias StellarBase.StrKey

  describe "ContractIDPreimage" do
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

      contract_id_preimage_from_address = ContractIDPreimageFromAddress.new(address, salt)
      type = ContractIDPreimageType.new(:CONTRACT_ID_PREIMAGE_FROM_ADDRESS)

      %{
        contract_id_preimage_from_address: contract_id_preimage_from_address,
        type: type,
        contract_id_preimage: ContractIDPreimage.new(contract_id_preimage_from_address, type),
        binary:
          <<0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 114, 213, 178, 144, 98, 27, 186, 154, 137, 68,
            149, 154, 124, 205, 198, 221, 187, 173, 152, 33, 210, 37, 10, 76, 25, 212, 179, 73,
            138, 2, 227, 119, 72, 101, 108, 108, 111, 32, 119, 111, 114, 108, 100, 0, 21, 0, 1, 0,
            72, 101, 108, 108, 111, 32, 119, 111, 114, 108, 100, 0, 21, 0, 1, 0>>
      }
    end

    test "new/3", %{
      contract_id_preimage_from_address: contract_id_preimage_from_address,
      type: type
    } do
      %ContractIDPreimage{
        value: ^contract_id_preimage_from_address,
        type: ^type
      } =
        ContractIDPreimage.new(
          contract_id_preimage_from_address,
          type
        )
    end

    test "encode_xdr/1", %{
      contract_id_preimage: contract_id_preimage,
      binary: binary
    } do
      {:ok, ^binary} = ContractIDPreimage.encode_xdr(contract_id_preimage)
    end

    test "encode_xdr!/1", %{
      contract_id_preimage: contract_id_preimage,
      binary: binary
    } do
      ^binary = ContractIDPreimage.encode_xdr!(contract_id_preimage)
    end

    test "decode_xdr/2", %{
      contract_id_preimage: contract_id_preimage,
      binary: binary
    } do
      {:ok, {^contract_id_preimage, ""}} = ContractIDPreimage.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = ContractIDPreimage.decode_xdr(123)
    end

    test "decode_xdr!/2", %{
      contract_id_preimage: contract_id_preimage,
      binary: binary
    } do
      {^contract_id_preimage, ""} = ContractIDPreimage.decode_xdr!(binary)
    end
  end
end
