defmodule StellarBase.XDR.SCSpecFunctionInputV0Test do
  use ExUnit.Case

  alias StellarBase.XDR.{
    String1024,
    String30,
    SCSpecFunctionInputV0,
    SCSpecTypeDef,
    SCSpecType,
    Void
  }

  describe "SCSpecFunctionInputV0" do
    setup do
      doc = String1024.new("Hello there this is a test")
      name = String30.new("Hello there")
      type = SCSpecTypeDef.new(Void.new(), SCSpecType.new(:SC_SPEC_TYPE_VAL))

      %{
        doc: doc,
        name: name,
        type: type,
        sc_spec_function_input_v0: SCSpecFunctionInputV0.new(doc, name, type),
        binary:
          <<0, 0, 0, 26, 72, 101, 108, 108, 111, 32, 116, 104, 101, 114, 101, 32, 116, 104, 105,
            115, 32, 105, 115, 32, 97, 32, 116, 101, 115, 116, 0, 0, 0, 0, 0, 11, 72, 101, 108,
            108, 111, 32, 116, 104, 101, 114, 101, 0, 0, 0, 0, 0>>
      }
    end

    test "new/1", %{doc: doc, name: name, type: type} do
      %SCSpecFunctionInputV0{doc: ^doc, name: ^name, type: ^type} =
        SCSpecFunctionInputV0.new(doc, name, type)
    end

    test "encode_xdr/1", %{
      sc_spec_function_input_v0: sc_spec_function_input_v0,
      binary: binary
    } do
      {:ok, ^binary} = SCSpecFunctionInputV0.encode_xdr(sc_spec_function_input_v0)
    end

    test "encode_xdr!/1", %{
      sc_spec_function_input_v0: sc_spec_function_input_v0,
      binary: binary
    } do
      ^binary = SCSpecFunctionInputV0.encode_xdr!(sc_spec_function_input_v0)
    end

    test "decode_xdr/2", %{
      sc_spec_function_input_v0: sc_spec_function_input_v0,
      binary: binary
    } do
      {:ok, {^sc_spec_function_input_v0, ""}} = SCSpecFunctionInputV0.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = SCSpecFunctionInputV0.decode_xdr(123)
    end

    test "decode_xdr!/2", %{
      sc_spec_function_input_v0: sc_spec_function_input_v0,
      binary: binary
    } do
      {^sc_spec_function_input_v0, ^binary} = SCSpecFunctionInputV0.decode_xdr!(binary <> binary)
    end
  end
end
