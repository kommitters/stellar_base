defmodule StellarBase.XDR.ClaimableBalanceEntryExtTest do
  use ExUnit.Case

  # alias StellarBase.XDR.{Void, ClaimableBalanceEntryExtensionV1, ClaimableBalanceEntryExt, ClaimableBalanceEntryExtensionV1Ext, Uint32}

  # @arms [
  #   %{type: 0, value: Void.new()},
  #   %{type: 1, value: ClaimableBalanceEntryExtensionV1.new(ClaimableBalanceEntryExtensionV1Ext.new(), Uint32.new(1))}
  # ]

  # @types [0, 1]

  # describe "ClaimableBalanceEntryExt" do
  #   setup do
  #     values =
  #       @arms
  #       |> Enum.map(fn %{type: type, value: value} ->
  #         ClaimableBalanceEntryExt.new(value, type)
  #       end)

  #     %{
  #       values: values,
  #       types: @types,
  #       binaries: [<<0, 0, 0, 0>>, <<0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1>>]
  #     }
  #   end

  #   test "new/1", %{values: values, types: types} do
  #     for {value, type} <- Enum.zip(values, types),
  #         do:
  #           %ClaimableBalanceEntryExt{value: ^value, type: ^type} =
  #             ClaimableBalanceEntryExt.new(value, type)
  #   end

  #   test "encode_xdr/1", %{values: values, binaries: binaries} do
  #     for {value, binary} <- Enum.zip(values, binaries),
  #         do: {:ok, ^binary} = ClaimableBalanceEntryExt.encode_xdr(value)
  #   end

  #   test "encode_xdr!/1", %{values: values, binaries: binaries} do
  #     for {value, binary} <- Enum.zip(values, binaries),
  #         do: ^binary = ClaimableBalanceEntryExt.encode_xdr!(value)
  #   end

  #   test "decode_xdr/2", %{values: values, binaries: binaries} do
  #     for {value, binary} <- Enum.zip(values, binaries),
  #         do: {:ok, {^value, ""}} = ClaimableBalanceEntryExt.decode_xdr(binary)
  #   end

  #   test "decode_xdr/2 with an invalid binary" do
  #     {:error, :not_binary} = ClaimableBalanceEntryExt.decode_xdr(123)
  #   end

  #   test "decode_xdr!/2", %{values: values, binaries: binaries} do
  #     for {value, binary} <- Enum.zip(values, binaries),
  #         do: {^value, ^binary} = ClaimableBalanceEntryExt.decode_xdr!(binary <> binary)
  #   end
  # end
end
