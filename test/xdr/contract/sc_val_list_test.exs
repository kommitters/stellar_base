defmodule StellarBase.XDR.SCValListTest do
  use ExUnit.Case

  alias StellarBase.XDR.{
    SCValList,
    SCVal,
    SCValType,
    Int64
  }

  describe "SCValList" do
    setup do
      scval1 = SCVal.new(Int64.new(3), SCValType.new(:SCV_I64))
      scval2 = SCVal.new(Int64.new(2), SCValType.new(:SCV_I64))

      sc_vals = [scval1, scval2]

      %{
        sc_vals: sc_vals,
        sc_val_list: SCValList.new(sc_vals),
        binary:
          <<0, 0, 0, 2, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 2>>
      }
    end

    test "new/1", %{sc_vals: sc_vals} do
      %SCValList{items: ^sc_vals} = SCValList.new(sc_vals)
    end

    test "encode_xdr/1", %{sc_val_list: sc_val_list, binary: binary} do
      {:ok, ^binary} = SCValList.encode_xdr(sc_val_list)
    end

    test "encode_xdr/1 with invalid elements" do
      {:error, :not_list} =
        %{elements: nil}
        |> SCValList.new()
        |> SCValList.encode_xdr()
    end

    test "encode_xdr!/1", %{sc_val_list: sc_val_list, binary: binary} do
      ^binary = SCValList.encode_xdr!(sc_val_list)
    end

    test "decode_xdr/2", %{sc_val_list: sc_val_list, binary: binary} do
      {:ok, {^sc_val_list, ""}} = SCValList.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = SCValList.decode_xdr(123)
    end

    test "decode_xdr!/2", %{sc_val_list: sc_val_list, binary: binary} do
      {^sc_val_list, ^binary} = SCValList.decode_xdr!(binary <> binary)
    end
  end
end
