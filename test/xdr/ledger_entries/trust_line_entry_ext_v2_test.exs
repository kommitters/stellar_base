defmodule StellarBase.XDR.TrustLineEntryExtensionV2Test do
  use ExUnit.Case

  alias StellarBase.XDR.{Int32, TrustLineEntryExtensionV2Ext, TrustLineEntryExtensionV2, Void}

  describe "TrustLineEntryExtensionV2" do
    setup do
      liquidity_pool_use_count = Int32.new(10)
      ext = TrustLineEntryExtensionV2Ext.new(Void.new(), 0)

      %{
        liquidity_pool_use_count: liquidity_pool_use_count,
        ext: ext,
        trust_line_entry_ext: TrustLineEntryExtensionV2.new(liquidity_pool_use_count, ext),
        binary: <<0, 0, 0, 10, 0, 0, 0, 0>>
      }
    end

    test "new/1", %{liquidity_pool_use_count: liquidity_pool_use_count, ext: ext} do
      %TrustLineEntryExtensionV2{liquidity_pool_use_count: ^liquidity_pool_use_count, ext: ^ext} =
        TrustLineEntryExtensionV2.new(liquidity_pool_use_count, ext)
    end

    test "encode_xdr/1", %{trust_line_entry_ext: trust_line_entry_ext, binary: binary} do
      {:ok, ^binary} = TrustLineEntryExtensionV2.encode_xdr(trust_line_entry_ext)
    end

    test "encode_xdr!/1", %{trust_line_entry_ext: trust_line_entry_ext, binary: binary} do
      ^binary = TrustLineEntryExtensionV2.encode_xdr!(trust_line_entry_ext)
    end

    test "decode_xdr/2", %{trust_line_entry_ext: trust_line_entry_ext, binary: binary} do
      {:ok, {^trust_line_entry_ext, ""}} = TrustLineEntryExtensionV2.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = TrustLineEntryExtensionV2.decode_xdr(123)
    end

    test "decode_xdr!/2", %{trust_line_entry_ext: trust_line_entry_ext, binary: binary} do
      {^trust_line_entry_ext, ^binary} = TrustLineEntryExtensionV2.decode_xdr!(binary <> binary)
    end
  end
end
