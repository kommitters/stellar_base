defmodule StellarBase.XDR.SCAddressTest do
  use ExUnit.Case

  alias StellarBase.XDR.SCAddress
  alias StellarBase.XDR.SCAddressType

  alias StellarBase.XDR.{
    AccountID,
    PublicKey,
    PublicKeyType,
    UInt256
  }

  alias StellarBase.StrKey

  describe "SCAddress" do
    setup do
      pk_type = PublicKeyType.new(:PUBLIC_KEY_TYPE_ED25519)

      account_id =
        "GBZNLMUQMIN3VGUJISKZU7GNY3O3XLMYEHJCKCSMDHKLGSMKALRXOEZD"
        |> StrKey.decode!(:ed25519_public_key)
        |> UInt256.new()
        |> PublicKey.new(pk_type)
        |> AccountID.new()

      sc_address_type = SCAddressType.new(:SC_ADDRESS_TYPE_ACCOUNT)

      %{
        account_id: account_id,
        sc_address_type: sc_address_type,
        sc_address: SCAddress.new(account_id, sc_address_type),
        binary:
          <<0, 0, 0, 0, 0, 0, 0, 0, 114, 213, 178, 144, 98, 27, 186, 154, 137, 68, 149, 154, 124,
            205, 198, 221, 187, 173, 152, 33, 210, 37, 10, 76, 25, 212, 179, 73, 138, 2, 227,
            119>>
      }
    end

    test "new/1", %{account_id: account_id, sc_address_type: sc_address_type} do
      %SCAddress{sc_address: ^account_id, type: ^sc_address_type} =
        SCAddress.new(account_id, sc_address_type)
    end

    test "encode_xdr/1", %{sc_address: sc_address, binary: binary} do
      {:ok, ^binary} = SCAddress.encode_xdr(sc_address)
    end

    test "encode_xdr/1 with an invalid type", %{account_id: account_id} do
      sc_address_type = SCAddressType.new(:NEW_ADDRESS)

      assert_raise XDR.EnumError,
                   "The key which you try to encode doesn't belong to the current declarations",
                   fn ->
                     account_id
                     |> SCAddress.new(sc_address_type)
                     |> SCAddress.encode_xdr()
                   end
    end

    test "encode_xdr!/1", %{sc_address: sc_address, binary: binary} do
      ^binary = SCAddress.encode_xdr!(sc_address)
    end

    test "decode_xdr/2", %{sc_address: sc_address, binary: binary} do
      {:ok, {^sc_address, ""}} = SCAddress.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = SCAddress.decode_xdr(123)
    end

    test "decode_xdr!/2", %{sc_address: sc_address, binary: binary} do
      {^sc_address, ^binary} = SCAddress.decode_xdr!(binary <> binary)
    end
  end
end
