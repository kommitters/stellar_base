defmodule StellarBase.XDR.SourceAccountContractIDTest do
  use ExUnit.Case

  alias StellarBase.XDR.{
    SourceAccountContractID,
    Hash,
    UInt256,
    AccountID,
    PublicKey,
    PublicKeyType
  }

  alias StellarBase.StrKey

  describe "SourceAccountContractID" do
    setup do
      network_id = Hash.new("GCIZ3GSM5XL7OUS4UP64THMDZ7CZ3ZWN")

      pk_type = PublicKeyType.new(:PUBLIC_KEY_TYPE_ED25519)

      source_account =
        "GBZNLMUQMIN3VGUJISKZU7GNY3O3XLMYEHJCKCSMDHKLGSMKALRXOEZD"
        |> StrKey.decode!(:ed25519_public_key)
        |> UInt256.new()
        |> PublicKey.new(pk_type)
        |> AccountID.new()

      salt =
        UInt256.new(
          <<72, 101, 108, 108, 111, 32, 119, 111, 114, 108, 100, 0, 21, 0, 1, 0, 72, 101, 108,
            108, 111, 32, 119, 111, 114, 108, 100, 0, 21, 0, 1, 0>>
        )

      %{
        network_id: network_id,
        source_account: source_account,
        salt: salt,
        source_account_contract_id: SourceAccountContractID.new(network_id, source_account, salt),
        binary:
          <<71, 67, 73, 90, 51, 71, 83, 77, 53, 88, 76, 55, 79, 85, 83, 52, 85, 80, 54, 52, 84,
            72, 77, 68, 90, 55, 67, 90, 51, 90, 87, 78, 0, 0, 0, 0, 114, 213, 178, 144, 98, 27,
            186, 154, 137, 68, 149, 154, 124, 205, 198, 221, 187, 173, 152, 33, 210, 37, 10, 76,
            25, 212, 179, 73, 138, 2, 227, 119, 72, 101, 108, 108, 111, 32, 119, 111, 114, 108,
            100, 0, 21, 0, 1, 0, 72, 101, 108, 108, 111, 32, 119, 111, 114, 108, 100, 0, 21, 0, 1,
            0>>
      }
    end

    test "new/1", %{
      network_id: network_id,
      source_account: source_account,
      salt: salt
    } do
      %SourceAccountContractID{
        network_id: ^network_id,
        source_account: ^source_account,
        salt: ^salt
      } = SourceAccountContractID.new(network_id, source_account, salt)
    end

    test "encode_xdr/1", %{source_account_contract_id: source_account_contract_id, binary: binary} do
      {:ok, ^binary} = SourceAccountContractID.encode_xdr(source_account_contract_id)
    end

    test "encode_xdr!/1", %{
      source_account_contract_id: source_account_contract_id,
      binary: binary
    } do
      ^binary = SourceAccountContractID.encode_xdr!(source_account_contract_id)
    end

    test "decode_xdr/2", %{source_account_contract_id: source_account_contract_id, binary: binary} do
      {:ok, {^source_account_contract_id, ""}} = SourceAccountContractID.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = SourceAccountContractID.decode_xdr(123)
    end

    test "decode_xdr!/2", %{
      source_account_contract_id: source_account_contract_id,
      binary: binary
    } do
      {^source_account_contract_id, ""} = SourceAccountContractID.decode_xdr!(binary)
    end
  end
end
