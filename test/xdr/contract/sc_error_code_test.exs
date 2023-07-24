defmodule StellarBase.XDR.SCErrorCodeTest do
  use ExUnit.Case

  alias StellarBase.XDR.SCErrorCode

  setup do
    type = :SCEC_ARITH_DOMAIN
    sc_error_code = SCErrorCode.new(type)

    %{
      type: type,
      sc_error_code: sc_error_code
    }
  end

  test "new/1", %{type: type} do
    %SCErrorCode{identifier: ^type} = SCErrorCode.new(type)
  end

  test "encode_xdr/1", %{type: type} do
    {:ok, <<0, 0, 0, 0>>} = type |> SCErrorCode.new() |> SCErrorCode.encode_xdr()
  end

  test "encode_xdr!/1", %{type: type} do
    <<0, 0, 0, 0>> = type |> SCErrorCode.new() |> SCErrorCode.encode_xdr!()
  end

  test "decode_xdr/2", %{sc_error_code: sc_error_code} do
    {:ok, {^sc_error_code, ""}} = SCErrorCode.decode_xdr(SCErrorCode.encode_xdr!(sc_error_code))
  end

  test "decode_xdr!/2", %{sc_error_code: sc_error_code} do
    {^sc_error_code, ""} = SCErrorCode.decode_xdr!(SCErrorCode.encode_xdr!(sc_error_code))
  end

  test "decode_xdr!/2 with an invalid binary" do
    {:error, :not_binary} = SCErrorCode.decode_xdr(123)
  end
end
