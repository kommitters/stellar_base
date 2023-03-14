# defmodule StellarBase.XDR.SCVecTest do
#   use ExUnit.Case

#   alias StellarBase.XDR.{
#     SCVec
#   }

#   describe "SCVec" do
#     setup do
#       claimants_list = [claimant1, claimant2]

#       %{
#         claimants_list: claimants_list,
#         claimants: SCVec.new(claimants_list),
#         binary: nil
#       }
#     end

#     test "new/1", %{claimants_list: claimants_list} do
#       %SCVec{claimants: ^claimants_list} = SCVec.new(claimants_list)
#     end

#     test "encode_xdr/1", %{claimants: claimants, binary: binary} do
#       {:ok, ^binary} = SCVec.encode_xdr(claimants)
#     end

#     test "encode_xdr/1 with invalid elements" do
#       {:error, :not_list} =
#         %{elements: nil}
#         |> SCVec.new()
#         |> SCVec.encode_xdr()
#     end

#     test "encode_xdr!/1", %{claimants: claimants, binary: binary} do
#       ^binary = SCVec.encode_xdr!(claimants)
#     end

#     test "decode_xdr/2", %{claimants: claimants, binary: binary} do
#       {:ok, {^claimants, ""}} = SCVec.decode_xdr(binary)
#     end

#     test "decode_xdr/2 with an invalid binary" do
#       {:error, :not_binary} = SCVec.decode_xdr(123)
#     end

#     test "decode_xdr!/2", %{claimants: claimants, binary: binary} do
#       {^claimants, ^binary} = SCVec.decode_xdr!(binary <> binary)
#     end
#   end
# end
