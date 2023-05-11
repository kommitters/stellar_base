defmodule StellarBase.XDR.AccountEntryExtensionV3Test do
  use ExUnit.Case

  alias StellarBase.XDR.{
    AccountEntryExtensionV3,
    ExtensionPoint,
    TimePoint,
    Uint32,
    Void
  }

  describe "AccountEntryExtensionV3" do
    setup do
      extension_point = ExtensionPoint.new(Void.new(), 0)
      seq_ledger = Uint32.new(10)
      seq_time = TimePoint.new(12_345)

      %{
        ext: extension_point,
        seq_ledger: seq_ledger,
        seq_time: seq_time,
        account_entry_extension_v3:
          AccountEntryExtensionV3.new(extension_point, seq_ledger, seq_time),
        binary: <<0, 0, 0, 0, 0, 0, 0, 10, 0, 0, 0, 0, 0, 0, 48, 57>>
      }
    end

    test "new/1", %{ext: extension_point, seq_ledger: seq_ledger, seq_time: seq_time} do
      %AccountEntryExtensionV3{
        ext: ^extension_point,
        seq_ledger: ^seq_ledger,
        seq_time: ^seq_time
      } = AccountEntryExtensionV3.new(extension_point, seq_ledger, seq_time)
    end

    test "encode_xdr/1", %{account_entry_extension_v3: account_entry_extension_v3, binary: binary} do
      {:ok, ^binary} = AccountEntryExtensionV3.encode_xdr(account_entry_extension_v3)
    end

    test "encode_xdr!/1", %{
      account_entry_extension_v3: account_entry_extension_v3,
      binary: binary
    } do
      ^binary = AccountEntryExtensionV3.encode_xdr!(account_entry_extension_v3)
    end

    test "decode_xdr/2", %{account_entry_extension_v3: account_entry_extension_v3, binary: binary} do
      {:ok, {^account_entry_extension_v3, ""}} = AccountEntryExtensionV3.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = AccountEntryExtensionV3.decode_xdr(123)
    end

    test "decode_xdr!/2", %{
      account_entry_extension_v3: account_entry_extension_v3,
      binary: binary
    } do
      {^account_entry_extension_v3, ^binary} =
        AccountEntryExtensionV3.decode_xdr!(binary <> binary)
    end
  end
end
