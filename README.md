# Elixir Stellar Base
![Build Badge](https://img.shields.io/github/workflow/status/kommitters/stellar_base/StellarBase%20CI/main?style=for-the-badge)
[![Coverage Status](https://img.shields.io/coveralls/github/kommitters/stellar_base?style=for-the-badge)](https://coveralls.io/github/kommitters/stellar_base)
[![Version Badge](https://img.shields.io/hexpm/v/stellar_base?style=for-the-badge)](https://hexdocs.pm/stellar_base)
![Downloads Badge](https://img.shields.io/hexpm/dt/stellar_base?style=for-the-badge)
[![License badge](https://img.shields.io/hexpm/l/stellar_base.svg?style=for-the-badge)](https://github.com/kommitters/stellar_base/blob/main/LICENSE.md)

### ⚠️ Warning! This library is under active development. DO NOT use it in production environments.

`stellar_base` is an **Elixir library** that provides a complete set of functions to read, write, hash, and sign XDR primitive constructs used in [stellar-core][stellar-core].

This library is aimed at developers building Elixir applications on top of the Stellar network. Transactions constructed by this library may be submitted to any Horizon instance for processing onto the ledger, using any Stellar SDK client. The recommended client for Elixir programmers is [stellar_sdk][sdk].

## stellar_base vs stellar_sdk
* `stellar_sdk` is a high-level library that serves as server-side API for Horizon.
* `stellar_base` is lower-level library for creating Stellar primitive constructs via XDR helpers and wrappers.
* Use the `stellar_base` library if you are planning to build on top of it.

## Installation
[Available in Hex][hex], add `stellar_base` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:stellar_base, "~> 0.2.1"}
  ]
end
```

## Development
* Install any Elixir version above 1.10.
* Compile dependencies: `mix deps.get`.
* Run tests: `mix test`.

## Code of conduct
We welcome everyone to contribute. Make sure you have read the [CODE_OF_CONDUCT][coc] before.

## Contributing
For information on how to contribute, please refer to our [CONTRIBUTING][contributing] guide.

## Changelog
Features and bug fixes are listed in the [CHANGELOG][changelog] file.

## License
This library is licensed under an MIT license. See [LICENSE][license] for details.

## Acknowledgements
Made with 💙 by [kommitters Open Source](https://kommit.co)

[license]: https://github.com/kommitters/stellar_base/blob/main/LICENSE.md
[coc]: https://github.com/kommitters/stellar_base/blob/main/CODE_OF_CONDUCT.md
[changelog]: https://github.com/kommitters/stellar_base/blob/main/CHANGELOG.md
[contributing]: https://github.com/kommitters/stellar_base/blob/main/CONTRIBUTING.md
[base]: https://github.com/kommitters/stellar_base
[sdk]: https://github.com/kommitters/stellar_sdk
[hex]: https://hex.pm/packages/stellar_base
[stellar-core]: https://github.com/stellar/stellar-core
