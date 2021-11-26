defmodule StellarBase.XDR.AccountEntryExtensionV2Test do
  use ExUnit.Case

  import StellarBase.Test.Utils

  alias StellarBase.XDR.{
    UInt32,
    Ext,
    AccountEntryExtensionV2,
    AccountIDList
  }

  describe "AccountEntryExtensionV2" do
    setup do
      num_sponsored = UInt32.new(5)
      num_sponsoring = UInt32.new(5)
      signer_sponsoring_ids = create_account_id_list()
      ext = Ext.new()

      account_extension =
        AccountEntryExtensionV2.new(num_sponsored, num_sponsoring, signer_sponsoring_ids, ext)

      %{
        num_sponsored: num_sponsored,
        num_sponsoring: num_sponsoring,
        ext: ext,
        signer_sponsoring_ids: signer_sponsoring_ids,
        account_extension: account_extension,
        binary:
          <<0, 0, 0, 5, 0, 0, 0, 5, 0, 0, 0, 2, 0, 0, 0, 0, 155, 142, 186, 248, 150, 56, 85, 29,
            207, 158, 164, 247, 67, 32, 113, 16, 107, 135, 171, 14, 45, 179, 214, 155, 117, 165,
            56, 34, 114, 247, 89, 216, 0, 0, 0, 0, 114, 213, 178, 144, 98, 27, 186, 154, 137, 68,
            149, 154, 124, 205, 198, 221, 187, 173, 152, 33, 210, 37, 10, 76, 25, 212, 179, 73,
            138, 2, 227, 119, 0, 0, 0, 0>>
      }
    end

    test "new/1", %{
      num_sponsored: num_sponsored,
      num_sponsoring: num_sponsoring,
      ext: ext,
      signer_sponsoring_ids: signer_sponsoring_ids,
      account_extension: account_extension
    } do
      %AccountEntryExtensionV2{
        num_sponsored: ^num_sponsored,
        num_sponsoring: ^num_sponsoring,
        signer_sponsoring_ids: ^signer_sponsoring_ids,
        ext: ^ext
      } = account_extension
    end

    test "encode_xdr/1", %{account_extension: account_extension, binary: binary} do
      {:ok, ^binary} = AccountEntryExtensionV2.encode_xdr(account_extension)
    end

    test "encode_xdr!/1", %{account_extension: account_extension, binary: binary} do
      ^binary = AccountEntryExtensionV2.encode_xdr!(account_extension)
    end

    test "decode_xdr/1", %{
      binary: binary,
      account_extension: account_extension
    } do
      {:ok, {^account_extension, ""}} = AccountEntryExtensionV2.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = AccountEntryExtensionV2.decode_xdr(123)
    end

    test "decode_xdr!/1", %{
      binary: binary,
      account_extension: account_extension
    } do
      {^account_extension, _rest} = AccountEntryExtensionV2.decode_xdr!(binary)
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
