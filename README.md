# LOOM
LOOM is a differential testing approach for MLIR, which separates lowering from optimization by first constructing pure lowering compilation paths, and then systematically exploring the MLIR optimization space through incremental extension with transformation passes
## Code Structure
```
LOOM/
├── fuzz_tool/ # Core fuzzing framework
│ ├── conf/ # Configuration files
    ├── paths/ 
    │ ├── pure_lowering_path/ # the pure lowering paths of each program
    │ └── fixed5path.npy # 5 fixed, generic pure lowering paths
    ├── conf.yml # Main configuration file (YAML format)
    └── passes # all used transformation passes
│ ├── log/ # Logs generated during fuzzing
│ └── src/ # Source code of the fuzzing engine
├── Results/ # Stores the detected bugs (crashes and inconsistencies)
├── Seeds/ # Input seed programs
│ ├── seed_raw/ # Raw seed data
│ └── seed_ub_free/ # UB-free seeds after sanitization
└── HandleUB/ # Handle Undefined Behavior
```

## Requirements
- Linux (tested on Ubuntu 22.04)
- Python: 3.11.13
- CMake: 4.0.3
- Ninja
- LLVM + MLIR (specific version required, see below)

## Build LLVM project
LOOM is evaluated using a specific experimental version of LLVM, corresponding to commit:`f3a3270dbca3649b7d56aaa42cb8481fb34e2d67`

Build Instructions
```
cd llvm-project
mkdir build
cd build

cmake -G Ninja ../llvm \
-DLLVM_ENABLE_PROJECTS=mlir \
-DLLVM_BUILD_EXAMPLES=ON \
-DLLVM_TARGETS_TO_BUILD="X86" \
-DCMAKE_BUILD_TYPE=Release \
-DLLVM_ENABLE_ASSERTIONS=ON

ninja
```
Make sure the built MLIR tools (e.g., mlir-opt) are accessible.

## Quick Start
1. Clone LOOM:
```
git clone <repo-url>
cd LOOM
```
2. Configure LLVM paths in:
```
fuzz_tool/conf/conf.yml
```
3. Run LOOM:
```angular2html
python3 ./src/main.py
```
## Configuration
All runtime and fuzzing parameters are defined in [conf.yml](/ty/workdir/LOOM/fuzz_tool/conf/conf.yml).
#### Default setting:
- run_time: 24  # Total testing time (hours)
- MAX_path: 5  # Number of pure lowering path
- MAX_extend: 11 # Maximum number of extension steps
- mode: 'ALL' # Enabled LOOM

_Supported Modes_ (used for ablation studies):
  - OL: Only lowering (disable path extension)
  - SE: Single extension step (MAX_extend=1)
  - RE: Extend paths with random transformations
  - FE: Use five fixed pure lowering paths
  - ALL: Full LOOM workflow (default)  

These modes are mainly intended for ablation studies.
  
## Bug Report
If LOOM detects any bugs during testing (e.g., crashes or inconsistencies), the corresponding test cases and logs will be saved in the Results/ directory.
