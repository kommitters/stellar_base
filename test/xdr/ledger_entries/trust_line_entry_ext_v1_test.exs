defmodule StellarBase.XDR.TrustLineEntryExtV1Test do
  use ExUnit.Case

  # alias StellarBase.XDR.{
  #   Liabilities,
  #   TrustLineEntryExtV2,
  #   TrustLineEntryExtV1Ext,
  #   TrustLineEntryExtV1,
  #   Void,
  #   Ext,
  #   Int32,
  #   Int64
  # }

  # @base_data [
  #   %{type: 0, value: Void.new()},
  #   %{type: 2, value: TrustLineEntryExtV2.new(Int32.new(10), Ext.new())}
  # ]

  # describe "TrustLineEntryExtV1" do
  #   setup do
  #     buying = Int64.new(20)
  #     selling = Int64.new(10)

  #     trust_line_entry_ext_v1_ext_list =
  #       @base_data
  #       |> Enum.map(fn %{type: type, value: value} -> TrustLineEntryExtV1Ext.new(value, type) end)

  #     liabilities = Liabilities.new(buying, selling)

  #     %{
  #       liabilities: liabilities,
  #       trust_line_entry_ext_v1_ext_list: trust_line_entry_ext_v1_ext_list,
  #       trust_line_entry_ext_v1_list:
  #         Enum.map(trust_line_entry_ext_v1_ext_list, fn trust_line_entry_ext_v1_ext ->
  #           TrustLineEntryExtV1.new(liabilities, trust_line_entry_ext_v1_ext)
  #         end),
  #       binaries: [
  #         <<0, 0, 0, 0, 0, 0, 0, 20, 0, 0, 0, 0, 0, 0, 0, 10, 0, 0, 0, 0>>,
  #         <<0, 0, 0, 0, 0, 0, 0, 20, 0, 0, 0, 0, 0, 0, 0, 10, 0, 0, 0, 2, 0, 0, 0, 10, 0, 0, 0,
  #           0>>
  #       ]
  #     }
  #   end

  #   test "new/1", %{
  #     liabilities: liabilities,
  #     trust_line_entry_ext_v1_ext_list: trust_line_entry_ext_v1_ext_list
  #   } do
  #     for trust_line_entry_ext_v1_ext <- trust_line_entry_ext_v1_ext_list,
  #         do:
  #           %TrustLineEntryExtV1{
  #             liabilities: ^liabilities,
  #             trust_line_entry_ext_v1_ext: ^trust_line_entry_ext_v1_ext
  #           } = TrustLineEntryExtV1.new(liabilities, trust_line_entry_ext_v1_ext)
  #   end

  #   test "encode_xdr/1", %{
  #     trust_line_entry_ext_v1_list: trust_line_entry_ext_v1_list,
  #     binaries: binaries
  #   } do
  #     for {trust_line_entry_ext_v1, binary} <- Enum.zip(trust_line_entry_ext_v1_list, binaries),
  #         do: {:ok, ^binary} = TrustLineEntryExtV1.encode_xdr(trust_line_entry_ext_v1)
  #   end

  #   test "encode_xdr!/1", %{
  #     trust_line_entry_ext_v1_list: trust_line_entry_ext_v1_list,
  #     binaries: binaries
  #   } do
  #     for {trust_line_entry_ext_v1, binary} <- Enum.zip(trust_line_entry_ext_v1_list, binaries),
  #         do: ^binary = TrustLineEntryExtV1.encode_xdr!(trust_line_entry_ext_v1)
  #   end

  #   test "decode_xdr/2", %{
  #     trust_line_entry_ext_v1_list: trust_line_entry_ext_v1_list,
  #     binaries: binaries
  #   } do
  #     for {trust_line_entry_ext_v1, binary} <- Enum.zip(trust_line_entry_ext_v1_list, binaries),
  #         do: {:ok, {^trust_line_entry_ext_v1, ""}} = TrustLineEntryExtV1.decode_xdr(binary)
  #   end

  #   test "decode_xdr/2 with an invalid binary" do
  #     {:error, :not_binary} = TrustLineEntryExtV1.decode_xdr(123)
  #   end

  #   test "decode_xdr!/2", %{
  #     trust_line_entry_ext_v1_list: trust_line_entry_ext_v1_list,
  #     binaries: binaries
  #   } do
  #     for {trust_line_entry_ext_v1, binary} <- Enum.zip(trust_line_entry_ext_v1_list, binaries),
  #         do:
  #           {^trust_line_entry_ext_v1, ^binary} =
  #             TrustLineEntryExtV1.decode_xdr!(binary <> binary)
  #   end
  # end
end
