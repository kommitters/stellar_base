defmodule StellarBase.XDR.LedgerEntryTypeTest do
  use ExUnit.Case

  alias StellarBase.XDR.LedgerEntryType

  describe "Account LedgerEntryType" do
    setup do
      %{
        binary: <<0, 0, 0, 0>>,
        identifier: :ACCOUNT,
        entry_type: LedgerEntryType.new(:ACCOUNT)
      }
    end

    test "new/1", %{identifier: type} do
      %LedgerEntryType{identifier: ^type} = LedgerEntryType.new(type)
    end

    test "encode_xdr/1", %{entry_type: entry_type, binary: binary} do
      {:ok, ^binary} = LedgerEntryType.encode_xdr(entry_type)
    end

    test "encode_xdr!/1", %{entry_type: entry_type, binary: binary} do
      ^binary = LedgerEntryType.encode_xdr!(entry_type)
    end

    test "decode_xdr/2", %{entry_type: entry_type, binary: binary} do
      {:ok, {^entry_type, ""}} = LedgerEntryType.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = LedgerEntryType.decode_xdr(123)
    end

    test "decode_xdr!/2", %{entry_type: entry_type, binary: binary} do
      {^entry_type, ^binary} = LedgerEntryType.decode_xdr!(binary <> binary)
    end

    test "invalid identifier" do
      {:error, :invalid_key} =
        LedgerEntryType.encode_xdr(%LedgerEntryType{identifier: SECRET_KEY_TYPE_ED25519})
    end
  end

  describe "TrustLine LedgerEntryType" do
    setup do
      %{
        binary: <<0, 0, 0, 1>>,
        identifier: :TRUSTLINE,
        entry_type: LedgerEntryType.new(:TRUSTLINE)
      }
    end

    test "new/1", %{identifier: type} do
      %LedgerEntryType{identifier: ^type} = LedgerEntryType.new(type)
    end

    test "encode_xdr/1", %{entry_type: entry_type, binary: binary} do
      {:ok, ^binary} = LedgerEntryType.encode_xdr(entry_type)
    end

    test "encode_xdr!/1", %{entry_type: entry_type, binary: binary} do
      ^binary = LedgerEntryType.encode_xdr!(entry_type)
    end

    test "decode_xdr/2", %{entry_type: entry_type, binary: binary} do
      {:ok, {^entry_type, ""}} = LedgerEntryType.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = LedgerEntryType.decode_xdr(123)
    end

    test "decode_xdr!/2", %{entry_type: entry_type, binary: binary} do
      {^entry_type, ^binary} = LedgerEntryType.decode_xdr!(binary <> binary)
    end

    test "invalid identifier" do
      {:error, :invalid_key} =
        LedgerEntryType.encode_xdr(%LedgerEntryType{identifier: SECRET_KEY_TYPE_ED25519})
    end
  end

  describe "Offer LedgerEntryType" do
    setup do
      %{
        binary: <<0, 0, 0, 2>>,
        identifier: :OFFER,
        entry_type: LedgerEntryType.new(:OFFER)
      }
    end

    test "new/1", %{identifier: type} do
      %LedgerEntryType{identifier: ^type} = LedgerEntryType.new(type)
    end

    test "encode_xdr/1", %{entry_type: entry_type, binary: binary} do
      {:ok, ^binary} = LedgerEntryType.encode_xdr(entry_type)
    end

    test "encode_xdr!/1", %{entry_type: entry_type, binary: binary} do
      ^binary = LedgerEntryType.encode_xdr!(entry_type)
    end

    test "decode_xdr/2", %{entry_type: entry_type, binary: binary} do
      {:ok, {^entry_type, ""}} = LedgerEntryType.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = LedgerEntryType.decode_xdr(123)
    end

    test "decode_xdr!/2", %{entry_type: entry_type, binary: binary} do
      {^entry_type, ^binary} = LedgerEntryType.decode_xdr!(binary <> binary)
    end

    test "invalid identifier" do
      {:error, :invalid_key} =
        LedgerEntryType.encode_xdr(%LedgerEntryType{identifier: SECRET_KEY_TYPE_ED25519})
    end
  end
end
