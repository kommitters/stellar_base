defmodule StellarBase.XDR.AccountIDListTest do
  use ExUnit.Case

  # import StellarBase.Test.Utils

  # alias StellarBase.XDR.AccountIDList

  # describe "AccountIDList" do
  #   setup do
  #     account_id_1 = create_account_id("GCNY5OXYSY4FKHOPT2SPOQZAOEIGXB5LBYW3HVU3OWSTQITS65M5RCNY")
  #     account_id_2 = create_account_id("GBZNLMUQMIN3VGUJISKZU7GNY3O3XLMYEHJCKCSMDHKLGSMKALRXOEZD")

  #     account_ids = [account_id_1, account_id_2]

  #     %{
  #       account_ids: account_ids,
  #       account_id_list: AccountIDList.new(account_ids),
  #       binary:
  #         <<0, 0, 0, 2, 0, 0, 0, 0, 155, 142, 186, 248, 150, 56, 85, 29, 207, 158, 164, 247, 67,
  #           32, 113, 16, 107, 135, 171, 14, 45, 179, 214, 155, 117, 165, 56, 34, 114, 247, 89,
  #           216, 0, 0, 0, 0, 114, 213, 178, 144, 98, 27, 186, 154, 137, 68, 149, 154, 124, 205,
  #           198, 221, 187, 173, 152, 33, 210, 37, 10, 76, 25, 212, 179, 73, 138, 2, 227, 119>>
  #     }
  #   end

  #   test "new/1", %{account_ids: account_ids} do
  #     %AccountIDList{account_ids: ^account_ids} = AccountIDList.new(account_ids)
  #   end

  #   test "encode_xdr/1", %{account_id_list: account_id_list, binary: binary} do
  #     {:ok, ^binary} = AccountIDList.encode_xdr(account_id_list)
  #   end

  #   test "encode_xdr!/1", %{account_id_list: account_id_list, binary: binary} do
  #     ^binary = AccountIDList.encode_xdr!(account_id_list)
  #   end

  #   test "decode_xdr/1", %{account_id_list: account_id_list, binary: binary} do
  #     {:ok, {^account_id_list, ""}} = AccountIDList.decode_xdr(binary)
  #   end

  #   test "decode_xdr/1 with an invalid binary" do
  #     {:error, :not_binary} = AccountIDList.decode_xdr(123)
  #   end

  #   test "decode_xdr!/1", %{account_id_list: account_id_list, binary: binary} do
  #     {^account_id_list, ""} = AccountIDList.decode_xdr!(binary)
  #   end

  #   test "decode_xdr!/1 with an invalid binary" do
  #     assert_raise XDR.VariableArrayError,
  #                  "The value which you pass through parameters must be a binary value, for example: <<0, 0, 0, 5>>",
  #                  fn -> AccountIDList.decode_xdr!(123) end
  #   end
  # end
end
