defmodule StellarBase.XDR.AccountEntryTest do
  use ExUnit.Case

  import StellarBase.Test.Utils

  alias StellarBase.StrKey

  alias StellarBase.XDR.{
    AccountEntryExtensionV2,
    AccountEntryExtensionV1Ext,
    AccountEntryExtensionV1,
    AccountEntryExt,
    AccountEntry,
    OptionalAccountID,
    Int64,
    SequenceNumber,
    UInt32,
    String32,
    Thresholds,
    Signers,
    UInt256,
    SignerKey,
    Signer,
    SignerKeyType,
    AccountIDList,
    Liabilities,
    Void,
    Ext
  }

  @types [0, 1, 1]

  describe "AccountEntry" do
    setup do
      account_id = create_account_id("GCNY5OXYSY4FKHOPT2SPOQZAOEIGXB5LBYW3HVU3OWSTQITS65M5RCNY")

      inflation_dest =
        "GBZNLMUQMIN3VGUJISKZU7GNY3O3XLMYEHJCKCSMDHKLGSMKALRXOEZD"
        |> create_account_id()
        |> OptionalAccountID.new()

      signer_type = SignerKeyType.new(:SIGNER_KEY_TYPE_ED25519)
      signer_weight = UInt32.new(2)

      signer =
        "GBQVLZE4XCNDFW2N3SPUG4SI6D6YCDJPI45M5JHWUGHQSAT7REKIGCNQ"
        |> StrKey.decode!(:ed25519_public_key)
        |> UInt256.new()
        |> SignerKey.new(signer_type)
        |> Signer.new(signer_weight)

      balance = Int64.new(5)
      seq_num = SequenceNumber.new(12_345_678)
      num_sub_entries = UInt32.new(5)
      flags = UInt32.new(5)
      home_domain = String32.new("kommit.co")
      thresholds = Thresholds.new(master_weight: 128, low: 16, med: 32, high: 64)
      signers = Signers.new([signer])

      buying = Int64.new(20)
      selling = Int64.new(10)
      liabilities = Liabilities.new(buying, selling)

      account_entry_extension_v1_ext_list =
        [
          %{type: 0, value: Void.new()},
          %{
            type: 2,
            value:
              AccountEntryExtensionV2.new(
                UInt32.new(10),
                UInt32.new(10),
                create_account_id_list(),
                Ext.new()
              )
          }
        ]
        |> Enum.map(fn %{type: type, value: value} ->
          AccountEntryExtensionV1Ext.new(value, type)
        end)

      account_entry_extension_v1_list =
        account_entry_extension_v1_ext_list
        |> Enum.map(fn account_entry_extension_v1_ext ->
          AccountEntryExtensionV1.new(liabilities, account_entry_extension_v1_ext)
        end)

      values = [Void.new()] ++ account_entry_extension_v1_list

      account_entry_ext_list =
        values
        |> Enum.zip(@types)
        |> Enum.map(fn {value, type} ->
          AccountEntryExt.new(value, type)
        end)

      account_entry_list =
        account_entry_ext_list
        |> Enum.map(fn account_entry_ext ->
          AccountEntry.new(
            account_id,
            balance,
            seq_num,
            num_sub_entries,
            inflation_dest,
            flags,
            home_domain,
            thresholds,
            signers,
            account_entry_ext
          )
        end)

      %{
        account_id: account_id,
        balance: balance,
        seq_num: seq_num,
        num_sub_entries: num_sub_entries,
        inflation_dest: inflation_dest,
        flags: flags,
        home_domain: home_domain,
        thresholds: thresholds,
        signers: signers,
        account_entry_ext_list: account_entry_ext_list,
        account_entry_list: account_entry_list,
        binaries: [
          <<0, 0, 0, 0, 155, 142, 186, 248, 150, 56, 85, 29, 207, 158, 164, 247, 67, 32, 113, 16,
            107, 135, 171, 14, 45, 179, 214, 155, 117, 165, 56, 34, 114, 247, 89, 216, 0, 0, 0, 0,
            0, 0, 0, 5, 0, 0, 0, 0, 0, 188, 97, 78, 0, 0, 0, 5, 0, 0, 0, 1, 0, 0, 0, 0, 114, 213,
            178, 144, 98, 27, 186, 154, 137, 68, 149, 154, 124, 205, 198, 221, 187, 173, 152, 33,
            210, 37, 10, 76, 25, 212, 179, 73, 138, 2, 227, 119, 0, 0, 0, 5, 0, 0, 0, 9, 107, 111,
            109, 109, 105, 116, 46, 99, 111, 0, 0, 0, 128, 16, 32, 64, 0, 0, 0, 1, 0, 0, 0, 0, 97,
            85, 228, 156, 184, 154, 50, 219, 77, 220, 159, 67, 114, 72, 240, 253, 129, 13, 47, 71,
            58, 206, 164, 246, 161, 143, 9, 2, 127, 137, 20, 131, 0, 0, 0, 2, 0, 0, 0, 0>>,
          <<0, 0, 0, 0, 155, 142, 186, 248, 150, 56, 85, 29, 207, 158, 164, 247, 67, 32, 113, 16,
            107, 135, 171, 14, 45, 179, 214, 155, 117, 165, 56, 34, 114, 247, 89, 216, 0, 0, 0, 0,
            0, 0, 0, 5, 0, 0, 0, 0, 0, 188, 97, 78, 0, 0, 0, 5, 0, 0, 0, 1, 0, 0, 0, 0, 114, 213,
            178, 144, 98, 27, 186, 154, 137, 68, 149, 154, 124, 205, 198, 221, 187, 173, 152, 33,
            210, 37, 10, 76, 25, 212, 179, 73, 138, 2, 227, 119, 0, 0, 0, 5, 0, 0, 0, 9, 107, 111,
            109, 109, 105, 116, 46, 99, 111, 0, 0, 0, 128, 16, 32, 64, 0, 0, 0, 1, 0, 0, 0, 0, 97,
            85, 228, 156, 184, 154, 50, 219, 77, 220, 159, 67, 114, 72, 240, 253, 129, 13, 47, 71,
            58, 206, 164, 246, 161, 143, 9, 2, 127, 137, 20, 131, 0, 0, 0, 2, 0, 0, 0, 1, 0, 0, 0,
            0, 0, 0, 0, 20, 0, 0, 0, 0, 0, 0, 0, 10, 0, 0, 0, 0>>,
          <<0, 0, 0, 0, 155, 142, 186, 248, 150, 56, 85, 29, 207, 158, 164, 247, 67, 32, 113, 16,
            107, 135, 171, 14, 45, 179, 214, 155, 117, 165, 56, 34, 114, 247, 89, 216, 0, 0, 0, 0,
            0, 0, 0, 5, 0, 0, 0, 0, 0, 188, 97, 78, 0, 0, 0, 5, 0, 0, 0, 1, 0, 0, 0, 0, 114, 213,
            178, 144, 98, 27, 186, 154, 137, 68, 149, 154, 124, 205, 198, 221, 187, 173, 152, 33,
            210, 37, 10, 76, 25, 212, 179, 73, 138, 2, 227, 119, 0, 0, 0, 5, 0, 0, 0, 9, 107, 111,
            109, 109, 105, 116, 46, 99, 111, 0, 0, 0, 128, 16, 32, 64, 0, 0, 0, 1, 0, 0, 0, 0, 97,
            85, 228, 156, 184, 154, 50, 219, 77, 220, 159, 67, 114, 72, 240, 253, 129, 13, 47, 71,
            58, 206, 164, 246, 161, 143, 9, 2, 127, 137, 20, 131, 0, 0, 0, 2, 0, 0, 0, 1, 0, 0, 0,
            0, 0, 0, 0, 20, 0, 0, 0, 0, 0, 0, 0, 10, 0, 0, 0, 2, 0, 0, 0, 10, 0, 0, 0, 10, 0, 0,
            0, 2, 0, 0, 0, 0, 155, 142, 186, 248, 150, 56, 85, 29, 207, 158, 164, 247, 67, 32,
            113, 16, 107, 135, 171, 14, 45, 179, 214, 155, 117, 165, 56, 34, 114, 247, 89, 216, 0,
            0, 0, 0, 114, 213, 178, 144, 98, 27, 186, 154, 137, 68, 149, 154, 124, 205, 198, 221,
            187, 173, 152, 33, 210, 37, 10, 76, 25, 212, 179, 73, 138, 2, 227, 119, 0, 0, 0, 0>>
        ]
      }
    end

    test "new/1", %{
      account_id: account_id,
      balance: balance,
      seq_num: seq_num,
      num_sub_entries: num_sub_entries,
      inflation_dest: inflation_dest,
      flags: flags,
      home_domain: home_domain,
      thresholds: thresholds,
      signers: signers,
      account_entry_ext_list: account_entry_ext_list
    } do
      for account_entry_ext <- account_entry_ext_list,
          do:
            %AccountEntry{
              account_id: ^account_id,
              balance: ^balance,
              seq_num: ^seq_num,
              num_sub_entries: ^num_sub_entries,
              inflation_dest: ^inflation_dest,
              flags: ^flags,
              home_domain: ^home_domain,
              thresholds: ^thresholds,
              signers: ^signers,
              account_entry_ext: ^account_entry_ext
            } =
              AccountEntry.new(
                account_id,
                balance,
                seq_num,
                num_sub_entries,
                inflation_dest,
                flags,
                home_domain,
                thresholds,
                signers,
                account_entry_ext
              )
    end

    test "encode_xdr/1", %{account_entry_list: account_entry_list, binaries: binaries} do
      for {account_entry, binary} <- Enum.zip(account_entry_list, binaries),
          do: {:ok, ^binary} = AccountEntry.encode_xdr(account_entry)
    end

    test "encode_xdr!/1", %{account_entry_list: account_entry_list, binaries: binaries} do
      for {account_entry, binary} <- Enum.zip(account_entry_list, binaries),
          do: ^binary = AccountEntry.encode_xdr!(account_entry)
    end

    test "decode_xdr/1", %{account_entry_list: account_entry_list, binaries: binaries} do
      for {account_entry, binary} <- Enum.zip(account_entry_list, binaries),
          do: {:ok, {^account_entry, ""}} = AccountEntry.decode_xdr(binary)
    end

    test "decode_xdr!/1", %{account_entry_list: account_entry_list, binaries: binaries} do
      for {account_entry, binary} <- Enum.zip(account_entry_list, binaries),
          do: {^account_entry, ""} = AccountEntry.decode_xdr!(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = AccountEntry.decode_xdr(123)
    end
  end

  @spec create_account_id_list() :: AccountIDList.t()
  defp create_account_id_list do
    account_id_1 = create_account_id("GCNY5OXYSY4FKHOPT2SPOQZAOEIGXB5LBYW3HVU3OWSTQITS65M5RCNY")
    account_id_2 = create_account_id("GBZNLMUQMIN3VGUJISKZU7GNY3O3XLMYEHJCKCSMDHKLGSMKALRXOEZD")

    [account_id_1, account_id_2]
    |> AccountIDList.new()
  end
end
