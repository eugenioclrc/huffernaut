<img align="right" width="150" height="150" top="100" src="./assets/blueprint.png">


# Huffernaut • [![ci](https://github.com/huff-language/huff-project-template/actions/workflows/ci.yaml/badge.svg)](https://github.com/huff-language/huff-project-template/actions/workflows/ci.yaml) ![license](https://img.shields.io/github/license/huff-language/huff-project-template.svg) ![solidity](https://img.shields.io/badge/solidity-^0.8.15-lightgrey)

Huffernaut is an educational project that aims to solve all Ethernaut challenges using the Huff programming language. This project is designed for developers who want to learn and improve their skills in Ethereum smart contract development, particularly with the low-level Huff language.

## Table of Contents
1. [Introduction](#introduction)
2. [Prerequisites](#prerequisites)
3. [Challenges](#challenges)
4. [Acknowledgements](#acknowledgements)
5. [License](#license)

## Introduction

Ethernaut is a popular series of smart contract security challenges on the Ethereum blockchain. This project, Huffernaut, aims to provide solutions for these challenges using the Huff programming language. Huff is a low-level language that compiles directly to EVM bytecode, allowing developers to create highly optimized and efficient smart contracts.


### Requirements

The following will need to be installed in order to use this template. Please follow the links and instructions.

-   [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)  
    -   You'll know you've done it right if you can run `git --version`
-   [Foundry / Foundryup](https://github.com/gakonst/foundry)
    -   This will install `forge`, `cast`, and `anvil`
    -   You can test you've installed them right by running `forge --version` and get an output like: `forge 0.2.0 (92f8951 2022-08-06T00:09:32.96582Z)`
    -   To get the latest of each, just run `foundryup`
-   [Huff Compiler](https://docs.huff.sh/get-started/installing/)
    -   You'll know you've done it right if you can run `huffc --version` and get an output like: `huffc 0.3.0`

### Quickstart

1. Clone this repo or use template

Click "Use this template" on [GitHub](https://github.com/huff-language/huff-project-template) to create a new repository with this repo as the initial state.

Or run:

```
git clone https://github.com/huff-language/huff-project-template
cd huff-project-template
```

2. Install dependencies

Once you've cloned and entered into your repository, you need to install the necessary dependencies. In order to do so, simply run:

```shell
forge install
```

3. Build & Test

To build and test your contracts, you can run:

```shell
forge build
forge test
```

For more information on how to use Foundry, check out the [Foundry Github Repository](https://github.com/foundry-rs/foundry/tree/master/forge) and the [foundry-huff library repository](https://github.com/huff-language/foundry-huff).


## Challenges

Inside the `src` folder, you will find a separate folder for each challenge. Each of these folders contains the following:

- `original`: The original challenge, including the Solidity source code and any additional files.
- `hack`: The Huffernaut solution using the Huff programming language, along with any necessary supporting files.

Some of the original challenges have been updated to use the latest version of Solidity.

To explore the challenges and their respective solutions, navigate to the appropriate subfolder within the `src` directory.


Inside the `test` folder you will find one test cases per challenge for both the traditional solution (using Solidity) and the Huffernaut solution (using Huff).


### Challenges solved
1) DelegateCall
2) Fallout
3) Coinflip


## License

[The Unlicense](https://github.com/huff-language/huff-project-template/blob/master/LICENSE)


## Acknowledgements

- [forge-template](https://github.com/foundry-rs/forge-template)
- [femplate](https://github.com/abigger87/femplate)


## Disclaimer

_These smart contracts are being provided as is. No guarantee, representation or warranty is being made, express or implied, as to the safety or correctness of the user interface or the smart contracts. They have not been audited and as such there can be no assurance they will work as intended, and users may experience delays, failures, errors, omissions, loss of transmitted information or loss of funds. The creators are not liable for any of the foregoing. Users should proceed with caution and use at their own risk._