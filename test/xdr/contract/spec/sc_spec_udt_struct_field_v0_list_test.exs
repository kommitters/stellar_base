defmodule StellarBase.XDR.SCSpecUDTStructFieldV0ListTest do
  use ExUnit.Case

  alias StellarBase.XDR.{
    SCSpecUDTStructFieldV0List,
    SCSpecUDTStructFieldV0,
    String1024,
    String30,
    Void,
    SCSpecType,
    SCSpecTypeDef
  }

  describe "SCSpecUDTStructFieldV0List" do
    setup do
      doc = String1024.new("Hello there this is a test")
      name = String30.new("Hello there 30")
      code = Void.new()
      type_val = SCSpecType.new(:SC_SPEC_TYPE_VAL)
      type = SCSpecTypeDef.new(code, type_val)

      udt_struct_field = SCSpecUDTStructFieldV0.new(doc, name, type)

      fields = [udt_struct_field, udt_struct_field]

      %{
        fields: fields,
        sponsorship_descriptor_list: SCSpecUDTStructFieldV0List.new(fields),
        binary:
          <<0, 0, 0, 2, 0, 0, 0, 26, 72, 101, 108, 108, 111, 32, 116, 104, 101, 114, 101, 32, 116,
            104, 105, 115, 32, 105, 115, 32, 97, 32, 116, 101, 115, 116, 0, 0, 0, 0, 0, 14, 72,
            101, 108, 108, 111, 32, 116, 104, 101, 114, 101, 32, 51, 48, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 26, 72, 101, 108, 108, 111, 32, 116, 104, 101, 114, 101, 32, 116, 104, 105, 115,
            32, 105, 115, 32, 97, 32, 116, 101, 115, 116, 0, 0, 0, 0, 0, 14, 72, 101, 108, 108,
            111, 32, 116, 104, 101, 114, 101, 32, 51, 48, 0, 0, 0, 0, 0, 0>>
      }
    end

    test "new/1", %{fields: fields} do
      %SCSpecUDTStructFieldV0List{fields: ^fields} = SCSpecUDTStructFieldV0List.new(fields)
    end

    test "encode_xdr/1", %{
      sponsorship_descriptor_list: sponsorship_descriptor_list,
      binary: binary
    } do
      {:ok, ^binary} = SCSpecUDTStructFieldV0List.encode_xdr(sponsorship_descriptor_list)
    end

    test "encode_xdr!/1", %{
      sponsorship_descriptor_list: sponsorship_descriptor_list,
      binary: binary
    } do
      ^binary = SCSpecUDTStructFieldV0List.encode_xdr!(sponsorship_descriptor_list)
    end

    test "decode_xdr/1", %{
      sponsorship_descriptor_list: sponsorship_descriptor_list,
      binary: binary
    } do
      {:ok, {^sponsorship_descriptor_list, ""}} = SCSpecUDTStructFieldV0List.decode_xdr(binary)
    end

    test "decode_xdr/1 with an invalid binary" do
      {:error, :not_binary} = SCSpecUDTStructFieldV0List.decode_xdr(123)
    end

    test "decode_xdr!/1", %{
      sponsorship_descriptor_list: sponsorship_descriptor_list,
      binary: binary
    } do
      {^sponsorship_descriptor_list, ""} = SCSpecUDTStructFieldV0List.decode_xdr!(binary)
    end

    test "decode_xdr!/1 with an invalid binary" do
      assert_raise XDR.VariableArrayError,
                   "The value which you pass through parameters must be a binary value, for example: <<0, 0, 0, 5>>",
                   fn -> SCSpecUDTStructFieldV0List.decode_xdr!(123) end
    end
  end
end
