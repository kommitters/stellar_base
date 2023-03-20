defmodule StellarBase.XDR.SCSpecTypeDef12Test do
  use ExUnit.Case

  alias StellarBase.XDR.{Void, SCSpecTypeDef, SCSpecTypeDef12, SCSpecType}

  describe "SCSpecTypeDef12" do
    setup do
      code = Void.new()
      type_val = SCSpecType.new(:SC_SPEC_TYPE_VAL)
      type_u128 = SCSpecType.new(:SC_SPEC_TYPE_U128)
      sc_spec_type_def1 = SCSpecTypeDef.new(code, type_val)
      sc_spec_type_def2 = SCSpecTypeDef.new(code, type_u128)

      sc_spec_type_defs = [sc_spec_type_def1, sc_spec_type_def2]

      %{
        sc_spec_type_defs: sc_spec_type_defs,
        sponsorship_descriptor_list: SCSpecTypeDef12.new([sc_spec_type_def1, sc_spec_type_def2]),
        binary: <<0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 5>>
      }
    end

    test "new/1", %{sc_spec_type_defs: sc_spec_type_defs} do
      %SCSpecTypeDef12{sc_spec_type_defs: ^sc_spec_type_defs} =
        SCSpecTypeDef12.new(sc_spec_type_defs)
    end

    test "encode_xdr/1", %{
      sponsorship_descriptor_list: sponsorship_descriptor_list,
      binary: binary
    } do
      {:ok, ^binary} = SCSpecTypeDef12.encode_xdr(sponsorship_descriptor_list)
    end

    test "encode_xdr!/1", %{
      sponsorship_descriptor_list: sponsorship_descriptor_list,
      binary: binary
    } do
      ^binary = SCSpecTypeDef12.encode_xdr!(sponsorship_descriptor_list)
    end

    test "decode_xdr/1", %{
      sponsorship_descriptor_list: sponsorship_descriptor_list,
      binary: binary
    } do
      {:ok, {^sponsorship_descriptor_list, ""}} = SCSpecTypeDef12.decode_xdr(binary)
    end

    test "decode_xdr/1 with an invalid binary" do
      {:error, :not_binary} = SCSpecTypeDef12.decode_xdr(123)
    end

    test "decode_xdr!/1", %{
      sponsorship_descriptor_list: sponsorship_descriptor_list,
      binary: binary
    } do
      {^sponsorship_descriptor_list, ""} = SCSpecTypeDef12.decode_xdr!(binary)
    end

    test "decode_xdr!/1 with an invalid binary" do
      assert_raise XDR.VariableArrayError,
                   "The value which you pass through parameters must be a binary value, for example: <<0, 0, 0, 5>>",
                   fn -> SCSpecTypeDef12.decode_xdr!(123) end
    end
  end
end
