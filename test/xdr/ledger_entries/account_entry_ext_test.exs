defmodule StellarBase.XDR.AccountEntryExtTest do
  use ExUnit.Case

  import StellarBase.Test.Utils

  alias StellarBase.XDR.{
    AccountEntryExt,
    AccountEntryExtensionV1,
    AccountEntryExtensionV1Ext,
    AccountEntryExtensionV2,
    AccountEntryExtensionV2Ext,
    AccountEntryExtensionV3,
    ExtensionPoint,
    OptionalAccountID,
    SponsorshipDescriptorList20,
    SponsorshipDescriptor,
    Int64,
    Uint64,
    Liabilities,
    TimePoint,
    Uint32,
    Void
  }

  @types_v1 [0, 1, 1, 1]
  @types_v2 [0, 2, 2]

  describe "AccountEntryExt" do
    setup do
      buying = Int64.new(20)
      selling = Int64.new(10)
      liabilities = Liabilities.new(buying, selling)

      extension_point = ExtensionPoint.new(Void.new(), 0)
      seq_ledger = Uint32.new(10)
      seq_time = TimePoint.new(Uint64.new(12_345))

      account_entry_extension_v2_ext_list =
        [
          %{type: 0, value: Void.new()},
          %{
            type: 3,
            value: AccountEntryExtensionV3.new(extension_point, seq_ledger, seq_time)
          }
        ]
        |> Enum.map(fn %{type: type, value: value} ->
          AccountEntryExtensionV2Ext.new(value, type)
        end)

      account_entry_extension_v2_list =
        account_entry_extension_v2_ext_list
        |> Enum.map(fn account_entry_extension_v2_ext ->
          AccountEntryExtensionV2.new(
            Uint32.new(10),
            Uint32.new(10),
            create_sponsorship_descriptor_list(),
            account_entry_extension_v2_ext
          )
        end)

      values_v2 = [Void.new()] ++ account_entry_extension_v2_list

      account_entry_extension_v1_ext_list =
        values_v2
        |> Enum.zip(@types_v2)
        |> Enum.map(fn {value, type} ->
          AccountEntryExtensionV1Ext.new(value, type)
        end)

      account_entry_extension_v1_list =
        account_entry_extension_v1_ext_list
        |> Enum.map(fn account_entry_extension_v1_ext ->
          AccountEntryExtensionV1.new(liabilities, account_entry_extension_v1_ext)
        end)

      values_v1 = [Void.new()] ++ account_entry_extension_v1_list

      account_entry_ext_list =
        values_v1
        |> Enum.zip(@types_v1)
        |> Enum.map(fn {value, type} ->
          AccountEntryExt.new(value, type)
        end)

      %{
        types: @types_v1,
        values: values_v1,
        account_entry_ext_list: account_entry_ext_list,
        binaries: [
          <<0, 0, 0, 0>>,
          <<0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 20, 0, 0, 0, 0, 0, 0, 0, 10, 0, 0, 0, 0>>,
          <<0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 20, 0, 0, 0, 0, 0, 0, 0, 10, 0, 0, 0, 2, 0, 0, 0, 10,
            0, 0, 0, 10, 0, 0, 0, 2, 0, 0, 0, 1, 0, 0, 0, 0, 155, 142, 186, 248, 150, 56, 85, 29,
            207, 158, 164, 247, 67, 32, 113, 16, 107, 135, 171, 14, 45, 179, 214, 155, 117, 165,
            56, 34, 114, 247, 89, 216, 0, 0, 0, 1, 0, 0, 0, 0, 114, 213, 178, 144, 98, 27, 186,
            154, 137, 68, 149, 154, 124, 205, 198, 221, 187, 173, 152, 33, 210, 37, 10, 76, 25,
            212, 179, 73, 138, 2, 227, 119, 0, 0, 0, 0>>,
          <<0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 20, 0, 0, 0, 0, 0, 0, 0, 10, 0, 0, 0, 2, 0, 0, 0, 10,
            0, 0, 0, 10, 0, 0, 0, 2, 0, 0, 0, 1, 0, 0, 0, 0, 155, 142, 186, 248, 150, 56, 85, 29,
            207, 158, 164, 247, 67, 32, 113, 16, 107, 135, 171, 14, 45, 179, 214, 155, 117, 165,
            56, 34, 114, 247, 89, 216, 0, 0, 0, 1, 0, 0, 0, 0, 114, 213, 178, 144, 98, 27, 186,
            154, 137, 68, 149, 154, 124, 205, 198, 221, 187, 173, 152, 33, 210, 37, 10, 76, 25,
            212, 179, 73, 138, 2, 227, 119, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 10, 0, 0, 0, 0, 0, 0,
            48, 57>>
        ]
      }
    end

    test "new/1", %{types: types, values: values} do
      for {value, type} <- Enum.zip(values, types),
          do: %AccountEntryExt{value: ^value, type: ^type} = AccountEntryExt.new(value, type)
    end

    test "encode_xdr/1", %{account_entry_ext_list: account_entry_ext_list, binaries: binaries} do
      for {account_entry_ext, binary} <- Enum.zip(account_entry_ext_list, binaries),
          do: {:ok, ^binary} = AccountEntryExt.encode_xdr(account_entry_ext)
    end

    test "encode_xdr!/1", %{account_entry_ext_list: account_entry_ext_list, binaries: binaries} do
      for {account_entry_ext, binary} <- Enum.zip(account_entry_ext_list, binaries),
          do: ^binary = AccountEntryExt.encode_xdr!(account_entry_ext)
    end

    test "decode_xdr/1", %{account_entry_ext_list: account_entry_ext_list, binaries: binaries} do
      for {account_entry_ext, binary} <- Enum.zip(account_entry_ext_list, binaries),
          do: {:ok, {^account_entry_ext, ""}} = AccountEntryExt.decode_xdr(binary)
    end

    test "decode_xdr!/1", %{account_entry_ext_list: account_entry_ext_list, binaries: binaries} do
      for {account_entry_ext, binary} <- Enum.zip(account_entry_ext_list, binaries),
          do: {^account_entry_ext, ""} = AccountEntryExt.decode_xdr!(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = AccountEntryExt.decode_xdr(123)
    end
  end

  @spec create_sponsorship_descriptor_list() :: SponsorshipDescriptorList20.t()
  defp create_sponsorship_descriptor_list do
    sponsorship_descriptor_1 =
      "GCNY5OXYSY4FKHOPT2SPOQZAOEIGXB5LBYW3HVU3OWSTQITS65M5RCNY"
      |> create_account_id()
      |> OptionalAccountID.new()
      |> SponsorshipDescriptor.new()

    sponsorship_descriptor_2 =
      "GBZNLMUQMIN3VGUJISKZU7GNY3O3XLMYEHJCKCSMDHKLGSMKALRXOEZD"
      |> create_account_id()
      |> OptionalAccountID.new()
      |> SponsorshipDescriptor.new()

    SponsorshipDescriptorList20.new([sponsorship_descriptor_1, sponsorship_descriptor_2])
  end
end
