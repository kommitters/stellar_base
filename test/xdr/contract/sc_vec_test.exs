defmodule StellarBase.XDR.SCVecTest do
  use ExUnit.Case

  alias StellarBase.XDR.{
    SCVec,
    SCVal,
    SCValType,
    Int64
  }

  describe "SCVec" do
    setup do
      scval1 = SCVal.new(Int64.new(3), SCValType.new(:SCV_U63))
      scval2 = SCVal.new(Int64.new(2), SCValType.new(:SCV_U63))

      scvals = [scval1, scval2]

      %{
        scvals: scvals,
        scvec: SCVec.new(scvals),
        binary:
          <<0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2>>
      }
    end

    test "new/1", %{scvals: scvals} do
      %SCVec{scvals: ^scvals} = SCVec.new(scvals)
    end

    test "encode_xdr/1", %{scvec: scvec, binary: binary} do
      {:ok, ^binary} = SCVec.encode_xdr(scvec)
    end

    test "encode_xdr/1 with invalid elements" do
      {:error, :not_list} =
        %{elements: nil}
        |> SCVec.new()
        |> SCVec.encode_xdr()
    end

    test "encode_xdr!/1", %{scvec: scvec, binary: binary} do
      ^binary = SCVec.encode_xdr!(scvec)
    end

    test "decode_xdr/2", %{scvec: scvec, binary: binary} do
      {:ok, {^scvec, ""}} = SCVec.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = SCVec.decode_xdr(123)
    end

    test "decode_xdr!/2", %{scvec: scvec, binary: binary} do
      {^scvec, ^binary} = SCVec.decode_xdr!(binary <> binary)
    end
  end
end
