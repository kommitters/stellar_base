defmodule StellarBase.XDR.SCSpecTypeDefList1Test do
  use ExUnit.Case

  alias StellarBase.XDR.{Void, SCSpecTypeDef, SCSpecTypeDefList1, SCSpecType}

  describe "SCSpecTypeDefList1" do
    setup do
      code = Void.new()
      type = SCSpecType.new(:SC_SPEC_TYPE_VAL)
      sc_spec_type_def1 = SCSpecTypeDef.new(code, type)

      sc_spec_type_defs = [sc_spec_type_def1]

      %{
        sc_spec_type_defs: sc_spec_type_defs,
        sponsorship_descriptor_list: SCSpecTypeDefList1.new([sc_spec_type_def1]),
        binary: <<0, 0, 0, 1, 0, 0, 0, 0>>
      }
    end

    test "new/1", %{sc_spec_type_defs: sc_spec_type_defs} do
      %SCSpecTypeDefList1{sc_spec_type_defs: ^sc_spec_type_defs} =
        SCSpecTypeDefList1.new(sc_spec_type_defs)
    end

    test "encode_xdr/1", %{
      sponsorship_descriptor_list: sponsorship_descriptor_list,
      binary: binary
    } do
      {:ok, ^binary} = SCSpecTypeDefList1.encode_xdr(sponsorship_descriptor_list)
    end

    test "encode_xdr!/1", %{
      sponsorship_descriptor_list: sponsorship_descriptor_list,
      binary: binary
    } do
      ^binary = SCSpecTypeDefList1.encode_xdr!(sponsorship_descriptor_list)
    end

    test "decode_xdr/1", %{
      sponsorship_descriptor_list: sponsorship_descriptor_list,
      binary: binary
    } do
      {:ok, {^sponsorship_descriptor_list, ""}} = SCSpecTypeDefList1.decode_xdr(binary)
    end

    test "decode_xdr/1 with an invalid binary" do
      {:error, :not_binary} = SCSpecTypeDefList1.decode_xdr(123)
    end

    test "decode_xdr!/1", %{
      sponsorship_descriptor_list: sponsorship_descriptor_list,
      binary: binary
    } do
      {^sponsorship_descriptor_list, ""} = SCSpecTypeDefList1.decode_xdr!(binary)
    end

    test "decode_xdr!/1 with an invalid binary" do
      assert_raise XDR.VariableArrayError,
                   "The value which you pass through parameters must be a binary value, for example: <<0, 0, 0, 5>>",
                   fn -> SCSpecTypeDefList1.decode_xdr!(123) end
    end
  end
end
