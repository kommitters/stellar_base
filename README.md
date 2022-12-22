![Build Badge](https://img.shields.io/github/actions/workflow/status/kommitters/stellar_base/ci.yml?branch=main&style=for-the-badge)
[![Coverage Status](https://img.shields.io/coveralls/github/kommitters/stellar_base?style=for-the-badge)](https://coveralls.io/github/kommitters/stellar_base)
[![Version Badge](https://img.shields.io/hexpm/v/stellar_base?style=for-the-badge)](https://hexdocs.pm/stellar_base)
![Downloads Badge](https://img.shields.io/hexpm/dt/stellar_base?style=for-the-badge)
[![License badge](https://img.shields.io/hexpm/l/stellar_base.svg?style=for-the-badge)](https://github.com/kommitters/stellar_base/blob/main/LICENSE.md)
[![OpenSSF Best Practices](https://img.shields.io/cii/summary/6461?label=openssf%20best%20practices&style=for-the-badge)](https://bestpractices.coreinfrastructure.org/projects/6461)
[![OpenSSF Scorecard](https://img.shields.io/ossf-scorecard/github.com/kommitters/stellar_base?label=openssf%20scorecard&style=for-the-badge)](https://api.securityscorecards.dev/projects/github.com/kommitters/stellar_base)

# Elixir Stellar Base

**`stellar_base`** is an **Elixir library** that provides a complete set of functions to read, write, hash, and sign XDR constructs used in [stellar-core][stellar-core].

### Stellar Base vs Stellar SDK
**`stellar_base`** is a low-level library for creating Stellar primitive constructs. If you are looking for a complete [**Horizon**][stellar-horizon] integration we recommend you check the [**`stellar_sdk`**][sdk] library instead 🙌.

You should only use **`stellar_base`** if you are planning to build on top of it!

### Documentation
[**API Reference**][api-reference]

## Installation
[Available in Hex][hex], add `stellar_base` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:stellar_base, "~> 0.8.9"}
  ]
end
```

## Development
* Install an Elixir version above `v1.10`.
* Compile dependencies: `mix deps.get`.
* Run tests: `mix test`.

## Code of conduct
We welcome everyone to contribute. Make sure you have read the [CODE OF CONDUCT][coc] before.

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
[stellar-horizon]: https://developers.stellar.org/api/introduction/
[api-reference]: https://hexdocs.pm/stellar_base/api-reference.html#content
