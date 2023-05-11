defmodule StellarBase.XDR.TrustLineEntryExtTest do
  use ExUnit.Case

  # alias StellarBase.XDR.{
  #   TrustLineEntryExt,
  #   Void,
  #   TrustLineEntryExtV1,
  #   Liabilities,
  #   TrustLineEntryExtV1Ext,
  #   TrustLineEntryExtV2,
  #   Int32,
  #   Int64,
  #   Ext
  # }

  # @trust_line_entry_ext_v1_ext_types [
  #   %{type: 0, value: Void.new()},
  #   %{type: 2, value: TrustLineEntryExtV2.new(Int32.new(10), Ext.new())}
  # ]

  # @types [0, 1, 1]

  # describe "TrustLineEntryExt" do
  #   setup do
  #     buying = Int64.new(20)
  #     selling = Int64.new(10)
  #     liabilities = Liabilities.new(buying, selling)

  #     trust_line_entry_ext_v1_ext_list =
  #       @trust_line_entry_ext_v1_ext_types
  #       |> Enum.map(fn %{type: type, value: value} -> TrustLineEntryExtV1Ext.new(value, type) end)

  #     trust_line_entry_ext_v1_list =
  #       trust_line_entry_ext_v1_ext_list
  #       |> Enum.map(fn trust_line_entry_ext_v1_ext ->
  #         TrustLineEntryExtV1.new(liabilities, trust_line_entry_ext_v1_ext)
  #       end)

  #     values = [Void.new()] ++ trust_line_entry_ext_v1_list

  #     trust_line_entry_ext_list =
  #       values
  #       |> Enum.zip(@types)
  #       |> Enum.map(fn {value, type} ->
  #         TrustLineEntryExt.new(value, type)
  #       end)

  #     %{
  #       types: @types,
  #       values: values,
  #       trust_line_entry_ext_list: trust_line_entry_ext_list,
  #       binaries: [
  #         <<0, 0, 0, 0>>,
  #         <<0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 20, 0, 0, 0, 0, 0, 0, 0, 10, 0, 0, 0, 0>>,
  #         <<0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 20, 0, 0, 0, 0, 0, 0, 0, 10, 0, 0, 0, 2, 0, 0, 0, 10,
  #           0, 0, 0, 0>>
  #       ]
  #     }
  #   end

  #   test "new/1", %{values: values, types: types} do
  #     for {value, type} <- Enum.zip(values, types),
  #         do: %TrustLineEntryExt{value: ^value, type: ^type} = TrustLineEntryExt.new(value, type)
  #   end

  #   test "encode_xdr/1", %{
  #     trust_line_entry_ext_list: trust_line_entry_ext_list,
  #     binaries: binaries
  #   } do
  #     for {trust_line_entry_ext, binary} <- Enum.zip(trust_line_entry_ext_list, binaries),
  #         do: {:ok, ^binary} = TrustLineEntryExt.encode_xdr(trust_line_entry_ext)
  #   end

  #   test "encode_xdr!/1", %{
  #     trust_line_entry_ext_list: trust_line_entry_ext_list,
  #     binaries: binaries
  #   } do
  #     for {trust_line_entry_ext, binary} <- Enum.zip(trust_line_entry_ext_list, binaries),
  #         do: ^binary = TrustLineEntryExt.encode_xdr!(trust_line_entry_ext)
  #   end

  #   test "decode_xdr/2", %{
  #     trust_line_entry_ext_list: trust_line_entry_ext_list,
  #     binaries: binaries
  #   } do
  #     for {trust_line_entry_ext, binary} <- Enum.zip(trust_line_entry_ext_list, binaries),
  #         do: {:ok, {^trust_line_entry_ext, ""}} = TrustLineEntryExt.decode_xdr(binary)
  #   end

  #   test "decode_xdr/2 with an invalid binary" do
  #     {:error, :not_binary} = TrustLineEntryExt.decode_xdr(123)
  #   end

  #   test "decode_xdr!/2", %{
  #     trust_line_entry_ext_list: trust_line_entry_ext_list,
  #     binaries: binaries
  #   } do
  #     for {trust_line_entry_ex, binary} <- Enum.zip(trust_line_entry_ext_list, binaries),
  #         do: {^trust_line_entry_ex, ^binary} = TrustLineEntryExt.decode_xdr!(binary <> binary)
  #   end
  # end
end
