defmodule StellarBase.XDR.SignatureHintTest do
  use ExUnit.Case

  alias StellarBase.XDR.SignatureHint

  describe "Signature" do
    setup do
      hint = "TRWI"

      %{
        hint: hint,
        signature_hint: SignatureHint.new(hint),
        binary: "TRWI"
      }
    end

    test "new/1", %{hint: hint} do
      %SignatureHint{hint: ^hint} = SignatureHint.new(hint)
    end

    test "encode_xdr/1", %{signature_hint: signature_hint, binary: binary} do
      {:ok, ^binary} = SignatureHint.encode_xdr(signature_hint)
    end

    test "encode_xdr!/1", %{signature_hint: signature_hint, binary: binary} do
      ^binary = SignatureHint.encode_xdr!(signature_hint)
    end

    test "decode_xdr/2", %{signature_hint: signature_hint, binary: binary} do
      {:ok, {^signature_hint, ""}} = SignatureHint.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = SignatureHint.decode_xdr(123)
    end

    test "decode_xdr!/2", %{signature_hint: signature_hint, binary: binary} do
      {^signature_hint, ""} = SignatureHint.decode_xdr!(binary)
    end
  end
end
