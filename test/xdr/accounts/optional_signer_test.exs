defmodule Stellar.XDR.OptionalSignerTest do
  use ExUnit.Case

  alias Stellar.XDR.{Signer, OptionalSigner, SignerKey, SignerKeyType, UInt32, UInt256}
  alias Stellar.Ed25519.PublicKey

  describe "OptionalSigner" do
    setup do
      signer_type = SignerKeyType.new(:SIGNER_KEY_TYPE_ED25519)

      signer_key =
        "GBQVLZE4XCNDFW2N3SPUG4SI6D6YCDJPI45M5JHWUGHQSAT7REKIGCNQ"
        |> PublicKey.decode!()
        |> UInt256.new()
        |> SignerKey.new(signer_type)

      weight = UInt32.new(1)

      signer = Signer.new(signer_key, weight)

      %{
        optional_signer: OptionalSigner.new(signer),
        empty_signer: OptionalSigner.new(nil),
        binary:
          <<0, 0, 0, 1, 0, 0, 0, 0, 97, 85, 228, 156, 184, 154, 50, 219, 77, 220, 159, 67, 114, 72, 240, 253,
            129, 13, 47, 71, 58, 206, 164, 246, 161, 143, 9, 2, 127, 137, 20, 131, 0, 0, 0, 1>>
      }
    end

    test "new/1", %{optional_signer: optional_signer} do
      %OptionalSigner{signer: ^optional_signer} = OptionalSigner.new(optional_signer)
    end

    test "new/1 no signer opted" do
      %OptionalSigner{signer: nil} = OptionalSigner.new(nil)
    end

    test "encode_xdr/1", %{optional_signer: optional_signer, binary: binary} do
      {:ok, ^binary} = OptionalSigner.encode_xdr(optional_signer)
    end

    test "encode_xdr/1 no signer opted", %{empty_signer: empty_signer} do
      {:ok, <<0, 0, 0, 0>>} = OptionalSigner.encode_xdr(empty_signer)
    end

    test "encode_xdr!/1", %{optional_signer: optional_signer, binary: binary} do
      ^binary = OptionalSigner.encode_xdr!(optional_signer)
    end

    test "decode_xdr/2", %{optional_signer: optional_signer, binary: binary} do
      {:ok, {^optional_signer, ""}} = OptionalSigner.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = OptionalSigner.decode_xdr(1234)
    end

    test "decode_xdr/2 when signer is not opted" do
      {:ok, {%OptionalSigner{signer: nil}, ""}} = OptionalSigner.decode_xdr(<<0, 0, 0, 0>>)
    end

    test "decode_xdr!/2", %{optional_signer: optional_signer, binary: binary} do
      {^optional_signer, ^binary} = OptionalSigner.decode_xdr!(binary <> binary)
    end

    test "decode_xdr!/2 when signer is not opted" do
      {%OptionalSigner{signer: nil}, ""} = OptionalSigner.decode_xdr!(<<0, 0, 0, 0>>)
    end
  end
end
