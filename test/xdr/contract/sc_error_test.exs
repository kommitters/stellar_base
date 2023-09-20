defmodule StellarBase.XDR.SCErrorTest do
  use ExUnit.Case

  alias StellarBase.XDR.{
    SCError,
    SCErrorType,
    SCErrorCode
  }

  setup do
    type = %SCErrorType{identifier: :SCE_AUTH}
    value = %SCErrorCode{identifier: :SCEC_INVALID_ACTION}
    sc_error = SCError.new(value, type)

    %{
      type: type,
      value: value,
      sc_error: sc_error,
      binary: <<0, 0, 0, 9, 0, 0, 0, 6>>
    }
  end

  test "new/2", %{type: type, value: value} do
    %SCError{type: ^type, value: ^value} = SCError.new(value, type)
  end

  test "encode_xdr/1", %{sc_error: sc_error, binary: binary} do
    {:ok, ^binary} = SCError.encode_xdr(sc_error)
  end

  test "encode_xdr!/1", %{sc_error: sc_error, binary: binary} do
    ^binary = SCError.encode_xdr!(sc_error)
  end

  test "decode_xdr/2", %{sc_error: sc_error, binary: binary} do
    {:ok, {^sc_error, ""}} = SCError.decode_xdr(binary)
  end

  test "decode_xdr/2 with an invalid binary" do
    {:error, :not_binary} = SCError.decode_xdr(123)
  end

  test "decode_xdr!/2", %{sc_error: sc_error, binary: binary} do
    {^sc_error, ^binary} = SCError.decode_xdr!(binary <> binary)
  end
end
