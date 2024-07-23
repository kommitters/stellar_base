defmodule StellarBase.XDR.LedgerEntryDataTest do
  use ExUnit.Case

  import StellarBase.Test.Utils

  alias StellarBase.XDR.{
    AccountEntry,
    AccountEntryExt,
    AlphaNum4,
    AssetCode4,
    AssetType,
    ContractCodeEntry,
    ContractCodeEntryExt,
    ContractDataDurability,
    ContractDataEntry,
    DataEntry,
    DataValue,
    ExtensionPoint,
    Ext,
    Hash,
    Int32,
    Int64,
    LedgerEntryData,
    LedgerEntryType,
    OfferEntry,
    OptionalAccountID,
    Price,
    SCAddress,
    SCAddressType,
    SCVal,
    SCValType,
    SequenceNumber,
    Signer,
    SignerKey,
    SignerKeyType,
    Signers,
    String32,
    String64,
    Thresholds,
    TrustLineAsset,
    TrustLineEntry,
    TrustLineEntryExt,
    UInt256,
    UInt32,
    VariableOpaque,
    Void
  }

  alias StellarBase.StrKey

  setup do
    ## AccountEntry
    account_id = create_account_id("GCNY5OXYSY4FKHOPT2SPOQZAOEIGXB5LBYW3HVU3OWSTQITS65M5RCNY")
    issuer = create_account_id("GBZNLMUQMIN3VGUJISKZU7GNY3O3XLMYEHJCKCSMDHKLGSMKALRXOEZD")

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
    account_entry_ext = AccountEntryExt.new(Void.new(), 0)

    ## TrutLineEntry

    asset_type = AssetType.new(:ASSET_TYPE_CREDIT_ALPHANUM4)

    asset =
      "BTCN"
      |> AssetCode4.new()
      |> AlphaNum4.new(issuer)
      |> TrustLineAsset.new(asset_type)

    limit = Int64.new(6_000_000)

    trust_line_entry_ext = TrustLineEntryExt.new(Void.new(), 0)

    ## OfferEntry

    seller_id = create_account_id("GCNY5OXYSY4FKHOPT2SPOQZAOEIGXB5LBYW3HVU3OWSTQITS65M5RCNY")
    offer_id = Int64.new(123_456)

    selling =
      create_asset(:alpha_num4,
        code: "BTCN",
        issuer: "GBZNLMUQMIN3VGUJISKZU7GNY3O3XLMYEHJCKCSMDHKLGSMKALRXOEZD"
      )

    buying =
      create_asset(:alpha_num12,
        code: "BTCNEW2021",
        issuer: "GBZNLMUQMIN3VGUJISKZU7GNY3O3XLMYEHJCKCSMDHKLGSMKALRXOEZD"
      )

    amount = Int64.new(5_000_000)
    price = Price.new(Int32.new(1), Int32.new(10))
    ext = Ext.new()

    ## DataEntry

    data_name = String64.new("Test")
    data_value = DataValue.new("GCIZ3GSM5")

    ## ContractCodeEntry

    extension_contract_code_entry = ContractCodeEntryExt.new(Void.new(), 0)
    hash = Hash.new("GCIZ3GSM5XL7OUS4UP64THMDZ7CZ3ZWN")
    code = VariableOpaque.new("GCIZ3GSM5")

    ## ContractDataEntry

    extension_point = ExtensionPoint.new(Void.new(), 0)
    address = Hash.new("CAWIIZPXNRY7X3FKFO4CWJT5DQOSEXQK")
    durability = ContractDataDurability.new()

    contract = SCAddress.new(address, SCAddressType.new(:SC_ADDRESS_TYPE_CONTRACT))
    key = SCVal.new(Int64.new(1), SCValType.new(:SCV_I64))
    val = SCVal.new(Int64.new(1), SCValType.new(:SCV_I64))

    discriminants = [
      %{
        type: LedgerEntryType.new(:ACCOUNT),
        ledger_entry_data:
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
          ),
        binary:
          <<0, 0, 0, 0, 0, 0, 0, 0, 155, 142, 186, 248, 150, 56, 85, 29, 207, 158, 164, 247, 67,
            32, 113, 16, 107, 135, 171, 14, 45, 179, 214, 155, 117, 165, 56, 34, 114, 247, 89,
            216, 0, 0, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 188, 97, 78, 0, 0, 0, 5, 0, 0, 0, 1, 0, 0,
            0, 0, 114, 213, 178, 144, 98, 27, 186, 154, 137, 68, 149, 154, 124, 205, 198, 221,
            187, 173, 152, 33, 210, 37, 10, 76, 25, 212, 179, 73, 138, 2, 227, 119, 0, 0, 0, 5, 0,
            0, 0, 9, 107, 111, 109, 109, 105, 116, 46, 99, 111, 0, 0, 0, 128, 16, 32, 64, 0, 0, 0,
            1, 0, 0, 0, 0, 97, 85, 228, 156, 184, 154, 50, 219, 77, 220, 159, 67, 114, 72, 240,
            253, 129, 13, 47, 71, 58, 206, 164, 246, 161, 143, 9, 2, 127, 137, 20, 131, 0, 0, 0,
            2, 0, 0, 0, 0>>
      },
      %{
        type: LedgerEntryType.new(:TRUSTLINE),
        ledger_entry_data:
          TrustLineEntry.new(account_id, asset, balance, limit, flags, trust_line_entry_ext),
        binary:
          <<0, 0, 0, 1, 0, 0, 0, 0, 155, 142, 186, 248, 150, 56, 85, 29, 207, 158, 164, 247, 67,
            32, 113, 16, 107, 135, 171, 14, 45, 179, 214, 155, 117, 165, 56, 34, 114, 247, 89,
            216, 0, 0, 0, 1, 66, 84, 67, 78, 0, 0, 0, 0, 114, 213, 178, 144, 98, 27, 186, 154,
            137, 68, 149, 154, 124, 205, 198, 221, 187, 173, 152, 33, 210, 37, 10, 76, 25, 212,
            179, 73, 138, 2, 227, 119, 0, 0, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 91, 141, 128, 0, 0,
            0, 5, 0, 0, 0, 0>>
      },
      %{
        type: LedgerEntryType.new(:OFFER),
        ledger_entry_data:
          OfferEntry.new(seller_id, offer_id, selling, buying, amount, price, flags, ext),
        binary:
          <<0, 0, 0, 2, 0, 0, 0, 0, 155, 142, 186, 248, 150, 56, 85, 29, 207, 158, 164, 247, 67,
            32, 113, 16, 107, 135, 171, 14, 45, 179, 214, 155, 117, 165, 56, 34, 114, 247, 89,
            216, 0, 0, 0, 0, 0, 1, 226, 64, 0, 0, 0, 1, 66, 84, 67, 78, 0, 0, 0, 0, 114, 213, 178,
            144, 98, 27, 186, 154, 137, 68, 149, 154, 124, 205, 198, 221, 187, 173, 152, 33, 210,
            37, 10, 76, 25, 212, 179, 73, 138, 2, 227, 119, 0, 0, 0, 2, 66, 84, 67, 78, 69, 87,
            50, 48, 50, 49, 0, 0, 0, 0, 0, 0, 114, 213, 178, 144, 98, 27, 186, 154, 137, 68, 149,
            154, 124, 205, 198, 221, 187, 173, 152, 33, 210, 37, 10, 76, 25, 212, 179, 73, 138, 2,
            227, 119, 0, 0, 0, 0, 0, 76, 75, 64, 0, 0, 0, 1, 0, 0, 0, 10, 0, 0, 0, 5, 0, 0, 0, 0>>
      },
      %{
        type: LedgerEntryType.new(:DATA),
        ledger_entry_data: DataEntry.new(account_id, data_name, data_value, ext),
        binary:
          <<0, 0, 0, 3, 0, 0, 0, 0, 155, 142, 186, 248, 150, 56, 85, 29, 207, 158, 164, 247, 67,
            32, 113, 16, 107, 135, 171, 14, 45, 179, 214, 155, 117, 165, 56, 34, 114, 247, 89,
            216, 0, 0, 0, 4, 84, 101, 115, 116, 0, 0, 0, 9, 71, 67, 73, 90, 51, 71, 83, 77, 53, 0,
            0, 0, 0, 0, 0, 0>>
      },
      %{
        type: LedgerEntryType.new(:CONTRACT_DATA),
        ledger_entry_data: ContractDataEntry.new(extension_point, contract, key, durability, val),
        binary:
          <<0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 1, 67, 65, 87, 73, 73, 90, 80, 88, 78, 82, 89, 55,
            88, 51, 70, 75, 70, 79, 52, 67, 87, 74, 84, 53, 68, 81, 79, 83, 69, 88, 81, 75, 0, 0,
            0, 6, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 1>>
      },
      %{
        type: LedgerEntryType.new(:CONTRACT_CODE),
        ledger_entry_data: ContractCodeEntry.new(extension_contract_code_entry, hash, code),
        binary:
          <<0, 0, 0, 7, 0, 0, 0, 0, 71, 67, 73, 90, 51, 71, 83, 77, 53, 88, 76, 55, 79, 85, 83,
            52, 85, 80, 54, 52, 84, 72, 77, 68, 90, 55, 67, 90, 51, 90, 87, 78, 0, 0, 0, 9, 71,
            67, 73, 90, 51, 71, 83, 77, 53, 0, 0, 0>>
      }
    ]

    %{discriminants: discriminants}
  end

  test "new/1", %{discriminants: discriminants} do
    for %{type: type, ledger_entry_data: ledger_entry_data} <- discriminants do
      %LedgerEntryData{value: ^ledger_entry_data, type: ^type} =
        LedgerEntryData.new(ledger_entry_data, type)
    end
  end

  test "encode_xdr/1", %{discriminants: discriminants} do
    for %{ledger_entry_data: ledger_entry_data, type: type, binary: binary} <- discriminants do
      xdr = LedgerEntryData.new(ledger_entry_data, type)
      {:ok, ^binary} = LedgerEntryData.encode_xdr(xdr)
    end
  end

  test "encode_xdr!/1", %{discriminants: discriminants} do
    for %{ledger_entry_data: ledger_entry_data, type: type, binary: binary} <- discriminants do
      xdr = LedgerEntryData.new(ledger_entry_data, type)
      ^binary = LedgerEntryData.encode_xdr!(xdr)
    end
  end

  test "encode_xdr/1 with an invalid type", %{discriminants: [ledger_entry_data | _rest]} do
    type = LedgerEntryType.new(:NEW_ADDRESS)

    assert_raise XDR.EnumError,
                 "The key which you try to encode doesn't belong to the current declarations",
                 fn ->
                   ledger_entry_data
                   |> LedgerEntryData.new(type)
                   |> LedgerEntryData.encode_xdr()
                 end
  end

  test "decode_xdr/2", %{discriminants: discriminants} do
    for %{ledger_entry_data: ledger_entry_data, type: type, binary: binary} <- discriminants do
      xdr = LedgerEntryData.new(ledger_entry_data, type)
      {:ok, {^xdr, ""}} = LedgerEntryData.decode_xdr(binary)
    end
  end

  test "decode_xdr/2 with an invalid binary" do
    {:error, :not_binary} = LedgerEntryData.decode_xdr(123)
  end

  test "decode_xdr!/2", %{discriminants: discriminants} do
    for %{ledger_entry_data: ledger_entry_data, type: type, binary: binary} <- discriminants do
      xdr = LedgerEntryData.new(ledger_entry_data, type)
      {^xdr, ""} = LedgerEntryData.decode_xdr!(binary)
    end
  end
end
