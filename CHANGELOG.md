# Changelog

## 0.8.3 (04.10.2022)
* Fix preconditions typespec.

## 0.8.2 (08.08.2022)
* Add scorecards actions

## 0.8.1 (02.08.2022)
* Add `SignerKeyEd25519SignedPayload` to the signer_key param in the SignerKey structure.
* Add `signer_payload` version to the arms of the `StrKey`.

## 0.8.0 (27.07.2022)
* Implement Stellar CAP-40.
* Add XDR types for SponsorshipDescriptorList.
* Update SponsorshipDescriptor implementation.
* Update AccountEntryExtensionV2 implementation.

## 0.7.0 (26.07.2022)
* Implement Stellar CAP-21.
* Automate library release to Hex.pm.
* Add XDR types for AccountEntry.
* Add tests for ClaimableBalanceFlags.

## 0.6.1 (21.07.2022)
* Add the flags property to the OfferEntry.
* Add security policy to repository.

## 0.6.0 (21.03.2022)
* XDR types for LedgerEntryExtension, ClaimableBalanceEntry, ClaimableBalanceFlags, DataEntry, TrustLineEntry and OfferEntryFlags.

## 0.5.0 (09.02.2022)
* Add support for encoding/decoding ed25519 muxed accounts.
* XDR types for AccountFlags, TrustLineFlags, ThresholdIndexes and Liabilities.

## 0.4.0 (27.01.2022)
* Group XDR constructions as stellar-core does.
* Complement test cases for operation CodeResults modules.

## 0.3.0 (17.12.2021)
* XDR construction for HashIDPreimage.
* Use OptionalSigner instead of  Signer in SetOptions operation.

## 0.2.3 (6.12.2021)
* Keep the XDR struct components ordered to avoid binary data corruption.

## 0.2.2 (3.12.2021)
* Refactor Operation module.
* XDR types for AccountEntryExtensionV2.

## 0.2.1 (10.11.2021)
* Decouple ed25519 key-pair implementation from StellarBase.
* XDR types for Thresholds and Signers.

## 0.2.0 (05.11.2021)
* Replace main namespace from Stellar to StellarBase

## 0.1.3 (01.11.2021)
* XDR types for Transactions and Transactions Envelopes.
* XDR types for TransactionResults.
* XDR types for OperationResults.
* XDR types for DecoratedSignatures.
* MuxedAccount and TransactionExt refactor.

## 0.1.2 (05.10.2021)
* XDR types for Assets.
* XDR types for Operations.
* Ledger XDR-base types.
* Increase test coverage.

## 0.1.1 (26.08.2021)
* Increase test coverage.
* Integrate Dialyzer.

## 0.1.0 (09.08.2021)
* Ed25519 KeyPair generation.
* Transactions XDR types.
* Accounts XDR types.
* Keys XDR types.
* Base XDR types.
