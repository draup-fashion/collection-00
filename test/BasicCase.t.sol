pragma solidity ^0.8.17;

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
        uint[] memory testSeeds = new uint[](5);
        testSeeds[0] = 23423523523523;
        testSeeds[1] = 38385235235235;
        testSeeds[2] = 383852352352353333;
        testSeeds[3] = 2342342545667777;
        testSeeds[4] = 87766555677778888;
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
        assertEq(collection.getItemMaxSupply(PANTS_ITEM_TYPE), 56);
        assertEq(collection.getItemMaxSupply(TOP_ITEM_TYPE), 88);
        assertEq(collection.getItemMaxSupply(HAT_ITEM_TYPE), 256);
    }

    function testTotalSupply() public {
        assertEq(collection.totalSupply(), 0);
        runTestCoatMint();
        assertEq(collection.totalSupply(), 5);
    }

    function testRegularItemMint() public {
        assertEq(collection.balanceOf(minter), 0);
        vm.prank(minter);
        vm.difficulty(252123);
        collection.mintItems(minter, 3);
        assertEq(collection.balanceOf(minter), 1);
        uint tokenId = collection.totalSupply() - 1;
        (uint256 itemType, uint seed) = collection.tokenInfo(tokenId);
        assertEq(itemType, 3);
        assertEq(seed, 252123);
    }

}
