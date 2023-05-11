defmodule StellarBase.XDR.SCSpecFunctionV0Test do
  use ExUnit.Case

  alias StellarBase.XDR.{
    SCSpecTypeDefList1,
    String1024,
    SCSymbol,
    SCSpecFunctionInputV0List10,
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
      code = Void.new()
      function_input_v0_name = String30.new("string30")
      type_val = SCSpecType.new(:SC_SPEC_TYPE_VAL)
      type = SCSpecTypeDef.new(code, type_val)

      sc_spec_function_input_v0_1 =
        SCSpecFunctionInputV0.new(
          doc,
          function_input_v0_name,
          type
        )

      sc_spec_function_input_v0_2 =
        SCSpecFunctionInputV0.new(
          doc,
          function_input_v0_name,
          type
        )

      inputs =
        SCSpecFunctionInputV0List10.new([
          sc_spec_function_input_v0_1,
          sc_spec_function_input_v0_2
        ])

      outputs =
        SCSpecTypeDefList1.new([
          type
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
            0, 0, 0, 8, 115, 116, 114, 105, 110, 103, 51, 48, 0, 0, 0, 0, 0, 0, 0, 26, 72, 101,
            108, 108, 111, 32, 116, 104, 101, 114, 101, 32, 116, 104, 105, 115, 32, 105, 115, 32,
            97, 32, 116, 101, 115, 116, 0, 0, 0, 0, 0, 8, 115, 116, 114, 105, 110, 103, 51, 48, 0,
            0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0>>
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
