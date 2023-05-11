defmodule StellarBase.XDR.SignerList20Test do
  use ExUnit.Case

  alias StellarBase.XDR.{
    Signer,
    SignerList20,
    SignerKey,
    SignerKeyType,
    Uint32,
    Uint256
  }

  alias StellarBase.StrKey

  describe "SignerList20" do
    setup do
      signer1 = create_signer("GBQVLZE4XCNDFW2N3SPUG4SI6D6YCDJPI45M5JHWUGHQSAT7REKIGCNQ")
      signer2 = create_signer("GCNY5OXYSY4FKHOPT2SPOQZAOEIGXB5LBYW3HVU3OWSTQITS65M5RCNY")
      signers_list = [signer1, signer2]

      %{
        signers_list: signers_list,
        signers: SignerList20.new(signers_list),
        binary:
          <<0, 0, 0, 2, 0, 0, 0, 0, 97, 85, 228, 156, 184, 154, 50, 219, 77, 220, 159, 67, 114,
            72, 240, 253, 129, 13, 47, 71, 58, 206, 164, 246, 161, 143, 9, 2, 127, 137, 20, 131,
            0, 0, 0, 1, 0, 0, 0, 0, 155, 142, 186, 248, 150, 56, 85, 29, 207, 158, 164, 247, 67,
            32, 113, 16, 107, 135, 171, 14, 45, 179, 214, 155, 117, 165, 56, 34, 114, 247, 89,
            216, 0, 0, 0, 1>>
      }
    end

    test "new/1", %{signers_list: signers} do
      %SignerList20{items: ^signers} = SignerList20.new(signers)
    end

    test "encode_xdr/1", %{signers: signers, binary: binary} do
      {:ok, ^binary} = SignerList20.encode_xdr(signers)
    end

    test "encode_xdr/1 with invalid elements" do
      {:error, :not_list} =
        %{elements: nil}
        |> SignerList20.new()
        |> SignerList20.encode_xdr()
    end

    test "encode_xdr!/1", %{signers: signers, binary: binary} do
      ^binary = SignerList20.encode_xdr!(signers)
    end

    test "decode_xdr/2", %{signers: signers, binary: binary} do
      {:ok, {^signers, ""}} = SignerList20.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = SignerList20.decode_xdr(123)
    end

    test "decode_xdr!/2", %{signers: signers, binary: binary} do
      {^signers, ^binary} = SignerList20.decode_xdr!(binary <> binary)
    end
  end

  @spec create_signer(key :: String.t()) :: Signer.t()
  defp create_signer(key) do
    signer_type = SignerKeyType.new(:SIGNER_KEY_TYPE_ED25519)

    signer_key =
      key
      |> StrKey.decode!(:ed25519_public_key)
      |> Uint256.new()
      |> SignerKey.new(signer_type)

    weight = Uint32.new(1)
    Signer.new(signer_key, weight)
  end
end
