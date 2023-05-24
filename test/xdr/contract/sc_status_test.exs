defmodule StellarBase.XDR.SCStatusTest do
  use ExUnit.Case

  alias StellarBase.XDR.{
    SCUnknownErrorCode,
    SCHostValErrorCode,
    SCHostObjErrorCode,
    SCHostFnErrorCode,
    SCHostStorageErrorCode,
    SCHostContextErrorCode,
    SCVmErrorCode,
    SCHostAuthErrorCode,
    SCStatus,
    SCStatusType,
    Uint32,
    Void
  }

  describe "SCStatus" do
    setup do
      discriminants = [
        %{
          status_type: SCStatusType.new(:SST_OK),
          sc_code: Void.new(),
          binary: <<0, 0, 0, 0>>
        },
        %{
          status_type: SCStatusType.new(:SST_UNKNOWN_ERROR),
          sc_code: SCUnknownErrorCode.new(:UNKNOWN_ERROR_GENERAL),
          binary: <<0, 0, 0, 1, 0, 0, 0, 0>>
        },
        %{
          status_type: SCStatusType.new(:SST_HOST_VALUE_ERROR),
          sc_code: SCHostValErrorCode.new(:HOST_VALUE_UNKNOWN_ERROR),
          binary: <<0, 0, 0, 2, 0, 0, 0, 0>>
        },
        %{
          status_type: SCStatusType.new(:SST_HOST_OBJECT_ERROR),
          sc_code: SCHostObjErrorCode.new(:HOST_OBJECT_UNKNOWN_ERROR),
          binary: <<0, 0, 0, 3, 0, 0, 0, 0>>
        },
        %{
          status_type: SCStatusType.new(:SST_HOST_FUNCTION_ERROR),
          sc_code: SCHostFnErrorCode.new(:HOST_FN_UNKNOWN_ERROR),
          binary: <<0, 0, 0, 4, 0, 0, 0, 0>>
        },
        %{
          status_type: SCStatusType.new(:SST_HOST_STORAGE_ERROR),
          sc_code: SCHostStorageErrorCode.new(:HOST_STORAGE_UNKNOWN_ERROR),
          binary: <<0, 0, 0, 5, 0, 0, 0, 0>>
        },
        %{
          status_type: SCStatusType.new(:SST_HOST_CONTEXT_ERROR),
          sc_code: SCHostContextErrorCode.new(:HOST_CONTEXT_UNKNOWN_ERROR),
          binary: <<0, 0, 0, 6, 0, 0, 0, 0>>
        },
        %{
          status_type: SCStatusType.new(:SST_VM_ERROR),
          sc_code: SCVmErrorCode.new(:VM_UNKNOWN),
          binary: <<0, 0, 0, 7, 0, 0, 0, 0>>
        },
        %{
          status_type: SCStatusType.new(:SST_CONTRACT_ERROR),
          sc_code: Uint32.new(3312),
          binary: <<0, 0, 0, 8, 0, 0, 12, 240>>
        },
        %{
          status_type: SCStatusType.new(:SST_HOST_AUTH_ERROR),
          sc_code: SCHostAuthErrorCode.new(:HOST_AUTH_UNKNOWN_ERROR),
          binary: <<0, 0, 0, 9, 0, 0, 0, 0>>
        }
      ]

      %{discriminants: discriminants}
    end

    test "new/1", %{discriminants: discriminants} do
      for %{status_type: status_type, sc_code: sc_code} <- discriminants do
        %SCStatus{value: ^sc_code, type: ^status_type} = SCStatus.new(sc_code, status_type)
      end
    end

    test "encode_xdr/1", %{discriminants: discriminants} do
      for %{sc_code: sc_code, status_type: status_type, binary: binary} <- discriminants do
        xdr = SCStatus.new(sc_code, status_type)
        {:ok, ^binary} = SCStatus.encode_xdr(xdr)
      end
    end

    test "encode_xdr!/1", %{discriminants: discriminants} do
      for %{sc_code: sc_code, status_type: status_type, binary: binary} <- discriminants do
        xdr = SCStatus.new(sc_code, status_type)
        ^binary = SCStatus.encode_xdr!(xdr)
      end
    end

    test "decode_xdr/2", %{discriminants: discriminants} do
      for %{sc_code: sc_code, status_type: status_type, binary: binary} <- discriminants do
        xdr = SCStatus.new(sc_code, status_type)
        {:ok, {^xdr, ""}} = SCStatus.decode_xdr(binary)
      end
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = SCStatus.decode_xdr(123)
    end

    test "decode_xdr!/2", %{discriminants: discriminants} do
      for %{sc_code: sc_code, status_type: status_type, binary: binary} <- discriminants do
        xdr = SCStatus.new(sc_code, status_type)
        {^xdr, ""} = SCStatus.decode_xdr!(binary)
      end
    end
  end
end
