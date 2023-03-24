defmodule StellarBase.XDR.Ed25519KeyWithSignatureTest do
  use ExUnit.Case

  alias StellarBase.XDR.{Signature, UInt256, Ed25519KeyWithSignature}

  alias StellarBase.StrKey

  describe "Ed25519KeyWithSignature" do
    setup do
      key =
        "GCVILYTXYXYHZIBYEF4BSLATAP3CPZMW23NE6DUL7I6LCCDUNFBQFAVR"
        |> StrKey.decode!(:ed25519_public_key)
        |> UInt256.new()

      signature = Signature.new("SAPVVUQ2G755KGQOOY5A3AGTMWCCQQTJMGSXAUKMFT45OFCL7NCSTRWI")
      ed25519_key_with_signature = Ed25519KeyWithSignature.new(signature, key)

      %{
        key: key,
        signature: signature,
        ed25519_key_with_signature: ed25519_key_with_signature,
        binary:
          <<0, 0, 0, 56, 83, 65, 80, 86, 86, 85, 81, 50, 71, 55, 53, 53, 75, 71, 81, 79, 79, 89,
            53, 65, 51, 65, 71, 84, 77, 87, 67, 67, 81, 81, 84, 74, 77, 71, 83, 88, 65, 85, 75,
            77, 70, 84, 52, 53, 79, 70, 67, 76, 55, 78, 67, 83, 84, 82, 87, 73, 170, 133, 226,
            119, 197, 240, 124, 160, 56, 33, 120, 25, 44, 19, 3, 246, 39, 229, 150, 214, 218, 79,
            14, 139, 250, 60, 177, 8, 116, 105, 67, 2>>
      }
    end

    test "new/2", %{signature: signature, key: key} do
      %Ed25519KeyWithSignature{signature: ^signature, key: ^key} =
        Ed25519KeyWithSignature.new(signature, key)
    end

    test "encode_xdr/1", %{ed25519_key_with_signature: ed25519_key_with_signature, binary: binary} do
      {:ok, ^binary} = Ed25519KeyWithSignature.encode_xdr(ed25519_key_with_signature)
    end

    test "encode_xdr!/1", %{
      ed25519_key_with_signature: ed25519_key_with_signature,
      binary: binary
    } do
      ^binary = Ed25519KeyWithSignature.encode_xdr!(ed25519_key_with_signature)
    end

    test "decode_xdr/2", %{ed25519_key_with_signature: ed25519_key_with_signature, binary: binary} do
      {:ok, {^ed25519_key_with_signature, ""}} = Ed25519KeyWithSignature.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = Ed25519KeyWithSignature.decode_xdr(123)
    end

    test "decode_xdr!/2", %{
      ed25519_key_with_signature: ed25519_key_with_signature,
      binary: binary
    } do
      {^ed25519_key_with_signature, ""} = Ed25519KeyWithSignature.decode_xdr!(binary)
    end
  end
end
