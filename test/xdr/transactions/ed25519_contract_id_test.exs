defmodule StellarBase.XDR.Ed25519ContractIDTest do
  use ExUnit.Case

  alias StellarBase.XDR.{Ed25519ContractID, Hash, UInt256}
  alias StellarBase.StrKey

  describe "Ed25519ContractID" do
    setup do
      network_id = Hash.new("GCIZ3GSM5XL7OUS4UP64THMDZ7CZ3ZWN")

      ed25519 =
        "GCVILYTXYXYHZIBYEF4BSLATAP3CPZMW23NE6DUL7I6LCCDUNFBQFAVR"
        |> StrKey.decode!(:ed25519_public_key)
        |> UInt256.new()

      salt =
        UInt256.new(
          <<72, 101, 108, 108, 111, 32, 119, 111, 114, 108, 100, 0, 21, 0, 1, 0, 72, 101, 108,
            108, 111, 32, 119, 111, 114, 108, 100, 0, 21, 0, 1, 0>>
        )

      %{
        network_id: network_id,
        ed25519: ed25519,
        salt: salt,
        ed25519_contract_id: Ed25519ContractID.new(network_id, ed25519, salt),
        binary:
          <<71, 67, 73, 90, 51, 71, 83, 77, 53, 88, 76, 55, 79, 85, 83, 52, 85, 80, 54, 52, 84,
            72, 77, 68, 90, 55, 67, 90, 51, 90, 87, 78, 170, 133, 226, 119, 197, 240, 124, 160,
            56, 33, 120, 25, 44, 19, 3, 246, 39, 229, 150, 214, 218, 79, 14, 139, 250, 60, 177, 8,
            116, 105, 67, 2, 72, 101, 108, 108, 111, 32, 119, 111, 114, 108, 100, 0, 21, 0, 1, 0,
            72, 101, 108, 108, 111, 32, 119, 111, 114, 108, 100, 0, 21, 0, 1, 0>>
      }
    end

    test "new/1", %{
      network_id: network_id,
      ed25519: ed25519,
      salt: salt
    } do
      %Ed25519ContractID{
        network_id: ^network_id,
        ed25519: ^ed25519,
        salt: ^salt
      } = Ed25519ContractID.new(network_id, ed25519, salt)
    end

    test "encode_xdr/1", %{ed25519_contract_id: ed25519_contract_id, binary: binary} do
      {:ok, ^binary} = Ed25519ContractID.encode_xdr(ed25519_contract_id)
    end

    test "encode_xdr!/1", %{ed25519_contract_id: ed25519_contract_id, binary: binary} do
      ^binary = Ed25519ContractID.encode_xdr!(ed25519_contract_id)
    end

    test "decode_xdr/2", %{ed25519_contract_id: ed25519_contract_id, binary: binary} do
      {:ok, {^ed25519_contract_id, ""}} = Ed25519ContractID.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = Ed25519ContractID.decode_xdr(123)
    end

    test "decode_xdr!/2", %{ed25519_contract_id: ed25519_contract_id, binary: binary} do
      {^ed25519_contract_id, ""} = Ed25519ContractID.decode_xdr!(binary)
    end
  end
end
