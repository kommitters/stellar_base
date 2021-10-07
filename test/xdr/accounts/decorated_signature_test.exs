defmodule Stellar.XDR.DecoratedSignatureTest do
  use ExUnit.Case

  alias Stellar.XDR.{DecoratedSignature, Signature, SignatureHint}

  describe "DecoratedSignature" do
    setup do
      <<_head::binary-size(52), hint::binary-size(4)>> =
        secret = "SAPVVUQ2G755KGQOOY5A3AGTMWCCQQTJMGSXAUKMFT45OFCL7NCSTRWI"

      hint = SignatureHint.new(hint)
      signature = Signature.new(secret)

      %{
        hint: hint,
        signature: signature,
        decorated_signature: DecoratedSignature.new(hint, signature),
        binary:
          <<84, 82, 87, 73, 0, 0, 0, 56, 83, 65, 80, 86, 86, 85, 81, 50, 71, 55, 53, 53, 75, 71,
            81, 79, 79, 89, 53, 65, 51, 65, 71, 84, 77, 87, 67, 67, 81, 81, 84, 74, 77, 71, 83,
            88, 65, 85, 75, 77, 70, 84, 52, 53, 79, 70, 67, 76, 55, 78, 67, 83, 84, 82, 87, 73>>
      }
    end

    test "new/1", %{hint: hint, signature: signature} do
      %DecoratedSignature{hint: ^hint, signature: ^signature} =
        DecoratedSignature.new(hint, signature)
    end

    test "encode_xdr/1", %{decorated_signature: decorated_signature, binary: binary} do
      {:ok, ^binary} = DecoratedSignature.encode_xdr(decorated_signature)
    end

    test "encode_xdr!/1", %{decorated_signature: decorated_signature, binary: binary} do
      ^binary = DecoratedSignature.encode_xdr!(decorated_signature)
    end

    test "decode_xdr/2", %{decorated_signature: decorated_signature, binary: binary} do
      {:ok, {^decorated_signature, ""}} = DecoratedSignature.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = DecoratedSignature.decode_xdr(1234)
    end

    test "decode_xdr!/2", %{decorated_signature: decorated_signature, binary: binary} do
      {^decorated_signature, ^binary} = DecoratedSignature.decode_xdr!(binary <> binary)
    end
  end
end
