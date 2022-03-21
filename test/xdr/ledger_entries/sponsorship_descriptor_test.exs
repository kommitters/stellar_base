defmodule StellarBase.XDR.SponsorshipDescriptorTest do
  use ExUnit.Case

  import StellarBase.Test.Utils, only: [create_account_id: 1]

  alias StellarBase.XDR.SponsorshipDescriptor

  describe "SponsorshipDescriptor" do
    setup do
      account_id = create_account_id("GCNY5OXYSY4FKHOPT2SPOQZAOEIGXB5LBYW3HVU3OWSTQITS65M5RCNY")

      %{
        account_id: account_id,
        sponsorship_descriptor: account_id |> SponsorshipDescriptor.new(),
        binary:
          <<0, 0, 0, 0, 155, 142, 186, 248, 150, 56, 85, 29, 207, 158, 164, 247, 67, 32, 113, 16,
            107, 135, 171, 14, 45, 179, 214, 155, 117, 165, 56, 34, 114, 247, 89, 216>>
      }
    end

    test "new/1", %{sponsorship_descriptor: sponsorship_descriptor} do
      %SponsorshipDescriptor{sponsorship_descriptor: ^sponsorship_descriptor} =
        SponsorshipDescriptor.new(sponsorship_descriptor)
    end

    test "encode_xdr/1", %{sponsorship_descriptor: sponsorship_descriptor, binary: binary} do
      {:ok, ^binary} = SponsorshipDescriptor.encode_xdr(sponsorship_descriptor)
    end

    test "encode_xdr!/1", %{sponsorship_descriptor: sponsorship_descriptor, binary: binary} do
      ^binary = SponsorshipDescriptor.encode_xdr!(sponsorship_descriptor)
    end

    test "decode_xdr/1", %{sponsorship_descriptor: sponsorship_descriptor, binary: binary} do
      {:ok, {^sponsorship_descriptor, ""}} = SponsorshipDescriptor.decode_xdr(binary)
    end

    test "decode_xdr/1 with an invalid binary" do
      {:error, :not_binary} = SponsorshipDescriptor.decode_xdr(123)
    end

    test "decode_xdr!/1", %{sponsorship_descriptor: sponsorship_descriptor, binary: binary} do
      {^sponsorship_descriptor, ""} = SponsorshipDescriptor.decode_xdr!(binary)
    end
  end
end
