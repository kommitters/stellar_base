defmodule StellarBase.XDR.Operations.SetOptionsTest do
  use ExUnit.Case

  alias StellarBase.XDR.{
    AccountID,
    OptionalAccountID,
    OptionalString32,
    OptionalUInt32,
    PublicKey,
    PublicKeyType,
    Signer,
    SignerKey,
    SignerKeyType,
    String32,
    UInt32,
    UInt256
  }

  alias StellarBase.XDR.Operations.SetOptions

  alias StellarBase.StrKey

  describe "SetOptions Operation" do
    setup do
      account_type = PublicKeyType.new(:PUBLIC_KEY_TYPE_ED25519)

      account_id =
        "GCNY5OXYSY4FKHOPT2SPOQZAOEIGXB5LBYW3HVU3OWSTQITS65M5RCNY"
        |> StrKey.decode!(:ed25519_public_key)
        |> UInt256.new()
        |> PublicKey.new(account_type)
        |> AccountID.new()

      signer_type = SignerKeyType.new(:SIGNER_KEY_TYPE_ED25519)
      signer_weight = UInt32.new(2)

      signer =
        "GBQVLZE4XCNDFW2N3SPUG4SI6D6YCDJPI45M5JHWUGHQSAT7REKIGCNQ"
        |> StrKey.decode!(:ed25519_public_key)
        |> UInt256.new()
        |> SignerKey.new(signer_type)
        |> Signer.new(signer_weight)

      inflation_dest = OptionalAccountID.new(account_id)
      clear_flags = OptionalUInt32.new()
      set_flags = OptionalUInt32.new()
      master_weight = OptionalUInt32.new(UInt32.new(4))
      low_threshold = OptionalUInt32.new(UInt32.new(1))
      med_threshold = OptionalUInt32.new(UInt32.new(2))
      high_threshold = OptionalUInt32.new(UInt32.new(3))
      home_domain = OptionalString32.new(String32.new("kommit.co"))

      set_options =
        SetOptions.new(
          inflation_dest,
          clear_flags,
          set_flags,
          master_weight,
          low_threshold,
          med_threshold,
          high_threshold,
          home_domain,
          signer
        )

      %{
        inflation_dest: inflation_dest,
        clear_flags: clear_flags,
        set_flags: set_flags,
        master_weight: master_weight,
        low_threshold: low_threshold,
        med_threshold: med_threshold,
        high_threshold: high_threshold,
        home_domain: home_domain,
        signer: signer,
        set_options: set_options,
        binary:
          <<0, 0, 0, 1, 0, 0, 0, 0, 155, 142, 186, 248, 150, 56, 85, 29, 207, 158, 164, 247, 67,
            32, 113, 16, 107, 135, 171, 14, 45, 179, 214, 155, 117, 165, 56, 34, 114, 247, 89,
            216, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 4, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0,
            1, 0, 0, 0, 2, 0, 0, 0, 1, 0, 0, 0, 3, 0, 0, 0, 1, 0, 0, 0, 9, 107, 111, 109, 109,
            105, 116, 46, 99, 111, 0, 0, 0, 0, 0, 0, 0, 97, 85, 228, 156, 184, 154, 50, 219, 77,
            220, 159, 67, 114, 72, 240, 253, 129, 13, 47, 71, 58, 206, 164, 246, 161, 143, 9, 2,
            127, 137, 20, 131, 0, 0, 0, 2>>
      }
    end

    test "new/1", %{
      inflation_dest: inflation_dest,
      clear_flags: clear_flags,
      set_flags: set_flags,
      master_weight: master_weight,
      low_threshold: low_threshold,
      med_threshold: med_threshold,
      high_threshold: high_threshold,
      home_domain: home_domain,
      signer: signer
    } do
      %SetOptions{inflation_dest: ^inflation_dest, clear_flags: ^clear_flags, signer: ^signer} =
        SetOptions.new(
          inflation_dest,
          clear_flags,
          set_flags,
          master_weight,
          low_threshold,
          med_threshold,
          high_threshold,
          home_domain,
          signer
        )
    end

    test "encode_xdr/1", %{set_options: set_options, binary: binary} do
      {:ok, ^binary} = SetOptions.encode_xdr(set_options)
    end

    test "encode_xdr!/1", %{set_options: set_options, binary: binary} do
      ^binary = SetOptions.encode_xdr!(set_options)
    end

    test "decode_xdr/2", %{set_options: set_options, binary: binary} do
      {:ok, {^set_options, ""}} = SetOptions.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = SetOptions.decode_xdr(123)
    end

    test "decode_xdr!/2", %{set_options: set_options, binary: binary} do
      {^set_options, ^binary} = SetOptions.decode_xdr!(binary <> binary)
    end
  end
end
