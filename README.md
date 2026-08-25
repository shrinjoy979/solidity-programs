# Solidity Programs

A collection of standalone Solidity contracts written as learning exercises, covering basic arithmetic, cross-contract calls, a time-locked "will" contract, and two token implementations (a hand-rolled ERC20-style token and an OpenZeppelin-based one). Each `.sol` file is independent — there is no shared build setup, test suite, or deployment scripts in this repository.

## Tech Stack

- Solidity (`^0.8.0` / `^0.8.26` depending on the file)
- OpenZeppelin Contracts (used only by `5-my-token-ERC20.sol`)

## Contracts

### `1-arithmetic-operations-contract.sol` — `Arithmetic`

A basic contract exposing `add`, `subtract`, `multiply`, and `divide` over `uint256` values. `subtract` reverts if the result would be negative, and `divide` reverts on division by zero. The file includes the original exercise's problem statement as a trailing comment.

### `2-storage.sol` — `Storage`

A minimal contract holding a single public `num` value, set in the constructor, with a `getNum()` getter and an `add()` function that increments it by one.

### `2-cci.sol` — `CCI`

A cross-contract interaction (CCI) example. It defines an `IStorage` interface matching `Storage`'s public functions and calls into a hardcoded deployed `Storage` contract address (`0x9C22ce44f598cf5616c28a25b3514a1f293B3919`) via `proxyAdd()` and `proxyGet()`, demonstrating how one contract can call functions on another through an interface.

### `3-will-contract.sol` — `Will`

A per-user "digital will" contract. Each user deploys their own instance, funding it at deployment and naming a recipient. The idea is that the owner periodically "pings" the contract to prove they're still active; if a year passes without a ping, the recipient becomes able to withdraw the deposited funds.

- `changeReceipient(address)` — updates the recipient.
- `ping()` — intended to let the owner record activity.
- `drain(address)` — intended to let the recipient withdraw funds once the owner has been inactive for over a year.
- `withdrawFundsByOwner()` — intended to let the owner withdraw the deposit directly.

### `4-ShrinjoyCoin.sol` — `ShrinjoyCoin`

A hand-written ERC20-style token (not inheriting from any standard library), implementing `approve`, `transferFrom`, `transfer`, and owner-only `mint` / `mintTo`, with public `name` ("ShrinjoyCoin") and `symbol` ("SH") fields, plus `balances` and `allowances` mappings.

### `5-my-token-ERC20.sol` — `MyMintableToken`

A standard mintable ERC20 token built on OpenZeppelin's `ERC20` and `Ownable` contracts, named "MyMintableToken" (symbol `MMT`). It mints an initial supply of 1,000,000,000 base units to the deployer, and exposes an `onlyOwner` `mint` function for creating additional tokens.

## Getting Started

These are standalone files rather than a configured Hardhat/Foundry project. To compile or test them, add them to a Solidity toolchain of your choice, for example:

```
# Foundry
forge init
# copy the .sol files into src/, then:
forge build

# or Hardhat
npx hardhat init
# copy the .sol files into contracts/, then:
npx hardhat compile
```

`5-my-token-ERC20.sol` additionally requires the OpenZeppelin Contracts library:

```
npm install @openzeppelin/contracts
```

## Notes

- These contracts are learning exercises and have not been audited; several are simplified for demonstration purposes.
- `2-cci.sol` calls a hardcoded contract address, so it will only function correctly against a network where a matching `Storage` contract has actually been deployed at that address.
- `3-will-contract.sol`'s access-control checks (in `ping()`, `drain()`, and `withdrawFundsByOwner()`) currently use conditions that don't match the described intent (for example, `ping()` requires the caller to *not* be the owner, and `drain()`'s time check compares `lastPingedTimestamp` against itself rather than the current block time) — worth reviewing before relying on this contract's access control.
- `4-ShrinjoyCoin.sol` is written from scratch rather than following the ERC20 interface/standard exactly (for example, it lacks `Transfer`/`Approval` events and the standard function signatures), so it isn't directly compatible with tooling that expects a conforming ERC20 token.
