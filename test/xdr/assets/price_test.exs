defmodule Stellar.XDR.PriceTest do
  use ExUnit.Case

  alias Stellar.XDR.{Int32, Price}

  describe "Price" do
    setup do
      numerator = Int32.new(20)
      denominator = Int32.new(10)

      %{
        numerator: numerator,
        denominator: denominator,
        price: Price.new(numerator, denominator),
        binary: <<0, 0, 0, 20, 0, 0, 0, 10>>
      }
    end

    test "new/1", %{numerator: numerator, denominator: denominator} do
      %Price{numerator: ^numerator, denominator: ^denominator} = Price.new(numerator, denominator)
    end

    test "encode_xdr/1", %{price: price, binary: binary} do
      {:ok, ^binary} = Price.encode_xdr(price)
    end

    test "encode_xdr!/1", %{price: price, binary: binary} do
      ^binary = Price.encode_xdr!(price)
    end

    test "decode_xdr/2", %{price: price, binary: binary} do
      {:ok, {^price, ""}} = Price.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = Price.decode_xdr(123)
    end

    test "decode_xdr!/2", %{price: price, binary: binary} do
      {^price, ^binary} = Price.decode_xdr!(binary <> binary)
    end
  end
end
