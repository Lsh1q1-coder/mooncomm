# MoonComm

MoonComm is a deterministic collective communication algorithm simulator and
cost estimator written in MoonBit. It is designed for learning, comparing, and
testing collective schedules without requiring a GPU, NPU, or compute cluster.

> Status: active development for the 2026 MoonBit September Hackathon.

## Goals

- Model ranks, links, message fragments, and communication rounds.
- Generate schedules for Scatter, Broadcast, AllGather, and AllReduce.
- Compare Direct, Ring, and Tree algorithm families.
- Validate data provenance and final receive states.
- Estimate latency from explicit link latency and bandwidth parameters.
- Produce reproducible CLI and structured results on an ordinary computer.

MoonComm is an analytical and educational tool. Its estimates expose their
assumptions and are not presented as measurements of a specific hardware
platform.

## Current milestone

The repository currently contains the tested deterministic cost-model
foundation:

- balanced-tree round calculation, including non-power-of-two rank counts;
- ring AllReduce phase calculation;
- integer alpha-beta transfer estimates;
- a runnable command-line demonstration;
- black-box tests for the public API.

Schedule generation and semantic verification are the next milestones.

## Quick start

Install the current [MoonBit toolchain](https://www.moonbitlang.com/download),
then run:

```bash
moon check
moon test
moon run cmd/main
```

Example output:

```text
MoonComm deterministic collective communication estimator
ranks=8, bytes=4096, algorithm=balanced-tree
rounds=3, estimated_ns=13788
```

## Project documents

- [Chinese project proposal](docs/PROPOSAL.zh-CN.md)
- Architecture and reproducible demos will be added with their implementations.

## Development principles

1. Correct collective semantics come before performance claims.
2. The same input produces the same schedule and estimate on every target.
3. Algorithm and cost-model assumptions remain explicit and testable.
4. Every milestone includes tests and a runnable example.

## AI assistance

OpenAI Codex is used to assist with API design, implementation, tests, and
documentation. The maintainer reviews the technical choices and owns the final
quality. The project does not include code from earlier proprietary competition
submissions.

## License

Apache-2.0. Related work and algorithm references will be cited as each module
is implemented.
