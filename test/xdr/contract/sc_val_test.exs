defmodule StellarBase.XDR.SCValTest do
  use ExUnit.Case

  alias StellarBase.StrKey

  alias StellarBase.XDR.{
    AccountID,
    Bool,
    Duration,
    Hash,
    Int32,
    Int64,
    Int128Parts,
    SCAddress,
    SCAddressType,
    OptionalSCMap,
    OptionalSCVec,
    PublicKeyType,
    PublicKey,
    SCBytes,
    SCNonceKey,
    SCContractExecutable,
    SCContractExecutableType,
    SCVal,
    SCValType,
    SCStatus,
    SCStatusType,
    SCString,
    SCSymbol,
    SCUnknownErrorCode,
    TimePoint,
    Uint256,
    Uint32,
    Uint64,
    Void
  }

  describe "SCVal" do
    setup do
      # SCAddress
      pk_type = PublicKeyType.new(:PUBLIC_KEY_TYPE_ED25519)

      account_id =
        "GBZNLMUQMIN3VGUJISKZU7GNY3O3XLMYEHJCKCSMDHKLGSMKALRXOEZD"
        |> StrKey.decode!(:ed25519_public_key)
        |> Uint256.new()
        |> PublicKey.new(pk_type)
        |> AccountID.new()

      sc_address_type = SCAddressType.new(:SC_ADDRESS_TYPE_ACCOUNT)
      sc_address = SCAddress.new(account_id, sc_address_type)

      # SCContractExecutable
      sc_contract_executable_type = SCContractExecutableType.new(:SCCONTRACT_EXECUTABLE_WASM_REF)

      sc_contract_executable =
        "GCIZ3GSM5XL7OUS4UP64THMDZ7CZ3ZWN"
        |> Hash.new()
        |> SCContractExecutable.new(sc_contract_executable_type)

      discriminants = [
        %{
          val_type: SCValType.new(:SCV_BOOL),
          value: Bool.new(true),
          binary: <<0, 0, 0, 0, 0, 0, 0, 1>>
        },
        %{
          val_type: SCValType.new(:SCV_VOID),
          value: Void.new(),
          binary: <<0, 0, 0, 1>>
        },
        %{
          val_type: SCValType.new(:SCV_STATUS),
          value:
            SCStatus.new(
              SCUnknownErrorCode.new(:UNKNOWN_ERROR_GENERAL),
              SCStatusType.new(:SST_UNKNOWN_ERROR)
            ),
          binary: <<0, 0, 0, 2, 0, 0, 0, 1, 0, 0, 0, 0>>
        },
        %{
          val_type: SCValType.new(:SCV_U32),
          value: Uint32.new(2),
          binary: <<0, 0, 0, 3, 0, 0, 0, 2>>
        },
        %{
          val_type: SCValType.new(:SCV_I32),
          value: Int32.new(2),
          binary: <<0, 0, 0, 4, 0, 0, 0, 2>>
        },
        %{
          val_type: SCValType.new(:SCV_U64),
          value: Uint64.new(4),
          binary: <<0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 4>>
        },
        %{
          val_type: SCValType.new(:SCV_I64),
          value: Int64.new(4),
          binary: <<0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 4>>
        },
        %{
          val_type: SCValType.new(:SCV_TIMEPOINT),
          value: TimePoint.new(Uint64.new(1234)),
          binary: <<0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 4, 210>>
        },
        %{
          val_type: SCValType.new(:SCV_DURATION),
          value: Duration.new(Uint64.new(1234)),
          binary: <<0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 4, 210>>
        },
        %{
          val_type: SCValType.new(:SCV_U128),
          value: Int128Parts.new(Uint64.new(3312), Uint64.new(3313)),
          binary: <<0, 0, 0, 9, 0, 0, 0, 0, 0, 0, 12, 240, 0, 0, 0, 0, 0, 0, 12, 241>>
        },
        %{
          val_type: SCValType.new(:SCV_I128),
          value: Int128Parts.new(Uint64.new(3312), Uint64.new(3313)),
          binary: <<0, 0, 0, 10, 0, 0, 0, 0, 0, 0, 12, 240, 0, 0, 0, 0, 0, 0, 12, 241>>
        },
        %{
          val_type: SCValType.new(:SCV_U256),
          value:
            Uint256.new(
              <<72, 101, 108, 108, 111, 32, 119, 111, 114, 108, 100, 0, 21, 0, 1, 0, 72, 101, 108,
                108, 111, 32, 119, 111, 114, 108, 100, 0, 21, 0, 1, 0>>
            ),
          binary:
            <<0, 0, 0, 11, 72, 101, 108, 108, 111, 32, 119, 111, 114, 108, 100, 0, 21, 0, 1, 0,
              72, 101, 108, 108, 111, 32, 119, 111, 114, 108, 100, 0, 21, 0, 1, 0>>
        },
        %{
          val_type: SCValType.new(:SCV_I256),
          value:
            Uint256.new(
              <<72, 101, 108, 108, 111, 32, 119, 111, 114, 108, 100, 0, 21, 0, 1, 0, 72, 101, 108,
                108, 111, 32, 119, 111, 114, 108, 100, 0, 21, 0, 1, 0>>
            ),
          binary:
            <<0, 0, 0, 12, 72, 101, 108, 108, 111, 32, 119, 111, 114, 108, 100, 0, 21, 0, 1, 0,
              72, 101, 108, 108, 111, 32, 119, 111, 114, 108, 100, 0, 21, 0, 1, 0>>
        },
        %{
          val_type: SCValType.new(:SCV_BYTES),
          value: SCBytes.new("GCIZ3GSM5"),
          binary: <<0, 0, 0, 13, 0, 0, 0, 9, 71, 67, 73, 90, 51, 71, 83, 77, 53, 0, 0, 0>>
        },
        %{
          val_type: SCValType.new(:SCV_STRING),
          value: SCString.new("Hello"),
          binary: <<0, 0, 0, 14, 0, 0, 0, 5, 72, 101, 108, 108, 111, 0, 0, 0>>
        },
        %{
          val_type: SCValType.new(:SCV_SYMBOL),
          value: SCSymbol.new("World"),
          binary: <<0, 0, 0, 15, 0, 0, 0, 5, 87, 111, 114, 108, 100, 0, 0, 0>>
        },
        %{
          val_type: SCValType.new(:SCV_VEC),
          value: OptionalSCVec.new(nil),
          binary: <<0, 0, 0, 16, 0, 0, 0, 0>>
        },
        %{
          val_type: SCValType.new(:SCV_MAP),
          value: OptionalSCMap.new(nil),
          binary: <<0, 0, 0, 17, 0, 0, 0, 0>>
        },
        %{
          val_type: SCValType.new(:SCV_CONTRACT_EXECUTABLE),
          value: sc_contract_executable,
          binary:
            <<0, 0, 0, 18, 0, 0, 0, 0, 71, 67, 73, 90, 51, 71, 83, 77, 53, 88, 76, 55, 79, 85, 83,
              52, 85, 80, 54, 52, 84, 72, 77, 68, 90, 55, 67, 90, 51, 90, 87, 78>>
        },
        %{
          val_type: SCValType.new(:SCV_ADDRESS),
          value: sc_address,
          binary:
            <<0, 0, 0, 19, 0, 0, 0, 0, 0, 0, 0, 0, 114, 213, 178, 144, 98, 27, 186, 154, 137, 68,
              149, 154, 124, 205, 198, 221, 187, 173, 152, 33, 210, 37, 10, 76, 25, 212, 179, 73,
              138, 2, 227, 119>>
        },
        %{
          val_type: SCValType.new(:SCV_LEDGER_KEY_CONTRACT_EXECUTABLE),
          value: Void.new(),
          binary: <<0, 0, 0, 20>>
        },
        %{
          val_type: SCValType.new(:SCV_LEDGER_KEY_NONCE),
          value: SCNonceKey.new(sc_address),
          binary:
            <<0, 0, 0, 21, 0, 0, 0, 0, 0, 0, 0, 0, 114, 213, 178, 144, 98, 27, 186, 154, 137, 68,
              149, 154, 124, 205, 198, 221, 187, 173, 152, 33, 210, 37, 10, 76, 25, 212, 179, 73,
              138, 2, 227, 119>>
        }
      ]

      %{discriminants: discriminants}
    end

    test "new/1", %{discriminants: discriminants} do
      for %{val_type: val_type, value: value} <- discriminants do
        %SCVal{value: ^value, type: ^val_type} = SCVal.new(value, val_type)
      end
    end

    test "encode_xdr/1", %{discriminants: discriminants} do
      for %{value: value, val_type: val_type, binary: binary} <- discriminants do
        xdr = SCVal.new(value, val_type)
        {:ok, ^binary} = SCVal.encode_xdr(xdr)
      end
    end

    test "encode_xdr!/1", %{discriminants: discriminants} do
      for %{value: value, val_type: val_type, binary: binary} <- discriminants do
        xdr = SCVal.new(value, val_type)
        ^binary = SCVal.encode_xdr!(xdr)
      end
    end

    test "decode_xdr/2", %{discriminants: discriminants} do
      for %{value: value, val_type: val_type, binary: binary} <- discriminants do
        xdr = SCVal.new(value, val_type)
        {:ok, {^xdr, ""}} = SCVal.decode_xdr(binary)
      end
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = SCVal.decode_xdr(123)
    end

    test "decode_xdr!/2", %{discriminants: discriminants} do
      for %{value: value, val_type: val_type, binary: binary} <- discriminants do
        xdr = SCVal.new(value, val_type)
        {^xdr, ""} = SCVal.decode_xdr!(binary)
      end
    end
  end
end
