defmodule StellarBase.XDR.ClaimableBalanceIDTypeTest do
  use ExUnit.Case

  alias StellarBase.XDR.ClaimableBalanceIDType

  describe "ClaimableBalanceIDType" do
    setup do
      %{
        identifier: :CLAIMABLE_BALANCE_ID_TYPE_V0,
        operation_type: ClaimableBalanceIDType.new(:CLAIMABLE_BALANCE_ID_TYPE_V0),
        binary: <<0, 0, 0, 0>>
      }
    end

    test "new/1", %{identifier: type} do
      %ClaimableBalanceIDType{identifier: ^type} = ClaimableBalanceIDType.new(type)
    end

    test "new/1 with an invalid type" do
      %ClaimableBalanceIDType{identifier: nil} = ClaimableBalanceIDType.new(nil)
    end

    test "encode_xdr/1", %{operation_type: operation_type, binary: binary} do
      {:ok, ^binary} = ClaimableBalanceIDType.encode_xdr(operation_type)
    end

    test "encode_xdr/1 with an invalid identifier" do
      {:error, :invalid_key} =
        ClaimableBalanceIDType.encode_xdr(%ClaimableBalanceIDType{identifier: :BUY_MONEY})
    end

    test "encode_xdr!/1", %{operation_type: operation_type, binary: binary} do
      ^binary = ClaimableBalanceIDType.encode_xdr!(operation_type)
    end

    test "decode_xdr/2", %{operation_type: operation_type, binary: binary} do
      {:ok, {^operation_type, ""}} = ClaimableBalanceIDType.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid declaration" do
      {:error, :invalid_key} = ClaimableBalanceIDType.decode_xdr(<<1, 0, 0, 1>>)
    end

    test "decode_xdr!/2", %{operation_type: operation_type, binary: binary} do
      {^operation_type, ^binary} = ClaimableBalanceIDType.decode_xdr!(binary <> binary)
    end
  end
end
