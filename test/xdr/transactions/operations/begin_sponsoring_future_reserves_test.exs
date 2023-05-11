defmodule StellarBase.XDR.BeginSponsoringFutureReservesOpTest do
  use ExUnit.Case

  alias StellarBase.XDR.{AccountID, PublicKey, PublicKeyType, Uint256}
  alias StellarBase.XDR.BeginSponsoringFutureReservesOp
  alias StellarBase.StrKey

  describe "BeginSponsoringFutureReservesOp Operation" do
    setup do
      key_type = PublicKeyType.new(:PUBLIC_KEY_TYPE_ED25519)

      sponsored_id =
        "GCNY5OXYSY4FKHOPT2SPOQZAOEIGXB5LBYW3HVU3OWSTQITS65M5RCNY"
        |> StrKey.decode!(:ed25519_public_key)
        |> Uint256.new()
        |> PublicKey.new(key_type)
        |> AccountID.new()

      %{
        sponsored_id: sponsored_id,
        sponsored: BeginSponsoringFutureReservesOp.new(sponsored_id),
        binary:
          <<0, 0, 0, 0, 155, 142, 186, 248, 150, 56, 85, 29, 207, 158, 164, 247, 67, 32, 113, 16,
            107, 135, 171, 14, 45, 179, 214, 155, 117, 165, 56, 34, 114, 247, 89, 216>>
      }
    end

    test "new/1", %{sponsored_id: sponsored_id} do
      %BeginSponsoringFutureReservesOp{sponsored_id: ^sponsored_id} =
        BeginSponsoringFutureReservesOp.new(sponsored_id)
    end

    test "encode_xdr/1", %{sponsored: sponsored, binary: binary} do
      {:ok, ^binary} = BeginSponsoringFutureReservesOp.encode_xdr(sponsored)
    end

    test "encode_xdr!/1", %{sponsored: sponsored, binary: binary} do
      ^binary = BeginSponsoringFutureReservesOp.encode_xdr!(sponsored)
    end

    test "decode_xdr/2", %{sponsored: sponsored, binary: binary} do
      {:ok, {^sponsored, ""}} = BeginSponsoringFutureReservesOp.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = BeginSponsoringFutureReservesOp.decode_xdr(123)
    end

    test "decode_xdr!/2", %{sponsored: sponsored, binary: binary} do
      {^sponsored, ^binary} = BeginSponsoringFutureReservesOp.decode_xdr!(binary <> binary)
    end
  end
end
