defmodule StellarBase.XDR.LedgerEntryExtTest do
  use ExUnit.Case

  import StellarBase.Test.Utils

  alias StellarBase.XDR.{
    LedgerEntryExt,
    OptionalAccountID,
    SponsorshipDescriptor,
    LedgerEntryExtensionV1,
    LedgerEntryExtensionV1Ext,
    Void
  }

  describe "LedgerEntryExt" do
    setup do
      account_id =
        "GCNY5OXYSY4FKHOPT2SPOQZAOEIGXB5LBYW3HVU3OWSTQITS65M5RCNY"
        |> create_account_id()
        |> OptionalAccountID.new()

      ext = LedgerEntryExtensionV1Ext.new(Void.new(), 0)
      sponsoring_id = SponsorshipDescriptor.new(account_id)

      ledger_entry_ext_list =
        [
          %{type: 0, value: Void.new()},
          %{
            type: 1,
            value: LedgerEntryExtensionV1.new(sponsoring_id, ext)
          }
        ]
        |> Enum.map(fn %{type: type, value: value} ->
          LedgerEntryExt.new(value, type)
        end)

      %{
        types: [0, 3],
        values: ledger_entry_ext_list,
        binaries: [
          <<0, 0, 0, 0>>,
          <<0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 155, 142, 186, 248, 150, 56, 85, 29, 207, 158,
            164, 247, 67, 32, 113, 16, 107, 135, 171, 14, 45, 179, 214, 155, 117, 165, 56, 34,
            114, 247, 89, 216, 0, 0, 0, 0>>
        ]
      }
    end

    test "new/1", %{types: types, values: values} do
      for {value, type} <- Enum.zip(values, types),
          do: %LedgerEntryExt{value: ^value, type: ^type} = LedgerEntryExt.new(value, type)
    end

    test "encode_xdr/1", %{
      values: ledger_entry_ext_list,
      binaries: binaries
    } do
      for {account_entry_extension_v2_ext, binary} <-
            Enum.zip(ledger_entry_ext_list, binaries),
          do: {:ok, ^binary} = LedgerEntryExt.encode_xdr(account_entry_extension_v2_ext)
    end

    test "encode_xdr!/1", %{
      values: ledger_entry_ext_list,
      binaries: binaries
    } do
      for {account_entry_extension_v2_ext, binary} <-
            Enum.zip(ledger_entry_ext_list, binaries),
          do: ^binary = LedgerEntryExt.encode_xdr!(account_entry_extension_v2_ext)
    end

    test "decode_xdr/1", %{
      values: ledger_entry_ext_list,
      binaries: binaries
    } do
      for {account_entry_extension_v2_ext, binary} <-
            Enum.zip(ledger_entry_ext_list, binaries),
          do: {:ok, {^account_entry_extension_v2_ext, ""}} = LedgerEntryExt.decode_xdr(binary)
    end

    test "decode_xdr!/1", %{
      values: ledger_entry_ext_list,
      binaries: binaries
    } do
      for {account_entry_extension_v2_ext, binary} <-
            Enum.zip(ledger_entry_ext_list, binaries),
          do: {^account_entry_extension_v2_ext, ""} = LedgerEntryExt.decode_xdr!(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = LedgerEntryExt.decode_xdr(123)
    end
  end
end
