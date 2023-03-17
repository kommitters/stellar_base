defmodule StellarBase.XDR.SCSpecFunctionInputV0ListTest do
  use ExUnit.Case

  alias StellarBase.XDR.{
    Void,
    SCSpecTypeDef,
    String30,
    String1024,
    SCSpecType,
    SCSpecFunctionInputV0,
    SCSpecFunctionInputV0List
  }

  describe "SCSpecFunctionInputV0List" do
    setup do
      sc_spec_function_input_v01 =
        SCSpecFunctionInputV0.new(
          String1024.new("Hello there this is a test"),
          String30.new("Hello there"),
          SCSpecTypeDef.new(Void.new(), SCSpecType.new(:SC_SPEC_TYPE_VAL))
        )

      sc_spec_function_input_v02 =
        SCSpecFunctionInputV0.new(
          String1024.new("Hello there this is a test 1"),
          String30.new("Hello there 1"),
          SCSpecTypeDef.new(Void.new(), SCSpecType.new(:SC_SPEC_TYPE_VAL))
        )

      sc_spec_function_input_v0_list = [sc_spec_function_input_v01, sc_spec_function_input_v02]

      %{
        sc_spec_function_input_v0_list: sc_spec_function_input_v0_list,
        sponsorship_descriptor_list:
          SCSpecFunctionInputV0List.new([sc_spec_function_input_v01, sc_spec_function_input_v02]),
        binary:
          <<0, 0, 0, 2, 0, 0, 0, 26, 72, 101, 108, 108, 111, 32, 116, 104, 101, 114, 101, 32, 116,
            104, 105, 115, 32, 105, 115, 32, 97, 32, 116, 101, 115, 116, 0, 0, 0, 0, 0, 11, 72,
            101, 108, 108, 111, 32, 116, 104, 101, 114, 101, 0, 0, 0, 0, 0, 0, 0, 0, 28, 72, 101,
            108, 108, 111, 32, 116, 104, 101, 114, 101, 32, 116, 104, 105, 115, 32, 105, 115, 32,
            97, 32, 116, 101, 115, 116, 32, 49, 0, 0, 0, 13, 72, 101, 108, 108, 111, 32, 116, 104,
            101, 114, 101, 32, 49, 0, 0, 0, 0, 0, 0, 0>>
      }
    end

    test "new/1", %{sc_spec_function_input_v0_list: sc_spec_function_input_v0_list} do
      %SCSpecFunctionInputV0List{sc_spec_function_input_v0_list: ^sc_spec_function_input_v0_list} =
        SCSpecFunctionInputV0List.new(sc_spec_function_input_v0_list)
    end

    test "encode_xdr/1", %{
      sponsorship_descriptor_list: sponsorship_descriptor_list,
      binary: binary
    } do
      {:ok, ^binary} = SCSpecFunctionInputV0List.encode_xdr(sponsorship_descriptor_list)
    end

    test "encode_xdr!/1", %{
      sponsorship_descriptor_list: sponsorship_descriptor_list,
      binary: binary
    } do
      ^binary = SCSpecFunctionInputV0List.encode_xdr!(sponsorship_descriptor_list)
    end

    test "decode_xdr/1", %{
      sponsorship_descriptor_list: sponsorship_descriptor_list,
      binary: binary
    } do
      {:ok, {^sponsorship_descriptor_list, ""}} = SCSpecFunctionInputV0List.decode_xdr(binary)
    end

    test "decode_xdr/1 with an invalid binary" do
      {:error, :not_binary} = SCSpecFunctionInputV0List.decode_xdr(123)
    end

    test "decode_xdr!/1", %{
      sponsorship_descriptor_list: sponsorship_descriptor_list,
      binary: binary
    } do
      {^sponsorship_descriptor_list, ""} = SCSpecFunctionInputV0List.decode_xdr!(binary)
    end

    test "decode_xdr!/1 with an invalid binary" do
      assert_raise XDR.VariableArrayError,
                   "The value which you pass through parameters must be a binary value, for example: <<0, 0, 0, 5>>",
                   fn -> SCSpecFunctionInputV0List.decode_xdr!(123) end
    end
  end
end
