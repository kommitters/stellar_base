defmodule StellarBase.XDR.TrustLineEntryExtV2Test do
  use ExUnit.Case

  alias StellarBase.XDR.{Int32, Ext, TrustLineEntryExtV2}

  describe "TrustLineEntryExtV2" do
    setup do
      liquidity_pool_use_count = Int32.new(10)
      ext = Ext.new()

      %{
        liquidity_pool_use_count: liquidity_pool_use_count,
        ext: ext,
        trust_line_entry_ext: TrustLineEntryExtV2.new(liquidity_pool_use_count, ext),
        binary: <<0, 0, 0, 10, 0, 0, 0, 0>>
      }
    end

    test "new/1", %{liquidity_pool_use_count: liquidity_pool_use_count, ext: ext} do
      %TrustLineEntryExtV2{liquidity_pool_use_count: ^liquidity_pool_use_count, ext: ^ext} =
        TrustLineEntryExtV2.new(liquidity_pool_use_count, ext)
    end

    test "encode_xdr/1", %{trust_line_entry_ext: trust_line_entry_ext, binary: binary} do
      {:ok, ^binary} = TrustLineEntryExtV2.encode_xdr(trust_line_entry_ext)
    end

    test "encode_xdr!/1", %{trust_line_entry_ext: trust_line_entry_ext, binary: binary} do
      ^binary = TrustLineEntryExtV2.encode_xdr!(trust_line_entry_ext)
    end

    test "decode_xdr/2", %{trust_line_entry_ext: trust_line_entry_ext, binary: binary} do
      {:ok, {^trust_line_entry_ext, ""}} = TrustLineEntryExtV2.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = TrustLineEntryExtV2.decode_xdr(123)
    end

    test "decode_xdr!/2", %{trust_line_entry_ext: trust_line_entry_ext, binary: binary} do
      {^trust_line_entry_ext, ^binary} = TrustLineEntryExtV2.decode_xdr!(binary <> binary)
    end
  end
end
