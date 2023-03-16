defmodule StellarBase.XDR.SCValTest do
  use ExUnit.Case

  alias StellarBase.XDR.{
    Int64,
    Int32,
    OptionalSCObject,
    UInt32,
    UInt64,
    SCValType,
    SCStatic,
    SCStatus,
    SCStatusType,
    SCUnknownErrorCode,
    SCSymbol,
    SCVal,
    SCValType
  }

  describe "SCVal" do
    setup do
      discriminants = [
        %{
          val_type: SCValType.new(:SCV_U63),
          value: Int64.new(2),
          binary: <<0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2>>
        },
        %{
          val_type: SCValType.new(:SCV_U32),
          value: UInt32.new(2),
          binary: <<0, 0, 0, 1, 0, 0, 0, 2>>
        },
        %{
          val_type: SCValType.new(:SCV_I32),
          value: Int32.new(3),
          binary: <<0, 0, 0, 2, 0, 0, 0, 3>>
        },
        %{
          val_type: SCValType.new(:SCV_STATIC),
          value: SCStatic.new(:SCS_TRUE),
          binary: <<0, 0, 0, 3, 0, 0, 0, 1>>
        },
        %{
          val_type: SCValType.new(:SCV_OBJECT),
          value: OptionalSCObject.new(nil),
          binary: <<0, 0, 0, 4, 0, 0, 0, 0>>
        },
        %{
          val_type: SCValType.new(:SCV_SYMBOL),
          value: SCSymbol.new("World"),
          binary: <<0, 0, 0, 5, 0, 0, 0, 5, 87, 111, 114, 108, 100, 0, 0, 0>>
        },
        %{
          val_type: SCValType.new(:SCV_BITSET),
          value: UInt64.new(4),
          binary: <<0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 4>>
        },
        %{
          val_type: SCValType.new(:SCV_STATUS),
          value:
            SCStatus.new(
              SCUnknownErrorCode.new(:UNKNOWN_ERROR_GENERAL),
              SCStatusType.new(:SST_UNKNOWN_ERROR)
            ),
          binary: <<0, 0, 0, 7, 0, 0, 0, 1, 0, 0, 0, 0>>
        }
      ]

      %{discriminants: discriminants}
    end

    test "new/1", %{discriminants: discriminants} do
      for %{val_type: val_type, value: value} <- discriminants do
        %SCVal{value: ^value, type: ^val_type} = SCVal.new(value, val_type)
      end
    end

    test "encode_xdr/1", %{discriminants: discriminants} do
      for %{value: value, val_type: val_type, binary: binary} <- discriminants do
        xdr = SCVal.new(value, val_type)
        {:ok, ^binary} = SCVal.encode_xdr(xdr)
      end
    end

    test "encode_xdr!/1", %{discriminants: discriminants} do
      for %{value: value, val_type: val_type, binary: binary} <- discriminants do
        xdr = SCVal.new(value, val_type)
        ^binary = SCVal.encode_xdr!(xdr)
      end
    end

    test "decode_xdr/2", %{discriminants: discriminants} do
      for %{value: value, val_type: val_type, binary: binary} <- discriminants do
        xdr = SCVal.new(value, val_type)
        {:ok, {^xdr, ""}} = SCVal.decode_xdr(binary)
      end
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = SCVal.decode_xdr(123)
    end

    test "decode_xdr!/2", %{discriminants: discriminants} do
      for %{value: value, val_type: val_type, binary: binary} <- discriminants do
        xdr = SCVal.new(value, val_type)
        {^xdr, ""} = SCVal.decode_xdr!(binary)
      end
    end
  end
end
