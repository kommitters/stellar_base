defmodule StellarBase.XDR.ThresholdsTest do
  use ExUnit.Case

  alias StellarBase.XDR.Thresholds

  describe "Thresholds" do
    setup do
      thresholds = Thresholds.new(master_weight: 128, low: 16, med: 32, high: 64)

      %{
        thresholds: thresholds,
        binary: <<128, 16, 32, 64>>
      }
    end

    test "new/1" do
      %Thresholds{master_weight: 128, low: 16, med: 32, high: 64} =
        Thresholds.new(master_weight: 128, low: 16, med: 32, high: 64)
    end

    test "encode_xdr/1", %{thresholds: thresholds, binary: binary} do
      {:ok, ^binary} = Thresholds.encode_xdr(thresholds)
    end

    test "encode_xdr/1 with invalid input" do
      assert_raise FunctionClauseError,
                   fn ->
                     Thresholds.encode_xdr(123)
                   end
    end

    test "encode_xdr!/1", %{thresholds: thresholds, binary: binary} do
      ^binary = Thresholds.encode_xdr!(thresholds)
    end

    test "encode_xdr!/1 with invalid input" do
      assert_raise FunctionClauseError,
                   fn ->
                     Thresholds.encode_xdr!(123)
                   end
    end

    test "decode_xdr/1", %{binary: binary, thresholds: thresholds} do
      {:ok, {^thresholds, _rest}} = Thresholds.decode_xdr(binary)
    end

    test "decode_xdr/1 with invalid binary" do
      {:error, :not_binary} = Thresholds.decode_xdr(123)
    end

    test "decode_xdr!/1", %{binary: binary, thresholds: thresholds} do
      {^thresholds, _rest} = Thresholds.decode_xdr!(binary)
    end

    test "decode_xdr!/1 with invalid binary" do
      assert_raise XDR.FixedOpaqueError,
                   "The value which you pass through parameters must be a binary value, for example: <<0, 0, 0, 5>>",
                   fn ->
                     Thresholds.decode_xdr!(123)
                   end
    end
  end
end
