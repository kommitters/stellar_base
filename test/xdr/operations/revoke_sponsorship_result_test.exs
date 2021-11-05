defmodule StellarBase.XDR.Operations.RevokeSponsorshipResultTest do
  use ExUnit.Case

  alias StellarBase.XDR.Void
  alias StellarBase.XDR.Operations.{RevokeSponsorshipResult, RevokeSponsorshipResultCode}

  describe "RevokeSponsorshipResult" do
    setup do
      code = RevokeSponsorshipResultCode.new(:REVOKE_SPONSORSHIP_SUCCESS)

      %{
        code: code,
        value: Void.new(),
        result: RevokeSponsorshipResult.new(Void.new(), code),
        binary: <<0, 0, 0, 0>>
      }
    end

    test "new/1", %{code: code, value: value} do
      %RevokeSponsorshipResult{code: ^code, result: ^value} =
        RevokeSponsorshipResult.new(value, code)
    end

    test "encode_xdr/1", %{result: result, binary: binary} do
      {:ok, ^binary} = RevokeSponsorshipResult.encode_xdr(result)
    end

    test "encode_xdr!/1", %{result: result, binary: binary} do
      ^binary = RevokeSponsorshipResult.encode_xdr!(result)
    end

    test "encode_xdr!/1 with a default value", %{code: code, binary: binary} do
      result = RevokeSponsorshipResult.new("TEST", code)
      ^binary = RevokeSponsorshipResult.encode_xdr!(result)
    end

    test "decode_xdr/2", %{result: result, binary: binary} do
      {:ok, {^result, ""}} = RevokeSponsorshipResult.decode_xdr(binary)
    end

    test "decode_xdr!/2", %{result: result, binary: binary} do
      {^result, ^binary} = RevokeSponsorshipResult.decode_xdr!(binary <> binary)
    end

    test "decode_xdr!/2 an error code" do
      {%RevokeSponsorshipResult{
         code: %RevokeSponsorshipResultCode{identifier: :REVOKE_SPONSORSHIP_NOT_SPONSOR}
       }, ""} = RevokeSponsorshipResult.decode_xdr!(<<255, 255, 255, 254>>)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = RevokeSponsorshipResult.decode_xdr(123)
    end
  end
end
