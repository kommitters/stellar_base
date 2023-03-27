defmodule StellarBase.XDR.OptionalAddressWithNonceTest do
  use ExUnit.Case

  alias StellarBase.XDR.{
    AccountID,
    AddressWithNonce,
    PublicKey,
    PublicKeyType,
    SCAddress,
    SCAddressType,
    OptionalAddressWithNonce,
    UInt64,
    UInt256
  }

  alias StellarBase.StrKey

  describe "OptionalAddressWithNonce" do
    setup do
      sc_address_type = SCAddressType.new(:SC_ADDRESS_TYPE_ACCOUNT)
      pk_type = PublicKeyType.new(:PUBLIC_KEY_TYPE_ED25519)

      account_id =
        "GBZNLMUQMIN3VGUJISKZU7GNY3O3XLMYEHJCKCSMDHKLGSMKALRXOEZD"
        |> StrKey.decode!(:ed25519_public_key)
        |> UInt256.new()
        |> PublicKey.new(pk_type)
        |> AccountID.new()

      sc_address = SCAddress.new(account_id, sc_address_type)
      nonce = UInt64.new(123)

      address_with_nonce = AddressWithNonce.new(sc_address, nonce)

      discriminants = [
        %{
          address_with_nonce: address_with_nonce,
          optional_address_with_nonce: OptionalAddressWithNonce.new(address_with_nonce),
          binary:
            <<0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 114, 213, 178, 144, 98, 27, 186, 154, 137, 68,
              149, 154, 124, 205, 198, 221, 187, 173, 152, 33, 210, 37, 10, 76, 25, 212, 179, 73,
              138, 2, 227, 119, 0, 0, 0, 0, 0, 0, 0, 123>>
        },
        %{
          address_with_nonce: nil,
          optional_address_with_nonce: OptionalAddressWithNonce.new(),
          binary: <<0, 0, 0, 0>>
        }
      ]

      %{discriminants: discriminants}
    end

    test "new/1", %{discriminants: discriminants} do
      for %{address_with_nonce: address_with_nonce} <-
            discriminants do
        %OptionalAddressWithNonce{address_with_nonce: ^address_with_nonce} =
          OptionalAddressWithNonce.new(address_with_nonce)
      end
    end

    test "encode_xdr/1", %{discriminants: discriminants} do
      for %{optional_address_with_nonce: optional_address_with_nonce, binary: binary} <-
            discriminants do
        {:ok, ^binary} = OptionalAddressWithNonce.encode_xdr(optional_address_with_nonce)
      end
    end

    test "encode_xdr!/1", %{discriminants: discriminants} do
      for %{optional_address_with_nonce: optional_address_with_nonce, binary: binary} <-
            discriminants do
        ^binary = OptionalAddressWithNonce.encode_xdr!(optional_address_with_nonce)
      end
    end

    test "decode_xdr/2", %{discriminants: discriminants} do
      for %{optional_address_with_nonce: optional_address_with_nonce, binary: binary} <-
            discriminants do
        {:ok, {^optional_address_with_nonce, ""}} = OptionalAddressWithNonce.decode_xdr(binary)
      end
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = OptionalAddressWithNonce.decode_xdr(1234)
    end

    test "decode_xdr!/2", %{discriminants: discriminants} do
      for %{optional_address_with_nonce: optional_address_with_nonce, binary: binary} <-
            discriminants do
        {^optional_address_with_nonce, ""} = OptionalAddressWithNonce.decode_xdr!(binary)
      end
    end
  end
end
