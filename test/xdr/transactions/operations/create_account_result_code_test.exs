defmodule StellarBase.XDR.CreateAccountResultCodeTest do
  use ExUnit.Case

  alias StellarBase.XDR.CreateAccountResultCode

  @codes [
    :CREATE_ACCOUNT_SUCCESS,
    :CREATE_ACCOUNT_MALFORMED,
    :CREATE_ACCOUNT_UNDERFUNDED,
    :CREATE_ACCOUNT_LOW_RESERVE,
    :CREATE_ACCOUNT_ALREADY_EXIST
  ]

  @binaries [
    <<0, 0, 0, 0>>,
    <<255, 255, 255, 255>>,
    <<255, 255, 255, 254>>,
    <<255, 255, 255, 253>>,
    <<255, 255, 255, 252>>
  ]

  describe "CreateAccountResultCode" do
    setup do
      %{
        codes: @codes,
        results: @codes |> Enum.map(fn code -> CreateAccountResultCode.new(code) end),
        binaries: @binaries
      }
    end

    test "new/1", %{codes: types} do
      for type <- types,
          do: %CreateAccountResultCode{identifier: ^type} = CreateAccountResultCode.new(type)
    end

    test "encode_xdr/1", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: {:ok, ^binary} = CreateAccountResultCode.encode_xdr(result)
    end

    test "encode_xdr/1 with an invalid code" do
      {:error, :invalid_key} =
        CreateAccountResultCode.encode_xdr(%CreateAccountResultCode{identifier: :TEST})
    end

    test "encode_xdr!/1", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: ^binary = CreateAccountResultCode.encode_xdr!(result)
    end

    test "decode_xdr/2", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: {:ok, {^result, ""}} = CreateAccountResultCode.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid declaration" do
      {:error, :invalid_key} = CreateAccountResultCode.decode_xdr(<<1, 0, 0, 1>>)
    end

    test "decode_xdr!/2", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: {^result, ^binary} = CreateAccountResultCode.decode_xdr!(binary <> binary)
    end

    test "decode_xdr!/2 with an error code", %{binaries: binaries} do
      for binary <- binaries,
          do:
            {%CreateAccountResultCode{identifier: _}, ""} =
              CreateAccountResultCode.decode_xdr!(binary)
    end
  end
end
