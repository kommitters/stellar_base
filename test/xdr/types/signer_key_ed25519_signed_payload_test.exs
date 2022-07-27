defmodule StellarBase.XDR.SignerKeyEd25519SignedPayloadTest do
  use ExUnit.Case

  alias StellarBase.XDR.{SignerKeyEd25519SignedPayload, UInt256, VariableOpaque64}

  describe "Ed25519 Signed Payload" do
    setup do
      ed25519 =
        UInt256.new(
          <<18, 27, 249, 51, 160, 215, 152, 50, 153, 222, 53, 177, 115, 224, 92, 243, 51, 242,
            249, 40, 118, 78, 128, 109, 86, 239, 171, 232, 42, 171, 210, 35>>
        )

      payload = VariableOpaque64.new("GCIZ3GSM5")

      %{
        ed25519: ed25519,
        payload: payload,
        signed_payload: SignerKeyEd25519SignedPayload.new(ed25519, payload),
        binary:
          <<18, 27, 249, 51, 160, 215, 152, 50, 153, 222, 53, 177, 115, 224, 92, 243, 51, 242,
            249, 40, 118, 78, 128, 109, 86, 239, 171, 232, 42, 171, 210, 35, 0, 0, 0, 9, 71, 67,
            73, 90, 51, 71, 83, 77, 53, 0, 0, 0>>
      }
    end

    test "new/1", %{ed25519: ed25519, payload: payload} do
      %SignerKeyEd25519SignedPayload{ed25519: ^ed25519, payload: ^payload} =
        SignerKeyEd25519SignedPayload.new(ed25519, payload)
    end

    test "encode_xdr/1", %{signed_payload: signed_payload, binary: binary} do
      {:ok, ^binary} = SignerKeyEd25519SignedPayload.encode_xdr(signed_payload)
    end

    test "encode_xdr!/1", %{signed_payload: signed_payload, binary: binary} do
      ^binary = SignerKeyEd25519SignedPayload.encode_xdr!(signed_payload)
    end

    test "decode_xdr/2", %{signed_payload: signed_payload, binary: binary} do
      {:ok, {^signed_payload, ""}} = SignerKeyEd25519SignedPayload.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = SignerKeyEd25519SignedPayload.decode_xdr(123)
    end

    test "decode_xdr!/2", %{signed_payload: signed_payload, binary: binary} do
      {^signed_payload, ^binary} = SignerKeyEd25519SignedPayload.decode_xdr!(binary <> binary)
    end
  end
end
