pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/DRAUPCollection00.sol";

contract BasicCaseTest is Test {
    DRAUPCollection00 public collection;
    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);
    address private owner = vm.addr(uint256(keccak256(abi.encodePacked("owner"))));
    address private minter = vm.addr(uint256(keccak256(abi.encodePacked("minter"))));

    function setUp() public {
        uint256[5] memory initialSupplies;
        initialSupplies[0] = 8;
        initialSupplies[1] = 24;
        initialSupplies[2] = 56;
        initialSupplies[3] = 88;
        initialSupplies[4] = 256;
        collection = new DRAUPCollection00(initialSupplies, 'https://example.com/yolo/');
        collection.transferOwnership(owner);
        vm.deal(owner, 100 ether);
        vm.deal(minter, 100 ether);
    }

    function runTestCoatMint() public {
        string[] memory testSeeds = new string[](5);
        testSeeds[0] = '274df19879c338d4acd68b3797896c25';
        testSeeds[1] = 'ece92e421cec403258d77d3030763f5e';
        testSeeds[2] = '69660874a37f73ec176a9f372f6a49c0';
        testSeeds[3] = '56a5d2685dcd5481c4b60159186e32c7';
        testSeeds[4] = '36a5d2685ded5481c4b60159186e32c8';
        vm.prank(owner);
        collection.mintCoats(minter, testSeeds);
    }

    function testGetMaxSupply() public {
        uint256 supply = collection.getMaxSupply();
        assertEq(supply, 432);
    }

    function testGetItemMaxSupply() public {
        assertEq(collection.getItemMaxSupply(COAT_ITEM_TYPE), 8);
        assertEq(collection.getItemMaxSupply(DRESS_ITEM_TYPE), 24);
        assertEq(collection.getItemMaxSupply(JEANS_ITEM_TYPE), 56);
        assertEq(collection.getItemMaxSupply(CORSET_ITEM_TYPE), 88);
        assertEq(collection.getItemMaxSupply(HAT_ITEM_TYPE), 256);
    }

    function testTotalSupply() public {
        assertEq(collection.totalSupply(), 0);
        runTestCoatMint();
        assertEq(collection.totalSupply(), 5);
    }

}
