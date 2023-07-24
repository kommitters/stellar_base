defmodule StellarBase.XDR.SCErrorTypeTest do
  use ExUnit.Case

  alias StellarBase.XDR.SCErrorType

  setup do
    type = :SCE_CONTRACT
    sc_error_type = SCErrorType.new(type)

    %{
      type: type,
      sc_error_type: sc_error_type
    }
  end

  test "new/1", %{type: type} do
    %SCErrorType{identifier: ^type} = SCErrorType.new(type)
  end

  test "encode_xdr/1", %{type: type} do
    {:ok, <<0, 0, 0, 0>>} = type |> SCErrorType.new() |> SCErrorType.encode_xdr()
  end

  test "encode_xdr!/1", %{type: type} do
    <<0, 0, 0, 0>> = type |> SCErrorType.new() |> SCErrorType.encode_xdr!()
  end

  test "decode_xdr/2", %{sc_error_type: sc_error_type} do
    {:ok, {^sc_error_type, ""}} = SCErrorType.decode_xdr(SCErrorType.encode_xdr!(sc_error_type))
  end

  test "decode_xdr!/2", %{sc_error_type: sc_error_type} do
    {^sc_error_type, ""} = SCErrorType.decode_xdr!(SCErrorType.encode_xdr!(sc_error_type))
  end

  test "decode_xdr!/2 with an invalid binary" do
    {:error, :not_binary} = SCErrorType.decode_xdr(123)
  end
end
