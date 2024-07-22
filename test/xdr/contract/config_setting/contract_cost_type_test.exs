defmodule StellarBase.XDR.ContractCostTypeTest do
  use ExUnit.Case

  alias StellarBase.XDR.ContractCostType

  @codes [
    :WasmInsnExec,
    :MemAlloc,
    :MemCpy,
    :MemCmp,
    :DispatchHostFunction,
    :VisitObject,
    :ValSer,
    :ValDeser,
    :ComputeSha256Hash,
    :ComputeEd25519PubKey,
    :VerifyEd25519Sig,
    :VmInstantiation,
    :VmCachedInstantiation,
    :InvokeVmFunction,
    :ComputeKeccak256Hash,
    :DecodeEcdsaCurve256Sig,
    :RecoverEcdsaSecp256k1Key,
    :Int256AddSub,
    :Int256Mul,
    :Int256Div,
    :Int256Pow,
    :Int256Shift,
    :ChaCha20DrawBytes,
    :ParseWasmInstructions,
    :ParseWasmFunctions,
    :ParseWasmGlobals,
    :ParseWasmTableEntries,
    :ParseWasmTypes,
    :ParseWasmDataSegments,
    :ParseWasmElemSegments,
    :ParseWasmImports,
    :ParseWasmExports,
    :ParseWasmDataSegmentBytes,
    :InstantiateWasmInstructions,
    :InstantiateWasmFunctions,
    :InstantiateWasmGlobals,
    :InstantiateWasmTableEntries,
    :InstantiateWasmTypes,
    :InstantiateWasmDataSegments,
    :InstantiateWasmElemSegments,
    :InstantiateWasmImports,
    :InstantiateWasmExports,
    :InstantiateWasmDataSegmentBytes,
    :Sec1DecodePointUncompressed,
    :VerifyEcdsaSecp256r1Sig
  ]

  @binaries [
    <<0, 0, 0, 0>>,
    <<0, 0, 0, 1>>,
    <<0, 0, 0, 2>>,
    <<0, 0, 0, 3>>,
    <<0, 0, 0, 4>>,
    <<0, 0, 0, 5>>,
    <<0, 0, 0, 6>>,
    <<0, 0, 0, 7>>,
    <<0, 0, 0, 8>>,
    <<0, 0, 0, 9>>,
    <<0, 0, 0, 10>>,
    <<0, 0, 0, 11>>,
    <<0, 0, 0, 12>>,
    <<0, 0, 0, 13>>,
    <<0, 0, 0, 14>>,
    <<0, 0, 0, 15>>,
    <<0, 0, 0, 16>>,
    <<0, 0, 0, 17>>,
    <<0, 0, 0, 18>>,
    <<0, 0, 0, 19>>,
    <<0, 0, 0, 20>>,
    <<0, 0, 0, 21>>,
    <<0, 0, 0, 22>>,
    <<0, 0, 0, 23>>,
    <<0, 0, 0, 24>>,
    <<0, 0, 0, 25>>,
    <<0, 0, 0, 26>>,
    <<0, 0, 0, 27>>,
    <<0, 0, 0, 28>>,
    <<0, 0, 0, 29>>,
    <<0, 0, 0, 30>>,
    <<0, 0, 0, 31>>,
    <<0, 0, 0, 32>>,
    <<0, 0, 0, 33>>,
    <<0, 0, 0, 34>>,
    <<0, 0, 0, 35>>,
    <<0, 0, 0, 36>>,
    <<0, 0, 0, 37>>,
    <<0, 0, 0, 38>>,
    <<0, 0, 0, 39>>,
    <<0, 0, 0, 40>>,
    <<0, 0, 0, 41>>,
    <<0, 0, 0, 42>>,
    <<0, 0, 0, 43>>,
    <<0, 0, 0, 44>>
  ]

  describe "ContractCostType" do
    setup do
      %{
        codes: @codes,
        results: Enum.map(@codes, &ContractCostType.new/1),
        binaries: @binaries
      }
    end

    test "new/1", %{codes: types} do
      for type <- types,
          do: %ContractCostType{identifier: ^type} = ContractCostType.new(type)
    end

    test "encode_xdr/1", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: {:ok, ^binary} = ContractCostType.encode_xdr(result)
    end

    test "encode_xdr/1 with an invalid code" do
      {:error, :invalid_key} = ContractCostType.encode_xdr(%ContractCostType{identifier: :TEST})
    end

    test "encode_xdr!/1", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: ^binary = ContractCostType.encode_xdr!(result)
    end

    test "decode_xdr/2", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: {:ok, {^result, ""}} = ContractCostType.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid declaration" do
      {:error, :invalid_key} = ContractCostType.decode_xdr(<<1, 0, 0, 1>>)
    end

    test "decode_xdr!/2", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: {^result, ^binary} = ContractCostType.decode_xdr!(binary <> binary)
    end

    test "decode_xdr!/2 with an error code", %{binaries: binaries} do
      for binary <- binaries,
          do: {%ContractCostType{identifier: _}, ""} = ContractCostType.decode_xdr!(binary)
    end
  end
end
