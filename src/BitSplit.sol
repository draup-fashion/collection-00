// SPDX-License-Identifier: MIT
pragma solidity ~0.8.18;

// This contract is used to split a uint256 into 4 uint256s.
// The first has the first 1/4 of the bits, the second has the second 1/4, etc.
library BitSplit {
    function splitQuarter(uint256 input) public pure returns (uint256[4] memory output) {
        uint256 mask = 0xffffffffffffffffffffffffffffffff;
        uint256 quarter = uint256(1) << 256 / 4;
        output[0] = input & (mask >> 3 * quarter);
        output[1] = (input >> quarter) & (mask >> 2 * quarter);
        output[2] = (input >> 2 * quarter) & (mask >> quarter);
        output[3] = (input >> 3 * quarter) & mask;
    }
}