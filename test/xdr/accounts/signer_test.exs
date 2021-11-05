defmodule StellarBase.XDR.SignerTest do
  use ExUnit.Case

  alias StellarBase.XDR.{Signer, SignerKey, SignerKeyType, UInt32, UInt256}
  alias StellarBase.Ed25519.PublicKey

  describe "Signer" do
    setup do
      signer_type = SignerKeyType.new(:SIGNER_KEY_TYPE_ED25519)

      signer_key =
        "GBQVLZE4XCNDFW2N3SPUG4SI6D6YCDJPI45M5JHWUGHQSAT7REKIGCNQ"
        |> PublicKey.decode!()
        |> UInt256.new()
        |> SignerKey.new(signer_type)

      weight = UInt32.new(1)

      %{
        signer: Signer.new(signer_key, weight),
        key: signer_key,
        weight: weight,
        binary:
          <<0, 0, 0, 0, 97, 85, 228, 156, 184, 154, 50, 219, 77, 220, 159, 67, 114, 72, 240, 253,
            129, 13, 47, 71, 58, 206, 164, 246, 161, 143, 9, 2, 127, 137, 20, 131, 0, 0, 0, 1>>
      }
    end

    test "new/1", %{key: key, weight: weight} do
      %Signer{key: ^key, weight: ^weight} = Signer.new(key, weight)
    end

    test "encode_xdr/1", %{signer: signer, binary: binary} do
      {:ok, ^binary} = Signer.encode_xdr(signer)
    end

    test "encode_xdr!/1", %{signer: signer, binary: binary} do
      ^binary = Signer.encode_xdr!(signer)
    end

    test "decode_xdr/2", %{signer: signer, binary: binary} do
      {:ok, {^signer, ""}} = Signer.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = Signer.decode_xdr(123)
    end

    test "decode_xdr!/2", %{signer: signer, binary: binary} do
      {^signer, ^binary} = Signer.decode_xdr!(binary <> binary)
    end
  end
end
