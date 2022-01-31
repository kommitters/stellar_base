defmodule StellarBase.XDR.AccountFlagsTest do
  use ExUnit.Case

  alias StellarBase.XDR.AccountFlags

  @identifiers [
    :AUTH_REQUIRED_FLAG,
    :AUTH_REVOCABLE_FLAG,
    :AUTH_IMMUTABLE_FLAG,
    :AUTH_CLAWBACK_ENABLED_FLAG
  ]

  @binaries [
    <<0, 0, 0, 1>>,
    <<0, 0, 0, 2>>,
    <<0, 0, 0, 4>>,
    <<0, 0, 0, 8>>
  ]

  describe "AccountFlags" do
    setup do
      %{
        identifiers: @identifiers,
        operation_types:
          @identifiers |> Enum.map(fn identifier -> AccountFlags.new(identifier) end),
        binaries: @binaries
      }
    end

    test "new/1", %{identifiers: types} do
      for type <- types, do: %AccountFlags{identifier: ^type} = AccountFlags.new(type)
    end

    test "new/1 with an invalid type" do
      %AccountFlags{identifier: nil} = AccountFlags.new(nil)
    end

    test "encode_xdr/1", %{operation_types: operation_types, binaries: binaries} do
      for {operation_type, binary} <- Enum.zip(operation_types, binaries),
          do: {:ok, ^binary} = AccountFlags.encode_xdr(operation_type)
    end

    test "encode_xdr/1 with an invalid identifier" do
      {:error, :invalid_key} =
        AccountFlags.encode_xdr(%AccountFlags{identifier: :INDEFINITE_THRESHOLD})
    end

    test "encode_xdr!/1", %{operation_types: operation_types, binaries: binaries} do
      for {operation_type, binary} <- Enum.zip(operation_types, binaries),
          do: ^binary = AccountFlags.encode_xdr!(operation_type)
    end

    test "decode_xdr/2", %{operation_types: operation_types, binaries: binaries} do
      for {operation_type, binary} <- Enum.zip(operation_types, binaries),
          do: {:ok, {^operation_type, ""}} = AccountFlags.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid declaration" do
      {:error, :invalid_key} = AccountFlags.decode_xdr(<<1, 0, 0, 1>>)
    end

    test "decode_xdr!/2", %{operation_types: operation_types, binaries: binaries} do
      for {operation_type, binary} <- Enum.zip(operation_types, binaries),
          do: {^operation_type, ^binary} = AccountFlags.decode_xdr!(binary <> binary)
    end

    test "decode_xdr!/2 with an error code", %{binaries: binaries} do
      for binary <- binaries,
          do: {%AccountFlags{identifier: _}, ""} = AccountFlags.decode_xdr!(binary)
    end
  end
end
