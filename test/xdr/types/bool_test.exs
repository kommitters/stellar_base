defmodule StellarBase.XDR.BoolTest do
  use ExUnit.Case

  alias StellarBase.XDR.Bool

  describe "Bool" do
    setup do
      %{
        bool: Bool.new(true),
        binary: <<0, 0, 0, 1>>
      }
    end

    test "new/1" do
      %Bool{value: false} = Bool.new(false)
    end

    test "encode_xdr/1", %{bool: bool, binary: binary} do
      {:ok, ^binary} = Bool.encode_xdr(bool)
    end

    test "encode_xdr/1 with a non boolean" do
      {:error, :not_boolean} = Bool.encode_xdr(%Bool{value: "1234"})
    end

    test "encode_xdr!/1", %{bool: bool, binary: binary} do
      ^binary = Bool.encode_xdr!(bool)
    end

    test "decode_xdr/2", %{bool: bool, binary: binary} do
      {:ok, {^bool, ""}} = Bool.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :invalid_value} = Bool.decode_xdr(123)
    end

    test "decode_xdr!/2", %{bool: bool, binary: binary} do
      {^bool, ^binary} = Bool.decode_xdr!(binary <> binary)
    end
  end
end
