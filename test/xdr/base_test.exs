defmodule Stellar.XDR.BaseTest do
  use ExUnit.Case

  describe "Integer" do
    test "Int32" do
      %XDR.Int{datum: 1234} = Stellar.XDR.Int32.new(1234)
    end

    test "Int64" do
      %XDR.HyperInt{datum: 123_456_789} = Stellar.XDR.Int64.new(123_456_789)
    end
  end

  describe "Unsigned Integer" do
    test "UInt32" do
      %XDR.UInt{datum: 1234} = Stellar.XDR.UInt32.new(1234)
    end

    test "UInt64" do
      %XDR.HyperUInt{datum: 123_456_789} = Stellar.XDR.UInt64.new(123_456_789)
    end
  end

  describe "FixedOpaque" do
    test "Opaque4" do
      %XDR.FixedOpaque{length: 4, opaque: _opaque} =
        Stellar.XDR.Opaque4.new(<<72, 101, 108, 108>>)
    end

    test "Opaque12" do
      %XDR.FixedOpaque{length: 12, opaque: _opaque} =
        Stellar.XDR.Opaque12.new(<<72, 101, 108, 108, 111, 32, 119, 111, 114, 108, 100, 0>>)
    end

    test "Opaque32" do
      %XDR.FixedOpaque{length: 32, opaque: _opaque} =
        Stellar.XDR.Opaque32.new("GCIZ3GSM5XL7OUS4UP64THMDZ7CZ3ZWNTMGKKUPT4V3UMXIKTAH46KNG")
    end

    test "Hash" do
      %XDR.FixedOpaque{length: 32, opaque: _opaque} =
        Stellar.XDR.Hash.new("GCIZ3GSM5XL7OUS4UP64THMDZ7CZ3ZWNTMGKKUPT4V3UMXIKTAH46KNG")
    end
  end

  describe "VariableOpaque" do
    test "Opaque64" do
      %XDR.VariableOpaque{max_size: 64, opaque: _opaque} =
        Stellar.XDR.VariableOpaque64.new(
          "GCIZ3GSM5XL7OUS4UP64THMDZ7CZ3ZWNTMGKKUPT4V3UMXIKTAH46KNG"
        )
    end
  end
end
