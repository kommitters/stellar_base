defmodule StellarBase.XDR.SCSpecFunctionInputV0List10Test do
  use ExUnit.Case

  alias StellarBase.XDR.{
    Void,
    SCSpecTypeDef,
    String30,
    String1024,
    SCSpecType,
    SCSpecFunctionInputV0,
    SCSpecFunctionInputV0List10
  }

  describe "SCSpecFunctionInputV0List10" do
    setup do
      doc = String1024.new("Hello there this is a test")
      name = String30.new("Hello there")
      code = Void.new()
      type = SCSpecType.new(:SC_SPEC_TYPE_VAL)
      sc_spec_type_def = SCSpecTypeDef.new(code, type)

      sc_spec_function_input_v0_1 =
        SCSpecFunctionInputV0.new(
          doc,
          name,
          sc_spec_type_def
        )

      sc_spec_function_input_v0_2 =
        SCSpecFunctionInputV0.new(
          doc,
          name,
          sc_spec_type_def
        )

      inputs = [sc_spec_function_input_v0_1, sc_spec_function_input_v0_2]

      %{
        inputs: inputs,
        sponsorship_descriptor_list: SCSpecFunctionInputV0List10.new(inputs),
        binary:
          <<0, 0, 0, 2, 0, 0, 0, 26, 72, 101, 108, 108, 111, 32, 116, 104, 101, 114, 101, 32, 116,
            104, 105, 115, 32, 105, 115, 32, 97, 32, 116, 101, 115, 116, 0, 0, 0, 0, 0, 11, 72,
            101, 108, 108, 111, 32, 116, 104, 101, 114, 101, 0, 0, 0, 0, 0, 0, 0, 0, 26, 72, 101,
            108, 108, 111, 32, 116, 104, 101, 114, 101, 32, 116, 104, 105, 115, 32, 105, 115, 32,
            97, 32, 116, 101, 115, 116, 0, 0, 0, 0, 0, 11, 72, 101, 108, 108, 111, 32, 116, 104,
            101, 114, 101, 0, 0, 0, 0, 0>>
      }
    end

    test "new/1", %{inputs: inputs} do
      %SCSpecFunctionInputV0List10{items: ^inputs} = SCSpecFunctionInputV0List10.new(inputs)
    end

    test "encode_xdr/1", %{
      sponsorship_descriptor_list: sponsorship_descriptor_list,
      binary: binary
    } do
      {:ok, ^binary} = SCSpecFunctionInputV0List10.encode_xdr(sponsorship_descriptor_list)
    end

    test "encode_xdr!/1", %{
      sponsorship_descriptor_list: sponsorship_descriptor_list,
      binary: binary
    } do
      ^binary = SCSpecFunctionInputV0List10.encode_xdr!(sponsorship_descriptor_list)
    end

    test "decode_xdr/1", %{
      sponsorship_descriptor_list: sponsorship_descriptor_list,
      binary: binary
    } do
      {:ok, {^sponsorship_descriptor_list, ""}} = SCSpecFunctionInputV0List10.decode_xdr(binary)
    end

    test "decode_xdr/1 with an invalid binary" do
      {:error, :not_binary} = SCSpecFunctionInputV0List10.decode_xdr(123)
    end

    test "decode_xdr!/1", %{
      sponsorship_descriptor_list: sponsorship_descriptor_list,
      binary: binary
    } do
      {^sponsorship_descriptor_list, ""} = SCSpecFunctionInputV0List10.decode_xdr!(binary)
    end

    test "decode_xdr!/1 with an invalid binary" do
      assert_raise XDR.VariableArrayError,
                   "The value which you pass through parameters must be a binary value, for example: <<0, 0, 0, 5>>",
                   fn -> SCSpecFunctionInputV0List10.decode_xdr!(123) end
    end
  end
end
