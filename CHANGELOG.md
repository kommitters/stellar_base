# Changelog

## 0.11.1 (01.06.2023)

* [Add missing value types in SCVal](https://github.com/kommitters/stellar_base/pull/270).
* Update all dependencies.

## 0.11.0 (30.05.2023)

* [Soroban Preview 9 support](https://github.com/kommitters/stellar_base/issues/265) with its respective [Preview 9 changes](https://github.com/stellar/stellar-xdr/compare/7356dc237ee0db5626561c129fb3fa4beaabbac6...2f16687fdf6f4bcfb56805e2035f69997f4b34c4).

## 0.10.2 (02.05.2023)

* Add missing version_byte type in strkey.
* Update all dependencies.
* Add new domain `builds.hex.pm:443` to Harden Runner allowed-endpoints list. 

## 0.10.1 (02.05.2023)

* Add missing contract version_byte in StrKey.

## 0.10.0 (24.04.2023)

* Add [Soroban Preview 8](https://soroban.stellar.org/docs/reference/releases#preview-8-april-4th-2023) Support in the XDR version: [7356dc237ee0db5626561c129fb3fa4beaabbac6](https://github.com/stellar/stellar-xdr/commit/7356dc237ee0db5626561c129fb3fa4beaabbac6) with its respective [Preview 8 changes](https://github.com/stellar/stellar-xdr/compare/df18148747e807618acf4639db41c4fd6f0be9fc...7356dc237ee0db5626561c129fb3fa4beaabbac6#diff-891b3a6e0eb8f9ac887a8129e2c821931837fb42224200ee78cce639eeb61c15).

## 0.9.1 (31.03.2023)
* Update boundary for InvokeHostFuntion, from `StellarBase.XDR.InvokeHostFunctionOp` to `StellarBase.XDR.Operations.InvokeHostFunction`.

## 0.9.0 (29.03.2023)
* Add [CAP-0046 support](https://github.com/kommitters/stellar_base/issues/223) in the XDR version: [df18148747e807618acf4639db41c4fd6f0be9fc](https://github.com/stellar/stellar-xdr/commit/df18148747e807618acf4639db41c4fd6f0be9fc) which corresponds to the [Soroban Preview 7](https://soroban.stellar.org/docs/reference/releases#preview-7-february-16th-2023).
* Update all dependencies.
* Fix LICENSE badge URL.

## 0.8.11 (16.01.2023)
* Update all dependencies.
* Block egress traffic in GitHub Actions.
* Add stability badge in README.

## 0.8.10 (27.12.2022)
* Add Renovate as dependency update tool.
* Add default permissions as read-only in the CI workflow.

## 0.8.9 (22.12.2022)
* Harden GitHub Actions.

## 0.8.8 (20.12.2022)
* Update build badge and lock to ubuntu-20.04.

## 0.8.7 (31.10.2022)
* Bump `ossf/scorecard-action` to v2.0.6.

## 0.8.6 (31.10.2022)
* Fix wrong binary encoding in the `AssetCode12` module.

## 0.8.5 (25.10.2022)
* Enable ExCoveralls with parallel builds.

## 0.8.4 (18.10.2022)
* Include OpenSSF BestPractices & Scorecard badges in README.

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
