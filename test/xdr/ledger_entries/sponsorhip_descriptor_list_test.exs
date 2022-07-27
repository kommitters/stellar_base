defmodule StellarBase.XDR.SponsorhipDescriptorListTest do
  use ExUnit.Case

  import StellarBase.Test.Utils

  alias StellarBase.XDR.{SponsorshipDescriptorList, OptionalAccountID, SponsorshipDescriptor}

  describe "SponsorshipDescriptorList" do
    setup do
      sponsorship_descriptor_1 =
        "GCNY5OXYSY4FKHOPT2SPOQZAOEIGXB5LBYW3HVU3OWSTQITS65M5RCNY"
        |> create_account_id()
        |> OptionalAccountID.new()
        |> SponsorshipDescriptor.new()

      sponsorship_descriptor_2 =
        "GBZNLMUQMIN3VGUJISKZU7GNY3O3XLMYEHJCKCSMDHKLGSMKALRXOEZD"
        |> create_account_id()
        |> OptionalAccountID.new()
        |> SponsorshipDescriptor.new()

      sponsorship_descriptors = [sponsorship_descriptor_1, sponsorship_descriptor_2]

      %{
        sponsorship_descriptors: sponsorship_descriptors,
        sponsorship_descriptor_list: SponsorshipDescriptorList.new(sponsorship_descriptors),
        binary:
          <<0, 0, 0, 2, 0, 0, 0, 1, 0, 0, 0, 0, 155, 142, 186, 248, 150, 56, 85, 29, 207, 158,
            164, 247, 67, 32, 113, 16, 107, 135, 171, 14, 45, 179, 214, 155, 117, 165, 56, 34,
            114, 247, 89, 216, 0, 0, 0, 1, 0, 0, 0, 0, 114, 213, 178, 144, 98, 27, 186, 154, 137,
            68, 149, 154, 124, 205, 198, 221, 187, 173, 152, 33, 210, 37, 10, 76, 25, 212, 179,
            73, 138, 2, 227, 119>>
      }
    end

    test "new/1", %{sponsorship_descriptors: sponsorship_descriptors} do
      %SponsorshipDescriptorList{sponsorship_descriptors: ^sponsorship_descriptors} =
        SponsorshipDescriptorList.new(sponsorship_descriptors)
    end

    test "encode_xdr/1", %{
      sponsorship_descriptor_list: sponsorship_descriptor_list,
      binary: binary
    } do
      {:ok, ^binary} = SponsorshipDescriptorList.encode_xdr(sponsorship_descriptor_list)
    end

    test "encode_xdr!/1", %{
      sponsorship_descriptor_list: sponsorship_descriptor_list,
      binary: binary
    } do
      ^binary = SponsorshipDescriptorList.encode_xdr!(sponsorship_descriptor_list)
    end

    test "decode_xdr/1", %{
      sponsorship_descriptor_list: sponsorship_descriptor_list,
      binary: binary
    } do
      {:ok, {^sponsorship_descriptor_list, ""}} = SponsorshipDescriptorList.decode_xdr(binary)
    end

    test "decode_xdr/1 with an invalid binary" do
      {:error, :not_binary} = SponsorshipDescriptorList.decode_xdr(123)
    end

    test "decode_xdr!/1", %{
      sponsorship_descriptor_list: sponsorship_descriptor_list,
      binary: binary
    } do
      {^sponsorship_descriptor_list, ""} = SponsorshipDescriptorList.decode_xdr!(binary)
    end

    test "decode_xdr!/1 with an invalid binary" do
      assert_raise XDR.VariableArrayError,
                   "The value which you pass through parameters must be a binary value, for example: <<0, 0, 0, 5>>",
                   fn -> SponsorshipDescriptorList.decode_xdr!(123) end
    end
  end
end
