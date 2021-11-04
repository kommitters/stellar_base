defmodule StellarBase.XDR.SignatureTest do
  use ExUnit.Case

  alias StellarBase.XDR.Signature

  describe "Signature" do
    setup do
      secret = "SAPVVUQ2G755KGQOOY5A3AGTMWCCQQTJMGSXAUKMFT45OFCL7NCSTRWI"

      %{
        secret: secret,
        signature: Signature.new(secret),
        binary:
          <<0, 0, 0, 56, 83, 65, 80, 86, 86, 85, 81, 50, 71, 55, 53, 53, 75, 71, 81, 79, 79, 89,
            53, 65, 51, 65, 71, 84, 77, 87, 67, 67, 81, 81, 84, 74, 77, 71, 83, 88, 65, 85, 75,
            77, 70, 84, 52, 53, 79, 70, 67, 76, 55, 78, 67, 83, 84, 82, 87, 73>>
      }
    end

    test "new/1", %{secret: secret} do
      %Signature{signature: ^secret} = Signature.new(secret)
    end

    test "encode_xdr/1", %{signature: signature, binary: binary} do
      {:ok, ^binary} = Signature.encode_xdr(signature)
    end

    test "encode_xdr!/1", %{signature: signature, binary: binary} do
      ^binary = Signature.encode_xdr!(signature)
    end

    test "decode_xdr/2", %{signature: signature, binary: binary} do
      {:ok, {^signature, ""}} = Signature.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = Signature.decode_xdr(123)
    end

    test "decode_xdr!/2", %{signature: signature, binary: binary} do
      {^signature, ""} = Signature.decode_xdr!(binary)
    end
  end
end
