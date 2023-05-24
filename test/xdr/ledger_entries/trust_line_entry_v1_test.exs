defmodule StellarBase.XDR.TrustLineEntryV1Test do
  use ExUnit.Case

  alias StellarBase.XDR.{
    Liabilities,
    TrustLineEntryV1,
    Void,
    Int32,
    Int64,
    TrustLineEntryExtensionV2Ext,
    TrustLineEntryExtensionV2,
    TrustLineEntryV1Ext
  }

  @base_data [
    %{type: 0, value: Void.new()},
    %{
      type: 2,
      value:
        TrustLineEntryExtensionV2.new(
          Int32.new(10),
          TrustLineEntryExtensionV2Ext.new(Void.new(), 0)
        )
    }
  ]

  describe "TrustLineEntryV1" do
    setup do
      buying = Int64.new(20)
      selling = Int64.new(10)

      trust_line_entry_v1_ext_list =
        @base_data
        |> Enum.map(fn %{type: type, value: value} -> TrustLineEntryV1Ext.new(value, type) end)

      liabilities = Liabilities.new(buying, selling)

      %{
        liabilities: liabilities,
        trust_line_entry_v1_ext_list: trust_line_entry_v1_ext_list,
        trust_line_entry_v1_list:
          Enum.map(trust_line_entry_v1_ext_list, fn trust_line_entry_v1_ext ->
            TrustLineEntryV1.new(liabilities, trust_line_entry_v1_ext)
          end),
        binaries: [
          <<0, 0, 0, 0, 0, 0, 0, 20, 0, 0, 0, 0, 0, 0, 0, 10, 0, 0, 0, 0>>,
          <<0, 0, 0, 0, 0, 0, 0, 20, 0, 0, 0, 0, 0, 0, 0, 10, 0, 0, 0, 2, 0, 0, 0, 10, 0, 0, 0,
            0>>
        ]
      }
    end

    test "new/1", %{
      liabilities: liabilities,
      trust_line_entry_v1_ext_list: trust_line_entry_v1_ext_list
    } do
      for trust_line_entry_v1_ext <- trust_line_entry_v1_ext_list,
          do:
            %TrustLineEntryV1{
              liabilities: ^liabilities,
              ext: ^trust_line_entry_v1_ext
            } = TrustLineEntryV1.new(liabilities, trust_line_entry_v1_ext)
    end

    test "encode_xdr/1", %{
      trust_line_entry_v1_list: trust_line_entry_v1_list,
      binaries: binaries
    } do
      for {trust_line_entry_v1, binary} <- Enum.zip(trust_line_entry_v1_list, binaries),
          do: {:ok, ^binary} = TrustLineEntryV1.encode_xdr(trust_line_entry_v1)
    end

    test "encode_xdr!/1", %{
      trust_line_entry_v1_list: trust_line_entry_v1_list,
      binaries: binaries
    } do
      for {trust_line_entry_v1, binary} <- Enum.zip(trust_line_entry_v1_list, binaries),
          do: ^binary = TrustLineEntryV1.encode_xdr!(trust_line_entry_v1)
    end

    test "decode_xdr/2", %{
      trust_line_entry_v1_list: trust_line_entry_v1_list,
      binaries: binaries
    } do
      for {trust_line_entry_v1, binary} <- Enum.zip(trust_line_entry_v1_list, binaries),
          do: {:ok, {^trust_line_entry_v1, ""}} = TrustLineEntryV1.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = TrustLineEntryV1.decode_xdr(123)
    end

    test "decode_xdr!/2", %{
      trust_line_entry_v1_list: trust_line_entry_v1_list,
      binaries: binaries
    } do
      for {trust_line_entry_v1, binary} <- Enum.zip(trust_line_entry_v1_list, binaries),
          do: {^trust_line_entry_v1, ^binary} = TrustLineEntryV1.decode_xdr!(binary <> binary)
    end
  end
end
