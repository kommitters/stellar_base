defmodule StellarBase.XDR.OptionalSCVecTest do
  use ExUnit.Case

  alias StellarBase.XDR.{
    Int64,
    OptionalSCVec,
    SCVec,
    SCVal,
    SCValType
  }

  describe "OptionalSCVec" do
    setup do
      scval1 = SCVal.new(Int64.new(3), SCValType.new(:SCV_I64))
      scval2 = SCVal.new(Int64.new(2), SCValType.new(:SCV_I64))

      sc_vec = SCVec.new([scval1, scval2])

      %{
        optional_sc_vec: OptionalSCVec.new(sc_vec),
        empty_sc_object: OptionalSCVec.new(nil),
        binary:
          <<0, 0, 0, 1, 0, 0, 0, 2, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 6, 0, 0, 0, 0, 0,
            0, 0, 2>>
      }
    end

    test "new/1", %{optional_sc_vec: optional_sc_vec} do
      %OptionalSCVec{sc_vec: ^optional_sc_vec} = OptionalSCVec.new(optional_sc_vec)
    end

    test "new/1 no sc_vec opted" do
      %OptionalSCVec{sc_vec: nil} = OptionalSCVec.new(nil)
    end

    test "encode_xdr/1", %{optional_sc_vec: optional_sc_vec, binary: binary} do
      {:ok, ^binary} = OptionalSCVec.encode_xdr(optional_sc_vec)
    end

    test "encode_xdr/1 no sc_vec opted", %{empty_sc_object: empty_sc_object} do
      {:ok, <<0, 0, 0, 0>>} = OptionalSCVec.encode_xdr(empty_sc_object)
    end

    test "encode_xdr!/1", %{optional_sc_vec: optional_sc_vec, binary: binary} do
      ^binary = OptionalSCVec.encode_xdr!(optional_sc_vec)
    end

    test "decode_xdr/2", %{optional_sc_vec: optional_sc_vec, binary: binary} do
      {:ok, {^optional_sc_vec, ""}} = OptionalSCVec.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = OptionalSCVec.decode_xdr(1234)
    end

    test "decode_xdr/2 when sc_vec is not opted" do
      {:ok, {%OptionalSCVec{sc_vec: nil}, ""}} = OptionalSCVec.decode_xdr(<<0, 0, 0, 0>>)
    end

    test "decode_xdr!/2", %{optional_sc_vec: optional_sc_vec, binary: binary} do
      {^optional_sc_vec, ^binary} = OptionalSCVec.decode_xdr!(binary <> binary)
    end

    test "decode_xdr!/2 when sc_vec is not opted" do
      {%OptionalSCVec{sc_vec: nil}, ""} = OptionalSCVec.decode_xdr!(<<0, 0, 0, 0>>)
    end
  end
end
