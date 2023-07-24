// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import {IRenderer} from "./IRenderer.sol";
import {Strings} from "openzeppelin-contracts/contracts/utils/Strings.sol";


contract DRAUPStagingApiRenderer is IRenderer {
    function tokenURI(uint256 tokenId) external pure override returns (string memory) {
        return string.concat("https://draup-staging-api.vercel.app/api/v1/collections/collection-00/", Strings.toString(tokenId));
    }
}
