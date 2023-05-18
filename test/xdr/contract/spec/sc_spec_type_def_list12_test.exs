defmodule StellarBase.XDR.SCSpecTypeDefList12Test do
  use ExUnit.Case

  alias StellarBase.XDR.{Void, SCSpecTypeDef, SCSpecTypeDefList12, SCSpecType}

  describe "SCSpecTypeDefList12" do
    setup do
      code = Void.new()
      type_val = SCSpecType.new(:SC_SPEC_TYPE_VAL)
      type_u128 = SCSpecType.new(:SC_SPEC_TYPE_I32)
      sc_spec_type_def1 = SCSpecTypeDef.new(code, type_val)
      sc_spec_type_def2 = SCSpecTypeDef.new(code, type_u128)

      sc_spec_type_defs = [sc_spec_type_def1, sc_spec_type_def2]

      %{
        sc_spec_type_defs: sc_spec_type_defs,
        sponsorship_descriptor_list:
          SCSpecTypeDefList12.new([sc_spec_type_def1, sc_spec_type_def2]),
        binary: <<0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 5>>
      }
    end

    test "new/1", %{sc_spec_type_defs: sc_spec_type_defs} do
      %SCSpecTypeDefList12{items: ^sc_spec_type_defs} = SCSpecTypeDefList12.new(sc_spec_type_defs)
    end

    test "encode_xdr/1", %{
      sponsorship_descriptor_list: sponsorship_descriptor_list,
      binary: binary
    } do
      {:ok, ^binary} = SCSpecTypeDefList12.encode_xdr(sponsorship_descriptor_list)
    end

    test "encode_xdr!/1", %{
      sponsorship_descriptor_list: sponsorship_descriptor_list,
      binary: binary
    } do
      ^binary = SCSpecTypeDefList12.encode_xdr!(sponsorship_descriptor_list)
    end

    test "decode_xdr/1", %{
      sponsorship_descriptor_list: sponsorship_descriptor_list,
      binary: binary
    } do
      {:ok, {^sponsorship_descriptor_list, ""}} = SCSpecTypeDefList12.decode_xdr(binary)
    end

    test "decode_xdr/1 with an invalid binary" do
      {:error, :not_binary} = SCSpecTypeDefList12.decode_xdr(123)
    end

    test "decode_xdr!/1", %{
      sponsorship_descriptor_list: sponsorship_descriptor_list,
      binary: binary
    } do
      {^sponsorship_descriptor_list, ""} = SCSpecTypeDefList12.decode_xdr!(binary)
    end

    test "decode_xdr!/1 with an invalid binary" do
      assert_raise XDR.VariableArrayError,
                   "The value which you pass through parameters must be a binary value, for example: <<0, 0, 0, 5>>",
                   fn -> SCSpecTypeDefList12.decode_xdr!(123) end
    end
  end
end
