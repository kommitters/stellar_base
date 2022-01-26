defmodule StellarBase.XDR.DecoratedSignaturesTest do
  use ExUnit.Case

  alias StellarBase.XDR.{DecoratedSignature, DecoratedSignatures, Signature, SignatureHint}

  describe "DecoratedSignatures" do
    setup do
      signatures =
        [
          "SAPVVUQ2G755KGQOOY5A3AGTMWCCQQTJMGSXAUKMFT45OFCL7NCSTRWI",
          "SBVNQLIDS7V3NAOYTATT26QL7Y4S6C2X4YN7PN5FIJ6JUAN4UV4YPLUY"
        ]
        |> Enum.map(fn secret ->
          <<_head::binary-size(52), tail::binary-size(4)>> = secret
          hint = SignatureHint.new(tail)
          signature = Signature.new(secret)

          DecoratedSignature.new(hint, signature)
        end)

      %{
        signatures: signatures,
        decorated_signatures: DecoratedSignatures.new(signatures),
        binary:
          <<0, 0, 0, 2, 84, 82, 87, 73, 0, 0, 0, 56, 83, 65, 80, 86, 86, 85, 81, 50, 71, 55, 53,
            53, 75, 71, 81, 79, 79, 89, 53, 65, 51, 65, 71, 84, 77, 87, 67, 67, 81, 81, 84, 74,
            77, 71, 83, 88, 65, 85, 75, 77, 70, 84, 52, 53, 79, 70, 67, 76, 55, 78, 67, 83, 84,
            82, 87, 73, 80, 76, 85, 89, 0, 0, 0, 56, 83, 66, 86, 78, 81, 76, 73, 68, 83, 55, 86,
            51, 78, 65, 79, 89, 84, 65, 84, 84, 50, 54, 81, 76, 55, 89, 52, 83, 54, 67, 50, 88,
            52, 89, 78, 55, 80, 78, 53, 70, 73, 74, 54, 74, 85, 65, 78, 52, 85, 86, 52, 89, 80,
            76, 85, 89>>
      }
    end

    test "new/1", %{signatures: signatures} do
      %DecoratedSignatures{signatures: ^signatures} = DecoratedSignatures.new(signatures)
    end

    test "encode_xdr/1", %{decorated_signatures: decorated_signatures, binary: binary} do
      {:ok, ^binary} = DecoratedSignatures.encode_xdr(decorated_signatures)
    end

    test "encode_xdr!/1", %{decorated_signatures: decorated_signatures, binary: binary} do
      ^binary = DecoratedSignatures.encode_xdr!(decorated_signatures)
    end

    test "decode_xdr/2", %{decorated_signatures: decorated_signatures, binary: binary} do
      {:ok, {^decorated_signatures, ""}} = DecoratedSignatures.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = DecoratedSignatures.decode_xdr(1234)
    end

    test "decode_xdr!/2", %{decorated_signatures: decorated_signatures, binary: binary} do
      {^decorated_signatures, ^binary} = DecoratedSignatures.decode_xdr!(binary <> binary)
    end
  end
end
