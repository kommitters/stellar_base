defmodule StellarBase.XDR.ClaimableBalanceEntryExtV1Test do
  use ExUnit.Case

  alias StellarBase.XDR.{Ext, UInt32, ClaimableBalanceEntryExtV1}

  describe "ClaimableBalanceEntryExtV1" do
    setup do
      ext = Ext.new()
      flags = UInt32.new(1)

      %{
        ext: ext,
        flags: flags,
        claimable_balance_entry_ext_v1: ClaimableBalanceEntryExtV1.new(ext, flags),
        binary: <<0, 0, 0, 0, 0, 0, 0, 1>>
      }
    end

    test "new/1", %{ext: ext, flags: flags} do
      %ClaimableBalanceEntryExtV1{ext: ^ext, flags: ^flags} =
        ClaimableBalanceEntryExtV1.new(ext, flags)
    end

    test "encode_xdr/1", %{
      claimable_balance_entry_ext_v1: claimable_balance_entry_ext_v1,
      binary: binary
    } do
      {:ok, ^binary} = ClaimableBalanceEntryExtV1.encode_xdr(claimable_balance_entry_ext_v1)
    end

    test "encode_xdr!/1", %{
      claimable_balance_entry_ext_v1: claimable_balance_entry_ext_v1,
      binary: binary
    } do
      ^binary = ClaimableBalanceEntryExtV1.encode_xdr!(claimable_balance_entry_ext_v1)
    end

    test "decode_xdr/2", %{
      claimable_balance_entry_ext_v1: claimable_balance_entry_ext_v1,
      binary: binary
    } do
      {:ok, {^claimable_balance_entry_ext_v1, ""}} = ClaimableBalanceEntryExtV1.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = ClaimableBalanceEntryExtV1.decode_xdr(123)
    end

    test "decode_xdr!/2", %{
      claimable_balance_entry_ext_v1: claimable_balance_entry_ext_v1,
      binary: binary
    } do
      {^claimable_balance_entry_ext_v1, ^binary} =
        ClaimableBalanceEntryExtV1.decode_xdr!(binary <> binary)
    end
  end
end
