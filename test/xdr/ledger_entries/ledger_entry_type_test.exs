defmodule StellarBase.XDR.LedgerEntryTypeTest do
  use ExUnit.Case

  alias StellarBase.XDR.LedgerEntryType

  @types [
    :ACCOUNT,
    :TRUSTLINE,
    :OFFER,
    :DATA,
    :CLAIMABLE_BALANCE,
    :LIQUIDITY_POOL,
    :CONTRACT_DATA,
    :CONTRACT_CODE,
    :CONFIG_SETTING
  ]

  @binaries [
    <<0, 0, 0, 0>>,
    <<0, 0, 0, 1>>,
    <<0, 0, 0, 2>>,
    <<0, 0, 0, 3>>,
    <<0, 0, 0, 4>>,
    <<0, 0, 0, 5>>,
    <<0, 0, 0, 6>>,
    <<0, 0, 0, 7>>
  ]

  describe "LedgerEntryType" do
    setup do
      %{
        types: @types,
        results: Enum.map(@types, &LedgerEntryType.new/1),
        binaries: @binaries
      }
    end

    test "new/1", %{types: types} do
      for type <- types,
          do: %LedgerEntryType{identifier: ^type} = LedgerEntryType.new(type)
    end

    test "encode_xdr/1", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: {:ok, ^binary} = LedgerEntryType.encode_xdr(result)
    end

    test "encode_xdr/1 with an invalid type" do
      {:error, :invalid_key} = LedgerEntryType.encode_xdr(%LedgerEntryType{identifier: :TEST})
    end

    test "encode_xdr!/1", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: ^binary = LedgerEntryType.encode_xdr!(result)
    end

    test "decode_xdr/2", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: {:ok, {^result, ""}} = LedgerEntryType.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid declaration" do
      {:error, :invalid_key} = LedgerEntryType.decode_xdr(<<1, 0, 0, 1>>)
    end

    test "decode_xdr!/2", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: {^result, ^binary} = LedgerEntryType.decode_xdr!(binary <> binary)
    end

    test "decode_xdr!/2 with an error type", %{binaries: binaries} do
      for binary <- binaries,
          do: {%LedgerEntryType{identifier: _}, ""} = LedgerEntryType.decode_xdr!(binary)
    end
  end
end
