defmodule StellarBase.XDR.TrustLineFlagsTest do
  use ExUnit.Case

  alias StellarBase.XDR.TrustLineFlags

  @identifiers [
    :AUTHORIZED_FLAG,
    :AUTHORIZED_TO_MAINTAIN_LIABILITIES_FLAG,
    :TRUSTLINE_CLAWBACK_ENABLED_FLAG
  ]

  @binaries [
    <<0, 0, 0, 1>>,
    <<0, 0, 0, 2>>,
    <<0, 0, 0, 4>>
  ]

  describe "TrustLineFlags" do
    setup do
      %{
        identifiers: @identifiers,
        operation_types:
          @identifiers |> Enum.map(fn identifier -> TrustLineFlags.new(identifier) end),
        binaries: @binaries
      }
    end

    test "new/1", %{identifiers: types} do
      for type <- types, do: %TrustLineFlags{identifier: ^type} = TrustLineFlags.new(type)
    end

    test "new/1 with an invalid type" do
      %TrustLineFlags{identifier: nil} = TrustLineFlags.new(nil)
    end

    test "encode_xdr/1", %{operation_types: operation_types, binaries: binaries} do
      for {operation_type, binary} <- Enum.zip(operation_types, binaries),
          do: {:ok, ^binary} = TrustLineFlags.encode_xdr(operation_type)
    end

    test "encode_xdr/1 with an invalid identifier" do
      {:error, :invalid_key} =
        TrustLineFlags.encode_xdr(%TrustLineFlags{identifier: :INDEFINITE_THRESHOLD})
    end

    test "encode_xdr!/1", %{operation_types: operation_types, binaries: binaries} do
      for {operation_type, binary} <- Enum.zip(operation_types, binaries),
          do: ^binary = TrustLineFlags.encode_xdr!(operation_type)
    end

    test "decode_xdr/2", %{operation_types: operation_types, binaries: binaries} do
      for {operation_type, binary} <- Enum.zip(operation_types, binaries),
          do: {:ok, {^operation_type, ""}} = TrustLineFlags.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid declaration" do
      {:error, :invalid_key} = TrustLineFlags.decode_xdr(<<1, 0, 0, 1>>)
    end

    test "decode_xdr!/2", %{operation_types: operation_types, binaries: binaries} do
      for {operation_type, binary} <- Enum.zip(operation_types, binaries),
          do: {^operation_type, ^binary} = TrustLineFlags.decode_xdr!(binary <> binary)
    end

    test "decode_xdr!/2 with an error code", %{binaries: binaries} do
      for binary <- binaries,
          do: {%TrustLineFlags{identifier: _}, ""} = TrustLineFlags.decode_xdr!(binary)
    end
  end
end
