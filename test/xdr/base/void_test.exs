defmodule StellarBase.XDR.VoidTest do
  use ExUnit.Case

  alias StellarBase.XDR.Void

  describe "Void" do
    setup do
      %{
        void: Void.new(),
        binary: ""
      }
    end

    test "new/1" do
      %Void{value: nil} = Void.new()
    end

    test "encode_xdr/1", %{void: void, binary: binary} do
      {:ok, ^binary} = Void.encode_xdr(void)
    end

    test "encode_xdr!/1", %{void: void, binary: binary} do
      ^binary = Void.encode_xdr!(void)
    end

    test "decode_xdr/2", %{void: void, binary: binary} do
      {:ok, {^void, ""}} = Void.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = Void.decode_xdr(123)
    end

    test "decode_xdr!/2", %{void: void, binary: binary} do
      {^void, ^binary} = Void.decode_xdr!(binary <> binary)
    end
  end
end
