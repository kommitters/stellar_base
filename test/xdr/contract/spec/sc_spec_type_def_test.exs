defmodule StellarBase.XDR.SCSpecTypeDefTest do
  use ExUnit.Case

  alias StellarBase.XDR.{
    SCSpecTypeDef,
    SCSpecType,
    SCSpecTypeVec,
    SCSpecTypeMap,
    SCSpecTypeSet,
    SCSpecTypeTuple,
    SCSpecTypeBytesN,
    SCSpecTypeUDT,
    SCSpecTypeOption,
    SCSpecTypeResult,
    SCSpecTypeDef12,
    UInt32,
    Void,
    String60
  }

  describe "SCSpecTypeDef" do
    setup do
      discriminants = [
        %{
          status_type: SCSpecType.new(:SC_SPEC_TYPE_VAL),
          sc_code: Void.new(),
          binary: <<0, 0, 0, 0>>
        },
        %{
          status_type: SCSpecType.new(:SC_SPEC_TYPE_U32),
          sc_code: Void.new(),
          binary: <<0, 0, 0, 1>>
        },
        %{
          status_type: SCSpecType.new(:SC_SPEC_TYPE_I32),
          sc_code: Void.new(),
          binary: <<0, 0, 0, 2>>
        },
        %{
          status_type: SCSpecType.new(:SC_SPEC_TYPE_U64),
          sc_code: Void.new(),
          binary: <<0, 0, 0, 3>>
        },
        %{
          status_type: SCSpecType.new(:SC_SPEC_TYPE_I64),
          sc_code: Void.new(),
          binary: <<0, 0, 0, 4>>
        },
        %{
          status_type: SCSpecType.new(:SC_SPEC_TYPE_U128),
          sc_code: Void.new(),
          binary: <<0, 0, 0, 5>>
        },
        %{
          status_type: SCSpecType.new(:SC_SPEC_TYPE_I128),
          sc_code: Void.new(),
          binary: <<0, 0, 0, 6>>
        },
        %{
          status_type: SCSpecType.new(:SC_SPEC_TYPE_BOOL),
          sc_code: Void.new(),
          binary: <<0, 0, 0, 7>>
        },
        %{
          status_type: SCSpecType.new(:SC_SPEC_TYPE_SYMBOL),
          sc_code: Void.new(),
          binary: <<0, 0, 0, 8>>
        },
        %{
          status_type: SCSpecType.new(:SC_SPEC_TYPE_BITSET),
          sc_code: Void.new(),
          binary: <<0, 0, 0, 9>>
        },
        %{
          status_type: SCSpecType.new(:SC_SPEC_TYPE_STATUS),
          sc_code: Void.new(),
          binary: <<0, 0, 0, 10>>
        },
        %{
          status_type: SCSpecType.new(:SC_SPEC_TYPE_BYTES),
          sc_code: Void.new(),
          binary: <<0, 0, 0, 11>>
        },
        %{
          status_type: SCSpecType.new(:SC_SPEC_TYPE_ADDRESS),
          sc_code: Void.new(),
          binary: <<0, 0, 0, 13>>
        },
        %{
          sc_code:
            SCSpecTypeDef.new(Void.new(), SCSpecType.new(:SC_SPEC_TYPE_VAL))
            |> SCSpecTypeOption.new(),
          status_type: SCSpecType.new(:SC_SPEC_TYPE_OPTION),
          binary: <<0, 0, 3, 232, 0, 0, 0, 0>>
        },
        %{
          sc_code:
            SCSpecTypeResult.new(
              SCSpecTypeDef.new(Void.new(), SCSpecType.new(:SC_SPEC_TYPE_VAL)),
              SCSpecTypeDef.new(Void.new(), SCSpecType.new(:SC_SPEC_TYPE_U128))
            ),
          status_type: SCSpecType.new(:SC_SPEC_TYPE_RESULT),
          binary: <<0, 0, 3, 233, 0, 0, 0, 0, 0, 0, 0, 5>>
        },
        %{
          sc_code:
            SCSpecTypeDef.new(Void.new(), SCSpecType.new(:SC_SPEC_TYPE_VAL))
            |> SCSpecTypeVec.new(),
          status_type: SCSpecType.new(:SC_SPEC_TYPE_VEC),
          binary: <<0, 0, 3, 234, 0, 0, 0, 0>>
        },
        %{
          sc_code:
            SCSpecTypeDef.new(
              Void.new(),
              SCSpecType.new(:SC_SPEC_TYPE_VAL)
            )
            |> SCSpecTypeSet.new(),
          status_type: SCSpecType.new(:SC_SPEC_TYPE_SET),
          binary: <<0, 0, 3, 235, 0, 0, 0, 0>>
        },
        %{
          sc_code:
            SCSpecTypeMap.new(
              SCSpecTypeDef.new(Void.new(), SCSpecType.new(:SC_SPEC_TYPE_VAL)),
              SCSpecTypeDef.new(Void.new(), SCSpecType.new(:SC_SPEC_TYPE_U128))
            ),
          status_type: SCSpecType.new(:SC_SPEC_TYPE_MAP),
          binary: <<0, 0, 3, 236, 0, 0, 0, 0, 0, 0, 0, 5>>
        },
        %{
          sc_code:
            SCSpecTypeDef12.new([
              SCSpecTypeDef.new(Void.new(), SCSpecType.new(:SC_SPEC_TYPE_VAL)),
              SCSpecTypeDef.new(Void.new(), SCSpecType.new(:SC_SPEC_TYPE_U128))
            ])
            |> SCSpecTypeTuple.new(),
          status_type: SCSpecType.new(:SC_SPEC_TYPE_TUPLE),
          binary: <<0, 0, 3, 237, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 5>>
        },
        %{
          sc_code: SCSpecTypeBytesN.new(UInt32.new(1)),
          status_type: SCSpecType.new(:SC_SPEC_TYPE_BYTES_N),
          binary: <<0, 0, 3, 238, 0, 0, 0, 1>>
        },
        %{
          sc_code: SCSpecTypeUDT.new(String60.new("Hello")),
          status_type: SCSpecType.new(:SC_SPEC_TYPE_UDT),
          binary: <<0, 0, 7, 208, 0, 0, 0, 5, 72, 101, 108, 108, 111, 0, 0, 0>>
        }
      ]

      %{discriminants: discriminants}
    end

    test "new/2", %{discriminants: discriminants} do
      for %{status_type: status_type, sc_code: sc_code} <- discriminants do
        %SCSpecTypeDef{code: ^sc_code, type: ^status_type} =
          SCSpecTypeDef.new(sc_code, status_type)
      end
    end

    test "encode_xdr/1", %{discriminants: discriminants} do
      for %{sc_code: sc_code, status_type: status_type, binary: binary} <- discriminants do
        xdr = SCSpecTypeDef.new(sc_code, status_type)
        {:ok, ^binary} = SCSpecTypeDef.encode_xdr(xdr)
      end
    end

    test "encode_xdr!/1", %{discriminants: discriminants} do
      for %{sc_code: sc_code, status_type: status_type, binary: binary} <- discriminants do
        xdr = SCSpecTypeDef.new(sc_code, status_type)
        ^binary = SCSpecTypeDef.encode_xdr!(xdr)
      end
    end

    test "decode_xdr/2", %{discriminants: discriminants} do
      for %{sc_code: sc_code, status_type: status_type, binary: binary} <- discriminants do
        xdr = SCSpecTypeDef.new(sc_code, status_type)
        {:ok, {^xdr, ""}} = SCSpecTypeDef.decode_xdr(binary)
      end
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = SCSpecTypeDef.decode_xdr(123)
    end

    test "decode_xdr!/2", %{discriminants: discriminants} do
      for %{sc_code: sc_code, status_type: status_type, binary: binary} <- discriminants do
        xdr = SCSpecTypeDef.new(sc_code, status_type)
        {^xdr, ""} = SCSpecTypeDef.decode_xdr!(binary)
      end
    end
  end
end
