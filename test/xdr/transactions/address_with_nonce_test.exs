defmodule StellarBase.XDR.AddressWithNonceTest do
  use ExUnit.Case

  alias StellarBase.XDR.{
    AccountID,
    AddressWithNonce,
    PublicKey,
    PublicKeyType,
    SCAddress,
    SCAddressType,
    Uint64,
    Uint256
  }

  alias StellarBase.StrKey

  describe "AddressWithNonce" do
    setup do
      sc_address_type = SCAddressType.new(:SC_ADDRESS_TYPE_ACCOUNT)
      pk_type = PublicKeyType.new(:PUBLIC_KEY_TYPE_ED25519)

      account_id =
        "GBZNLMUQMIN3VGUJISKZU7GNY3O3XLMYEHJCKCSMDHKLGSMKALRXOEZD"
        |> StrKey.decode!(:ed25519_public_key)
        |> Uint256.new()
        |> PublicKey.new(pk_type)
        |> AccountID.new()

      sc_address = SCAddress.new(account_id, sc_address_type)

      nonce = Uint64.new(123)

      %{
        sc_address: sc_address,
        nonce: nonce,
        address_with_nonce: AddressWithNonce.new(sc_address, nonce),
        binary:
          <<0, 0, 0, 0, 0, 0, 0, 0, 114, 213, 178, 144, 98, 27, 186, 154, 137, 68, 149, 154, 124,
            205, 198, 221, 187, 173, 152, 33, 210, 37, 10, 76, 25, 212, 179, 73, 138, 2, 227, 119,
            0, 0, 0, 0, 0, 0, 0, 123>>
      }
    end

    test "new/1", %{sc_address: sc_address, nonce: nonce} do
      %AddressWithNonce{address: ^sc_address, nonce: ^nonce} =
        AddressWithNonce.new(sc_address, nonce)
    end

    test "encode_xdr/1", %{address_with_nonce: address_with_nonce, binary: binary} do
      {:ok, ^binary} = AddressWithNonce.encode_xdr(address_with_nonce)
    end

    test "encode_xdr!/1", %{address_with_nonce: address_with_nonce, binary: binary} do
      ^binary = AddressWithNonce.encode_xdr!(address_with_nonce)
    end

    test "decode_xdr/2", %{address_with_nonce: address_with_nonce, binary: binary} do
      {:ok, {^address_with_nonce, ""}} = AddressWithNonce.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = AddressWithNonce.decode_xdr(1234)
    end

    test "decode_xdr!/2", %{address_with_nonce: address_with_nonce, binary: binary} do
      {^address_with_nonce, ^binary} = AddressWithNonce.decode_xdr!(binary <> binary)
    end
  end
end
