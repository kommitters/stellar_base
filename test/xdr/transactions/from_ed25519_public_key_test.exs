defmodule StellarBase.XDR.ContractIDFromEd25519PublicKeyTest do
  use ExUnit.Case

  alias StellarBase.XDR.{Signature, Uint256, ContractIDFromEd25519PublicKey}

  alias StellarBase.StrKey

  describe "ContractIDFromEd25519PublicKey" do
    setup do
      key =
        "GCVILYTXYXYHZIBYEF4BSLATAP3CPZMW23NE6DUL7I6LCCDUNFBQFAVR"
        |> StrKey.decode!(:ed25519_public_key)
        |> Uint256.new()

      signature = Signature.new("SAPVVUQ2G755KGQOOY5A3AGTMWCCQQTJMGSXAUKMFT45OFCL7NCSTRWI")

      salt =
        Uint256.new(
          <<72, 101, 108, 108, 111, 32, 119, 111, 114, 108, 100, 0, 21, 0, 1, 0, 72, 101, 108,
            108, 111, 32, 119, 111, 114, 108, 100, 0, 21, 0, 1, 0>>
        )

      from_ed25519_public_key = ContractIDFromEd25519PublicKey.new(key, signature, salt)

      %{
        key: key,
        signature: signature,
        salt: salt,
        from_ed25519_public_key: from_ed25519_public_key,
        binary:
          <<170, 133, 226, 119, 197, 240, 124, 160, 56, 33, 120, 25, 44, 19, 3, 246, 39, 229, 150,
            214, 218, 79, 14, 139, 250, 60, 177, 8, 116, 105, 67, 2, 0, 0, 0, 56, 83, 65, 80, 86,
            86, 85, 81, 50, 71, 55, 53, 53, 75, 71, 81, 79, 79, 89, 53, 65, 51, 65, 71, 84, 77,
            87, 67, 67, 81, 81, 84, 74, 77, 71, 83, 88, 65, 85, 75, 77, 70, 84, 52, 53, 79, 70,
            67, 76, 55, 78, 67, 83, 84, 82, 87, 73, 72, 101, 108, 108, 111, 32, 119, 111, 114,
            108, 100, 0, 21, 0, 1, 0, 72, 101, 108, 108, 111, 32, 119, 111, 114, 108, 100, 0, 21,
            0, 1, 0>>
      }
    end

    test "new/2", %{key: key, signature: signature, salt: salt} do
      %ContractIDFromEd25519PublicKey{key: ^key, signature: ^signature, salt: ^salt} =
        ContractIDFromEd25519PublicKey.new(key, signature, salt)
    end

    test "encode_xdr/1", %{from_ed25519_public_key: from_ed25519_public_key, binary: binary} do
      {:ok, ^binary} = ContractIDFromEd25519PublicKey.encode_xdr(from_ed25519_public_key)
    end

    test "encode_xdr!/1", %{
      from_ed25519_public_key: from_ed25519_public_key,
      binary: binary
    } do
      ^binary = ContractIDFromEd25519PublicKey.encode_xdr!(from_ed25519_public_key)
    end

    test "decode_xdr/2", %{from_ed25519_public_key: from_ed25519_public_key, binary: binary} do
      {:ok, {^from_ed25519_public_key, ""}} = ContractIDFromEd25519PublicKey.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = ContractIDFromEd25519PublicKey.decode_xdr(123)
    end

    test "decode_xdr!/2", %{
      from_ed25519_public_key: from_ed25519_public_key,
      binary: binary
    } do
      {^from_ed25519_public_key, ""} = ContractIDFromEd25519PublicKey.decode_xdr!(binary)
    end
  end
end
