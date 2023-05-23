defmodule StellarBase.XDR.AccountEntryExtensionV2Test do
  use ExUnit.Case

  import StellarBase.Test.Utils

  alias StellarBase.XDR.{
    Uint32,
    AccountEntryExtensionV2,
    AccountEntryExtensionV2Ext,
    AccountEntryExtensionV3,
    SponsorshipDescriptorList20,
    SponsorshipDescriptor,
    ExtensionPoint,
    Uint32,
    Uint64,
    TimePoint,
    Void
  }

  describe "AccountEntryExtensionV2" do
    setup do
      num_sponsored = Uint32.new(5)
      num_sponsoring = Uint32.new(5)
      signer_sponsoring_ids = create_sponsorship_descriptor_list()

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
            num_sponsored,
            num_sponsoring,
            signer_sponsoring_ids,
            account_entry_extension_v2_ext
          )
        end)

      %{
        num_sponsored: num_sponsored,
        num_sponsoring: num_sponsoring,
        signer_sponsoring_ids: signer_sponsoring_ids,
        account_entry_extension_v2_ext_list: account_entry_extension_v2_ext_list,
        account_entry_extension_v2_list: account_entry_extension_v2_list,
        binaries: [
          <<0, 0, 0, 5, 0, 0, 0, 5, 0, 0, 0, 2, 0, 0, 0, 1, 0, 0, 0, 0, 155, 142, 186, 248, 150,
            56, 85, 29, 207, 158, 164, 247, 67, 32, 113, 16, 107, 135, 171, 14, 45, 179, 214, 155,
            117, 165, 56, 34, 114, 247, 89, 216, 0, 0, 0, 1, 0, 0, 0, 0, 114, 213, 178, 144, 98,
            27, 186, 154, 137, 68, 149, 154, 124, 205, 198, 221, 187, 173, 152, 33, 210, 37, 10,
            76, 25, 212, 179, 73, 138, 2, 227, 119, 0, 0, 0, 0>>,
          <<0, 0, 0, 5, 0, 0, 0, 5, 0, 0, 0, 2, 0, 0, 0, 1, 0, 0, 0, 0, 155, 142, 186, 248, 150,
            56, 85, 29, 207, 158, 164, 247, 67, 32, 113, 16, 107, 135, 171, 14, 45, 179, 214, 155,
            117, 165, 56, 34, 114, 247, 89, 216, 0, 0, 0, 1, 0, 0, 0, 0, 114, 213, 178, 144, 98,
            27, 186, 154, 137, 68, 149, 154, 124, 205, 198, 221, 187, 173, 152, 33, 210, 37, 10,
            76, 25, 212, 179, 73, 138, 2, 227, 119, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 10, 0, 0, 0,
            0, 0, 0, 48, 57>>
        ]
      }
    end

    test "new/1", %{
      num_sponsored: num_sponsored,
      num_sponsoring: num_sponsoring,
      signer_sponsoring_ids: signer_sponsoring_ids,
      account_entry_extension_v2_ext_list: account_entry_extension_v2_ext_list
    } do
      for account_entry_extension_v2_ext <- account_entry_extension_v2_ext_list,
          do:
            %AccountEntryExtensionV2{
              num_sponsored: ^num_sponsored,
              num_sponsoring: ^num_sponsoring,
              signer_sponsoring_i_ds: ^signer_sponsoring_ids,
              ext: ^account_entry_extension_v2_ext
            } =
              AccountEntryExtensionV2.new(
                num_sponsored,
                num_sponsoring,
                signer_sponsoring_ids,
                account_entry_extension_v2_ext
              )
    end

    test "encode_xdr/1", %{
      account_entry_extension_v2_list: account_entry_extension_v2_list,
      binaries: binaries
    } do
      for {account_entry_extension_v2, binary} <-
            Enum.zip(account_entry_extension_v2_list, binaries),
          do: {:ok, ^binary} = AccountEntryExtensionV2.encode_xdr(account_entry_extension_v2)
    end

    test "encode_xdr!/1", %{
      account_entry_extension_v2_list: account_entry_extension_v2_list,
      binaries: binaries
    } do
      for {account_entry_extension_v2, binary} <-
            Enum.zip(account_entry_extension_v2_list, binaries),
          do: ^binary = AccountEntryExtensionV2.encode_xdr!(account_entry_extension_v2)
    end

    test "decode_xdr/1", %{
      account_entry_extension_v2_list: account_entry_extension_v2_list,
      binaries: binaries
    } do
      for {account_entry_extension_v2, binary} <-
            Enum.zip(account_entry_extension_v2_list, binaries),
          do:
            {:ok, {^account_entry_extension_v2, ""}} = AccountEntryExtensionV2.decode_xdr(binary)
    end

    test "decode_xdr!/1", %{
      account_entry_extension_v2_list: account_entry_extension_v2_list,
      binaries: binaries
    } do
      for {account_entry_extension_v2, binary} <-
            Enum.zip(account_entry_extension_v2_list, binaries),
          do: {^account_entry_extension_v2, ""} = AccountEntryExtensionV2.decode_xdr!(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = AccountEntryExtensionV2.decode_xdr(123)
    end
  end

  @spec create_sponsorship_descriptor_list() :: SponsorshipDescriptorList20.t()
  defp create_sponsorship_descriptor_list do
    sponsorship_descriptor_1 =
      "GCNY5OXYSY4FKHOPT2SPOQZAOEIGXB5LBYW3HVU3OWSTQITS65M5RCNY"
      |> create_account_id()
      |> SponsorshipDescriptor.new()

    sponsorship_descriptor_2 =
      "GBZNLMUQMIN3VGUJISKZU7GNY3O3XLMYEHJCKCSMDHKLGSMKALRXOEZD"
      |> create_account_id()
      |> SponsorshipDescriptor.new()

    SponsorshipDescriptorList20.new([sponsorship_descriptor_1, sponsorship_descriptor_2])
  end
end
