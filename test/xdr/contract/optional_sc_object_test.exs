defmodule StellarBase.XDR.OptionalSCObjectTest do
  use ExUnit.Case

  alias StellarBase.XDR.{
    AccountID,
    SCObject,
    SCObjectType,
    OptionalSCObject,
    SCAddress,
    SCAddressType,
    PublicKey,
    PublicKeyType,
    UInt256
  }

  alias StellarBase.StrKey

  describe "OptionalSCObject" do
    setup do
      pk_type = PublicKeyType.new(:PUBLIC_KEY_TYPE_ED25519)

      account_id =
        "GBZNLMUQMIN3VGUJISKZU7GNY3O3XLMYEHJCKCSMDHKLGSMKALRXOEZD"
        |> StrKey.decode!(:ed25519_public_key)
        |> UInt256.new()
        |> PublicKey.new(pk_type)
        |> AccountID.new()

      sc_address_type = SCAddressType.new(:SC_ADDRESS_TYPE_ACCOUNT)

      sc_address = SCAddress.new(account_id, sc_address_type)

      sc_object_type = SCObjectType.new(:SCO_ADDRESS)

      sc_object = SCObject.new(sc_address, sc_object_type)

      %{
        optional_sc_object: OptionalSCObject.new(sc_object),
        empty_sc_object: OptionalSCObject.new(nil),
        binary:
          <<0, 0, 0, 1, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 0, 114, 213, 178, 144, 98, 27, 186, 154,
            137, 68, 149, 154, 124, 205, 198, 221, 187, 173, 152, 33, 210, 37, 10, 76, 25, 212,
            179, 73, 138, 2, 227, 119>>
      }
    end

    test "new/1", %{optional_sc_object: optional_sc_object} do
      %OptionalSCObject{sc_object: ^optional_sc_object} = OptionalSCObject.new(optional_sc_object)
    end

    test "new/1 no sc_object opted" do
      %OptionalSCObject{sc_object: nil} = OptionalSCObject.new(nil)
    end

    test "encode_xdr/1", %{optional_sc_object: optional_sc_object, binary: binary} do
      {:ok, ^binary} = OptionalSCObject.encode_xdr(optional_sc_object)
    end

    test "encode_xdr/1 no sc_object opted", %{empty_sc_object: empty_sc_object} do
      {:ok, <<0, 0, 0, 0>>} = OptionalSCObject.encode_xdr(empty_sc_object)
    end

    test "encode_xdr!/1", %{optional_sc_object: optional_sc_object, binary: binary} do
      ^binary = OptionalSCObject.encode_xdr!(optional_sc_object)
    end

    test "decode_xdr/2", %{optional_sc_object: optional_sc_object, binary: binary} do
      {:ok, {^optional_sc_object, ""}} = OptionalSCObject.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = OptionalSCObject.decode_xdr(1234)
    end

    test "decode_xdr/2 when sc_object is not opted" do
      {:ok, {%OptionalSCObject{sc_object: nil}, ""}} = OptionalSCObject.decode_xdr(<<0, 0, 0, 0>>)
    end

    test "decode_xdr!/2", %{optional_sc_object: optional_sc_object, binary: binary} do
      {^optional_sc_object, ^binary} = OptionalSCObject.decode_xdr!(binary <> binary)
    end

    test "decode_xdr!/2 when sc_object is not opted" do
      {%OptionalSCObject{sc_object: nil}, ""} = OptionalSCObject.decode_xdr!(<<0, 0, 0, 0>>)
    end
  end
end
