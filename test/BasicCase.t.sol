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
        uint[5] memory itemPrices;
        itemPrices[1] = 0.6 ether;
        itemPrices[2] = 0.35 ether;
        itemPrices[3] = 0.2 ether;
        itemPrices[4] = 0.08 ether;
        collection = new DRAUPCollection00(initialSupplies, itemPrices, 'https://example.com/yolo/');
        collection.transferOwnership(owner);
        vm.deal(owner, 100 ether);
        vm.deal(minter, 100 ether);
    }

    function runTestCoatMint() public {
        bytes32[] memory testSeeds = new bytes32[](5);
        testSeeds[0] = "weofijweodijweodjwedo";
        testSeeds[1] = "weo38dhdbdbdwedo";
        testSeeds[2] = "dkdhhhdt5633gjgjgj";
        testSeeds[3] = "euufjeijdie22gwefwefwefg2s";
        testSeeds[4] = "oedijeodi2u2hsu2hsi2s99j";
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
        uint mintPrice = collection.mintCostForItems(TOP_ITEM_TYPE, 1);
        collection.mintItems{value:mintPrice}(minter, TOP_ITEM_TYPE, 1);
        assertEq(collection.balanceOf(minter), 1);
        uint tokenId = collection.totalSupply() - 1;
        (uint256 itemType, bytes32 seed) = collection.tokenInfo(tokenId);
        assertEq(itemType, 3);
        assertGt(uint(seed), 1_000_000);
    }

    function testTokenInfos() public {
        vm.startPrank(minter);
        vm.difficulty(252123);


        uint mintPrice = collection.mintCostForItems(PANTS_ITEM_TYPE,1);
        uint secondMintPrice = collection.mintCostForItems(HAT_ITEM_TYPE,1);
        collection.mintItems{value:mintPrice}(minter, PANTS_ITEM_TYPE,1);
        collection.mintItems{value:secondMintPrice}(minter, HAT_ITEM_TYPE,1);
        (uint256[] memory itemTypes, bytes32[] memory seeds) = collection.tokenInfos(0,0);
        assertEq(itemTypes.length, 2);
        assertEq(seeds.length, 2);
        assertEq(itemTypes[0], 2);
        assertEq(itemTypes[1], 4);
        assertGt(uint(seeds[0]), 1_000_000);
        assertGt(uint(seeds[1]), 1_000_000);
    }

}
