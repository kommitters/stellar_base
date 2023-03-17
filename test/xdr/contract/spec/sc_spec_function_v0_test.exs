defmodule StellarBase.XDR.SCSpecFunctionV0Test do
  use ExUnit.Case

  alias StellarBase.XDR.{
    SCSpecTypeDef1,
    String1024,
    SCSymbol,
    SCSpecFunctionInputV0List,
    SCSpecFunctionInputV0,
    SCSpecTypeDef,
    SCSpecFunctionV0,
    Void,
    SCSpecType,
    String30
  }

  describe "SCSpecFunctionV0" do
    setup do
      doc = String1024.new("Hello there this is a test")
      name = SCSymbol.new("name10")

      inputs =
        SCSpecFunctionInputV0List.new([
          SCSpecFunctionInputV0.new(
            String1024.new("Hello there this is a test"),
            String30.new("Hello there"),
            SCSpecTypeDef.new(Void.new(), SCSpecType.new(:SC_SPEC_TYPE_VAL))
          ),
          SCSpecFunctionInputV0.new(
            String1024.new("Hello there this is test 2"),
            String30.new("Hello there 2"),
            SCSpecTypeDef.new(Void.new(), SCSpecType.new(:SC_SPEC_TYPE_VAL))
          )
        ])

      outputs =
        SCSpecTypeDef1.new([
          SCSpecTypeDef.new(Void.new(), SCSpecType.new(:SC_SPEC_TYPE_VAL))
        ])

      %{
        doc: doc,
        name: name,
        inputs: inputs,
        outputs: outputs,
        sc_spec_function_v0: SCSpecFunctionV0.new(doc, name, inputs, outputs),
        binary:
          <<0, 0, 0, 26, 72, 101, 108, 108, 111, 32, 116, 104, 101, 114, 101, 32, 116, 104, 105,
            115, 32, 105, 115, 32, 97, 32, 116, 101, 115, 116, 0, 0, 0, 0, 0, 6, 110, 97, 109,
            101, 49, 48, 0, 0, 0, 0, 0, 2, 0, 0, 0, 26, 72, 101, 108, 108, 111, 32, 116, 104, 101,
            114, 101, 32, 116, 104, 105, 115, 32, 105, 115, 32, 97, 32, 116, 101, 115, 116, 0, 0,
            0, 0, 0, 11, 72, 101, 108, 108, 111, 32, 116, 104, 101, 114, 101, 0, 0, 0, 0, 0, 0, 0,
            0, 26, 72, 101, 108, 108, 111, 32, 116, 104, 101, 114, 101, 32, 116, 104, 105, 115,
            32, 105, 115, 32, 116, 101, 115, 116, 32, 50, 0, 0, 0, 0, 0, 13, 72, 101, 108, 108,
            111, 32, 116, 104, 101, 114, 101, 32, 50, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0,
            0>>
      }
    end

    test "new/1", %{doc: doc, name: name, inputs: inputs, outputs: outputs} do
      %SCSpecFunctionV0{doc: ^doc, name: ^name, inputs: ^inputs, outputs: ^outputs} =
        SCSpecFunctionV0.new(doc, name, inputs, outputs)
    end

    test "encode_xdr/1", %{
      sc_spec_function_v0: sc_spec_function_v0,
      binary: binary
    } do
      {:ok, ^binary} = SCSpecFunctionV0.encode_xdr(sc_spec_function_v0)
    end

    test "encode_xdr!/1", %{
      sc_spec_function_v0: sc_spec_function_v0,
      binary: binary
    } do
      ^binary = SCSpecFunctionV0.encode_xdr!(sc_spec_function_v0)
    end

    test "decode_xdr/2", %{
      sc_spec_function_v0: sc_spec_function_v0,
      binary: binary
    } do
      {:ok, {^sc_spec_function_v0, ""}} = SCSpecFunctionV0.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = SCSpecFunctionV0.decode_xdr(123)
    end

    test "decode_xdr!/2", %{
      sc_spec_function_v0: sc_spec_function_v0,
      binary: binary
    } do
      {^sc_spec_function_v0, ^binary} = SCSpecFunctionV0.decode_xdr!(binary <> binary)
    end
  end
end
