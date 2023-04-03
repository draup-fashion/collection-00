pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/DRAUPCollection00.sol";

contract BasicCaseTest is Test {
    DRAUPCollection00 public collection;

    function setUp() public {
        collection = new DRAUPCollection00('https://example.com/yolo/');
    }

    function testGetSupply() public {
        uint256 currentSupply = collection.getSupply(CORSET_ITEM_TYPE);
        assertEq(currentSupply, 100);
    }



}
