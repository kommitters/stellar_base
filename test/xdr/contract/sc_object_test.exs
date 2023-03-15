defmodule StellarBase.XDR.SCObjectTest do
  use ExUnit.Case

  alias StellarBase.XDR.{SCAddress, SCAddressType, SCObject, SCObjectType}

  alias StellarBase.XDR.{
    AccountID,
    PublicKey,
    PublicKeyType,
    Int64,
    UInt256,
    SCValType,
    SCVal,
    SCVec,
    SCMap,
    SCMapEntry,
    SCContractCodeType,
    SCContractCode,
    Hash,
    UInt64,
    Int128Parts,
    VariableOpaque256000
  }

  alias StellarBase.StrKey

  describe "SCObject" do
    setup do
      ## SCVec structs
      sc_val_type = SCValType.new(:SCV_U63)
      int64 = Int64.new(2)
      sc_val = SCVal.new(int64, sc_val_type)

      ## SCMap structs
      key = SCVal.new(Int64.new(1), SCValType.new(:SCV_U63))
      val = SCVal.new(Int64.new(2), SCValType.new(:SCV_U63))
      scmap_entry = SCMapEntry.new(key, val)

      ## Int128Parts structs
      lo = UInt64.new(3312)
      hi = UInt64.new(3313)

      ## SCAddresss structs
      pk_type = PublicKeyType.new(:PUBLIC_KEY_TYPE_ED25519)

      account_id =
        "GBZNLMUQMIN3VGUJISKZU7GNY3O3XLMYEHJCKCSMDHKLGSMKALRXOEZD"
        |> StrKey.decode!(:ed25519_public_key)
        |> UInt256.new()
        |> PublicKey.new(pk_type)
        |> AccountID.new()

      sc_address_type = SCAddressType.new(:SC_ADDRESS_TYPE_ACCOUNT)

      ## SCContractCode structs
      contract_code = Hash.new("GCIZ3GSM5XL7OUS4UP64THMDZ7CZ3ZWN")
      sc_contract_code_type = SCContractCodeType.new(:SCCONTRACT_CODE_WASM_REF)


      discriminants = [
        %{
          sc_object_type: SCObjectType.new(:SCO_VEC),
          sc_object: SCVec.new([sc_val]),
          binary: <<0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2>>
        },
        %{
          sc_object_type: SCObjectType.new(:SCO_MAP),
          sc_object: SCMap.new([scmap_entry]),
          binary:
            <<0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,
              0, 0, 0, 2>>
        },
        %{
          sc_object_type: SCObjectType.new(:SCO_U64),
          sc_object: UInt64.new(18_446_744_073_709_551_615),
          binary: <<0, 0, 0, 2, 255, 255, 255, 255, 255, 255, 255, 255>>
        },
        %{
          sc_object_type: SCObjectType.new(:SCO_I64),
          sc_object: Int64.new(2),
          binary: <<0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 2>>
        },
        %{
          sc_object_type: SCObjectType.new(:SCO_U128),
          sc_object: Int128Parts.new(lo, hi),
          binary: <<0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 12, 240, 0, 0, 0, 0, 0, 0, 12, 241>>
        },
        %{
          sc_object_type: SCObjectType.new(:SCO_I128),
          sc_object: Int128Parts.new(lo, hi),
          binary: <<0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 12, 240, 0, 0, 0, 0, 0, 0, 12, 241>>
        },
        %{
          sc_object_type: SCObjectType.new(:SCO_BYTES),
          sc_object:
            VariableOpaque256000.new(<<0, 0, 0, 9, 71, 67, 73, 90, 51, 71, 83, 77, 53, 0, 0, 0>>),
          binary:
            <<0, 0, 0, 6, 0, 0, 0, 16, 0, 0, 0, 9, 71, 67, 73, 90, 51, 71, 83, 77, 53, 0, 0, 0>>
        },
        %{
          sc_object_type: SCObjectType.new(:SCO_CONTRACT_CODE),
          sc_object: SCContractCode.new(contract_code, sc_contract_code_type),
          binary:
            <<0, 0, 0, 7, 0, 0, 0, 0, 71, 67, 73, 90, 51, 71, 83, 77, 53, 88, 76, 55, 79, 85, 83,
              52, 85, 80, 54, 52, 84, 72, 77, 68, 90, 55, 67, 90, 51, 90, 87, 78>>
        },
        %{
          sc_object_type: SCObjectType.new(:SCO_ADDRESS),
          sc_object: SCAddress.new(account_id, sc_address_type),
          binary:
            <<0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 0, 114, 213, 178, 144, 98, 27, 186, 154, 137, 68,
              149, 154, 124, 205, 198, 221, 187, 173, 152, 33, 210, 37, 10, 76, 25, 212, 179, 73,
              138, 2, 227, 119>>
        },
        %{
          sc_object_type: SCObjectType.new(:SCO_NONCE_KEY),
          sc_object: SCAddress.new(account_id, sc_address_type),
          binary:
            <<0, 0, 0, 9, 0, 0, 0, 0, 0, 0, 0, 0, 114, 213, 178, 144, 98, 27, 186, 154, 137, 68,
              149, 154, 124, 205, 198, 221, 187, 173, 152, 33, 210, 37, 10, 76, 25, 212, 179, 73,
              138, 2, 227, 119>>
        }
      ]

      %{discriminants: discriminants}
    end

    test "new/1", %{discriminants: discriminants} do
      for %{sc_object_type: sc_object_type, sc_object: sc_object} <- discriminants do
        %SCObject{sc_object: ^sc_object, type: ^sc_object_type} =
          SCObject.new(sc_object, sc_object_type)
      end
    end

    test "encode_xdr/1", %{discriminants: discriminants} do
      for %{sc_object: sc_object, sc_object_type: sc_object_type, binary: binary} <- discriminants do
        xdr = SCObject.new(sc_object, sc_object_type)
        {:ok, ^binary} = SCObject.encode_xdr(xdr)
      end
    end

    test "encode_xdr!/1", %{discriminants: discriminants} do
      for %{sc_object: sc_object, sc_object_type: sc_object_type, binary: binary} <- discriminants do
        xdr = SCObject.new(sc_object, sc_object_type)
        ^binary = SCObject.encode_xdr!(xdr)
      end
    end

    test "encode_xdr/1 with an invalid type", %{discriminants: [sc_object | _rest]} do
      sc_object_type = SCObjectType.new(:NEW_ADDRESS)

      assert_raise XDR.EnumError,
                   "The key which you try to encode doesn't belong to the current declarations",
                   fn ->
                     sc_object
                     |> SCObject.new(sc_object_type)
                     |> SCObject.encode_xdr()
                   end
    end

    test "decode_xdr/2", %{discriminants: discriminants} do
      for %{sc_object: sc_object, sc_object_type: sc_object_type, binary: binary} <- discriminants do
        xdr = SCObject.new(sc_object, sc_object_type)
        {:ok, {^xdr, ""}} = SCObject.decode_xdr(binary)
      end
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = SCObject.decode_xdr(123)
    end

    test "decode_xdr!/2", %{discriminants: discriminants} do
      for %{sc_object: sc_object, sc_object_type: sc_object_type, binary: binary} <- discriminants do
        xdr = SCObject.new(sc_object, sc_object_type)
        {^xdr, ""} = SCObject.decode_xdr!(binary)
      end
    end

    # test "new/1", %{sc_address: sc_address, sc_object_type: sc_object_type} do
    #   %SCObject{sc_address: ^sc_address, type: ^sc_object_type} =
    #     SCObject.new(sc_address, sc_object_type)
    # end

    # test "encode_xdr/1", %{sc_object: sc_object, binary: binary} do
    #   {:ok, ^binary} = SCObject.encode_xdr(sc_object)
    # end

    # test "encode_xdr/1 with an invalid type", %{sc_address: sc_address} do
    #   sc_object_type = SCObjectType.new(:NEW_ADDRESS)

    #   assert_raise XDR.EnumError,
    #                "The key which you try to encode doesn't belong to the current declarations",
    #                fn ->
    #                  sc_address
    #                  |> SCObject.new(sc_object_type)
    #                  |> SCObject.encode_xdr()
    #                end
    # end

    # test "encode_xdr!/1", %{sc_object: sc_object, binary: binary} do
    #   ^binary = SCObject.encode_xdr!(sc_object)
    # end

    # test "decode_xdr/2", %{sc_object: sc_object, binary: binary} do
    #   {:ok, {^sc_object, ""}} = SCObject.decode_xdr(binary)
    # end

    # test "decode_xdr/2 with an invalid binary" do
    #   {:error, :not_binary} = SCObject.decode_xdr(123)
    # end

    # test "decode_xdr!/2", %{sc_object: sc_object, binary: binary} do
    #   {^sc_object, ^binary} = SCObject.decode_xdr!(binary <> binary)
    # end
  end
end
