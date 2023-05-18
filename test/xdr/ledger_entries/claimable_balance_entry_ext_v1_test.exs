defmodule StellarBase.XDR.ClaimableBalanceEntryExtensionV1Test do
  use ExUnit.Case

  alias StellarBase.XDR.{ClaimableBalanceEntryExtensionV1Ext, Void, Uint32, ClaimableBalanceEntryExtensionV1}

  describe "ClaimableBalanceEntryExtensionV1" do
    setup do
      ext = ClaimableBalanceEntryExtensionV1Ext.new(Void.new(), 0)
      flags = Uint32.new(1)

      %{
        ext: ext,
        flags: flags,
        claimable_balance_entry_ext_v1: ClaimableBalanceEntryExtensionV1.new(ext, flags),
        binary: <<0, 0, 0, 0, 0, 0, 0, 1>>
      }
    end

    test "new/1", %{ext: ext, flags: flags} do
      %ClaimableBalanceEntryExtensionV1{ext: ^ext, flags: ^flags} =
        ClaimableBalanceEntryExtensionV1.new(ext, flags)
    end

    test "encode_xdr/1", %{
      claimable_balance_entry_ext_v1: claimable_balance_entry_ext_v1,
      binary: binary
    } do
      {:ok, ^binary} = ClaimableBalanceEntryExtensionV1.encode_xdr(claimable_balance_entry_ext_v1)
    end

    test "encode_xdr!/1", %{
      claimable_balance_entry_ext_v1: claimable_balance_entry_ext_v1,
      binary: binary
    } do
      ^binary = ClaimableBalanceEntryExtensionV1.encode_xdr!(claimable_balance_entry_ext_v1)
    end

    test "decode_xdr/2", %{
      claimable_balance_entry_ext_v1: claimable_balance_entry_ext_v1,
      binary: binary
    } do
      {:ok, {^claimable_balance_entry_ext_v1, ""}} =
        ClaimableBalanceEntryExtensionV1.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = ClaimableBalanceEntryExtensionV1.decode_xdr(123)
    end

    test "decode_xdr!/2", %{
      claimable_balance_entry_ext_v1: claimable_balance_entry_ext_v1,
      binary: binary
    } do
      {^claimable_balance_entry_ext_v1, ^binary} =
        ClaimableBalanceEntryExtensionV1.decode_xdr!(binary <> binary)
    end
  end
end
