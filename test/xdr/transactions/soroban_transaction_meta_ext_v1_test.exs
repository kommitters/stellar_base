defmodule StellarBase.XDR.SorobanTransactionMetaExtV1Test do
  use ExUnit.Case

  alias StellarBase.XDR.{
    ExtensionPoint,
    Int64,
    SorobanTransactionMetaExtV1,
    Void
  }

  describe "SorobanTransactionMetaExtV1" do
    setup do
      extension_point_type = 0
      void = Void.new()
      ext = ExtensionPoint.new(void, extension_point_type)
      total_non_refundable_resource_fee_charged = Int64.new(200_878)
      total_refundable_resource_fee_charged = Int64.new(22_327_816)
      rent_fee_charged = Int64.new(22_312_425)

      soroban_tx_meta_ext_v1 =
        SorobanTransactionMetaExtV1.new(
          ext,
          total_non_refundable_resource_fee_charged,
          total_refundable_resource_fee_charged,
          rent_fee_charged
        )

      binary =
        <<0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 16, 174, 0, 0, 0, 0, 1, 84, 178, 8, 0, 0, 0, 0, 1, 84,
          117, 233>>

      %{
        ext: ext,
        total_non_refundable_resource_fee_charged: total_non_refundable_resource_fee_charged,
        total_refundable_resource_fee_charged: total_refundable_resource_fee_charged,
        rent_fee_charged: rent_fee_charged,
        soroban_tx_meta_ext_v1: soroban_tx_meta_ext_v1,
        binary: binary
      }
    end

    test "new/1", %{
      ext: ext,
      total_non_refundable_resource_fee_charged: total_non_refundable_resource_fee_charged,
      total_refundable_resource_fee_charged: total_refundable_resource_fee_charged,
      rent_fee_charged: rent_fee_charged
    } do
      %SorobanTransactionMetaExtV1{
        ext: ^ext,
        total_non_refundable_resource_fee_charged: ^total_non_refundable_resource_fee_charged,
        total_refundable_resource_fee_charged: ^total_refundable_resource_fee_charged,
        rent_fee_charged: ^rent_fee_charged
      } =
        SorobanTransactionMetaExtV1.new(
          ext,
          total_non_refundable_resource_fee_charged,
          total_refundable_resource_fee_charged,
          rent_fee_charged
        )
    end

    test "encode_xdr/1", %{
      soroban_tx_meta_ext_v1: soroban_tx_meta_ext_v1,
      binary: binary
    } do
      {:ok, ^binary} = SorobanTransactionMetaExtV1.encode_xdr(soroban_tx_meta_ext_v1)
    end

    test "encode_xdr!/1", %{
      soroban_tx_meta_ext_v1: soroban_tx_meta_ext_v1,
      binary: binary
    } do
      ^binary = SorobanTransactionMetaExtV1.encode_xdr!(soroban_tx_meta_ext_v1)
    end

    test "decode_xdr/2", %{
      soroban_tx_meta_ext_v1: soroban_tx_meta_ext_v1,
      binary: binary
    } do
      {:ok, {^soroban_tx_meta_ext_v1, ""}} = SorobanTransactionMetaExtV1.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = SorobanTransactionMetaExtV1.decode_xdr(1234)
    end

    test "decode_xdr!/2", %{
      soroban_tx_meta_ext_v1: soroban_tx_meta_ext_v1,
      binary: binary
    } do
      {^soroban_tx_meta_ext_v1, ^binary} =
        SorobanTransactionMetaExtV1.decode_xdr!(binary <> binary)
    end
  end
end
