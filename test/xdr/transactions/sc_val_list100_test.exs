defmodule StellarBase.XDR.SCValList100Test do
  use ExUnit.Case

  alias StellarBase.XDR.{
    SCValList100,
    SCVal,
    SCValType,
    SCString,
    Bool
  }

  describe "SCValList100" do
    setup do
      scval_type1 = SCValType.new(:SCV_BOOL)
      scval1 = true |> Bool.new() |> SCVal.new(scval_type1)

      scval_type2 = SCValType.new(:SCV_STRING)
      scval2 = "hello" |> SCString.new() |> SCVal.new(scval_type2)
      items = [scval1, scval2]

      %{
        items: items,
        scval_list: SCValList100.new(items),
        binary:
          <<0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 14, 0, 0, 0, 5, 104, 101, 108, 108, 111,
            0, 0, 0>>
      }
    end

    test "new/1", %{items: items} do
      %SCValList100{items: ^items} = SCValList100.new(items)
    end

    test "encode_xdr/1", %{
      scval_list: scval_list,
      binary: binary
    } do
      {:ok, ^binary} = SCValList100.encode_xdr(scval_list)
    end

    test "encode_xdr!/1", %{
      scval_list: scval_list,
      binary: binary
    } do
      ^binary = SCValList100.encode_xdr!(scval_list)
    end

    test "decode_xdr/1", %{
      scval_list: scval_list,
      binary: binary
    } do
      {:ok, {^scval_list, ""}} = SCValList100.decode_xdr(binary)
    end

    test "decode_xdr/1 with an invalid binary" do
      {:error, :not_binary} = SCValList100.decode_xdr(123)
    end

    test "decode_xdr!/1", %{
      scval_list: scval_list,
      binary: binary
    } do
      {^scval_list, ""} = SCValList100.decode_xdr!(binary)
    end

    test "decode_xdr!/1 with an invalid binary" do
      assert_raise XDR.VariableArrayError,
                   "The value which you pass through parameters must be a binary value, for example: <<0, 0, 0, 5>>",
                   fn -> SCValList100.decode_xdr!(123) end
    end
  end
end
