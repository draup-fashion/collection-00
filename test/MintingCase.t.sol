pragma solidity ^0.8.18;

import "forge-std/Test.sol";
import "forge-std/console2.sol";
import "../src/DRAUPCollection00.sol";

contract MintingCaseTest is Test {
    DRAUPCollection00 public collection;
    DRAUPCollection00 public collection2;
    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);
    address private owner = vm.addr(uint256(keccak256(abi.encodePacked("owner"))));
    address private minter = vm.addr(uint256(keccak256(abi.encodePacked("minter"))));
    address private safe = vm.addr(uint256(keccak256(abi.encodePacked("safe"))));
    address private testSigner = 0x7eA005D1982a6cf8356289b94C6f0CbC33bE78C3;
    bytes private minterSignature = hex'77f59a1a67626d1311ae427cbd240d7ef5af7941a71d7df9158795d5655435700a99bf517107d43f81daecba20f8ac6a6b683c4abb5fa1775fed4b2393c6c9131c';
    uint[5] private itemPrices;
    uint[5] private initialSupplies;


    function setUp() public {
        initialSupplies[0] = 8;
        initialSupplies[1] = 10;
        initialSupplies[2] = 12;
        initialSupplies[3] = 14;
        initialSupplies[4] = 16;
        itemPrices[1] = 0.1 ether;
        itemPrices[2] = 0.2 ether;
        itemPrices[3] = 0.3 ether;
        itemPrices[4] = 0.4 ether;
        collection = new DRAUPCollection00(initialSupplies, itemPrices, 'https://example.com/yolo/', testSigner, 3);
        collection.transferOwnership(owner);
        vm.deal(owner, 100 ether);
        vm.deal(minter, 100 ether);
    }

    function runStartMint() public {
        vm.prank(owner);
        collection.startMinting();
    }

    function runTestCoatMint() public {
        bytes32[] memory testSeeds = new bytes32[](5);
        testSeeds[0] = "weofijweodijweodjwedo";
        testSeeds[1] = "weo38dhdbdbdwedo";
        testSeeds[2] = "dkdhhhdt5633gjgjgj";
        testSeeds[3] = "euufjeijdie22gwefwefwefg2s";
        testSeeds[4] = "oedijeodi2u2hsu2hsi2s99j";
        vm.prank(owner);
        collection.mintCoats(safe, testSeeds);
    }

    function testCanMintUpToPerWalletLimit() public {
        runTestCoatMint();
        runStartMint();
        vm.startPrank(minter);
        vm.difficulty(252123);
        assertEq(collection.balanceOf(minter), 0);
        collection.mintItem{value:itemPrices[TOP_ITEM_TYPE]}(TOP_ITEM_TYPE, minterSignature);
        collection.mintItem{value:itemPrices[TOP_ITEM_TYPE]}(TOP_ITEM_TYPE, minterSignature);
        collection.mintItem{value:itemPrices[TOP_ITEM_TYPE]}(TOP_ITEM_TYPE, minterSignature);
        assertEq(collection.balanceOf(minter), 3);
    }

    function testMintingPastLimitReverts() public {
        runTestCoatMint();
        runStartMint();
        vm.startPrank(minter);
        vm.difficulty(252123);
        assertEq(collection.balanceOf(minter), 0);
        collection.mintItem{value:itemPrices[DRESS_ITEM_TYPE]}(DRESS_ITEM_TYPE, minterSignature);
        collection.mintItem{value:itemPrices[TOP_ITEM_TYPE]}(TOP_ITEM_TYPE, minterSignature);
        collection.mintItem{value:itemPrices[TOP_ITEM_TYPE]}(TOP_ITEM_TYPE, minterSignature);
        assertEq(collection.balanceOf(minter), 3);
        vm.expectRevert();
        collection.mintItem{value:itemPrices[TOP_ITEM_TYPE]}(TOP_ITEM_TYPE, minterSignature);
    }

    function setupSecondContract() public {
        collection2 = new DRAUPCollection00(initialSupplies, itemPrices, 'https://example.com/yolo/', testSigner, 5);
        collection2.transferOwnership(owner);
        vm.prank(owner);
        collection2.startMinting();
    }

    function testMintingPastLargerLimitReverts() public {
        setupSecondContract();
        vm.startPrank(minter);
        vm.difficulty(252123);
        assertEq(collection2.balanceOf(minter), 0);
        collection2.mintItem{value:itemPrices[TOP_ITEM_TYPE]}(TOP_ITEM_TYPE, minterSignature);
        collection2.mintItem{value:itemPrices[DRESS_ITEM_TYPE]}(DRESS_ITEM_TYPE, minterSignature);
        collection2.mintItem{value:itemPrices[PANTS_ITEM_TYPE]}(PANTS_ITEM_TYPE, minterSignature);
        collection2.mintItem{value:itemPrices[HAT_ITEM_TYPE]}(HAT_ITEM_TYPE, minterSignature);
        collection2.mintItem{value:itemPrices[TOP_ITEM_TYPE]}(TOP_ITEM_TYPE, minterSignature);
        assertEq(collection2.balanceOf(minter), 5);
        vm.expectRevert();
        collection2.mintItem{value:itemPrices[TOP_ITEM_TYPE]}(TOP_ITEM_TYPE, minterSignature);
    }

}
