pragma solidity ^0.8.18;

import "forge-std/Test.sol";
import "forge-std/console2.sol";
import "../src/DRAUPCollection00.sol";

contract InfoMethodsCase is Test {
  DRAUPCollection00 public collection;
    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);
    address private owner = vm.addr(uint256(keccak256(abi.encodePacked("owner"))));
    address private minter = vm.addr(uint256(keccak256(abi.encodePacked("minter"))));
    address private testSigner = 0x7eA005D1982a6cf8356289b94C6f0CbC33bE78C3;
    bytes private minterSignature = hex'77f59a1a67626d1311ae427cbd240d7ef5af7941a71d7df9158795d5655435700a99bf517107d43f81daecba20f8ac6a6b683c4abb5fa1775fed4b2393c6c9131c';
    uint[5] private itemPrices;
    uint[5] private initialSupplies;


    function setUp() public {
        // NB: for quantity, pricing and other announcements, join the DRAUP Discord: https://discord.gg/avumhWTxe9
        initialSupplies[0] = 8;
        initialSupplies[1] = 10;
        initialSupplies[2] = 12;
        initialSupplies[3] = 14;
        initialSupplies[4] = 16;
        itemPrices[1] = 0.1 ether;
        itemPrices[2] = 0.2 ether;
        itemPrices[3] = 0.3 ether;
        itemPrices[4] = 0.4 ether;
        collection = new DRAUPCollection00(initialSupplies, itemPrices, 'https://example.com/yolo/', testSigner);
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
        collection.mintCoats(minter, testSeeds);
    }
    function testGetMaxSupply() public {
        uint256 supply = collection.getMaxSupply();
        assertEq(supply, 60);
    }

    function testGetItemMaxSupply() public {
        (, uint[5] memory itemMaxSupplies,) = collection.itemSupplyInfo();
        assertEq(itemMaxSupplies[COAT_ITEM_TYPE], 8);
        assertEq(itemMaxSupplies[DRESS_ITEM_TYPE], 10);
        assertEq(itemMaxSupplies[PANTS_ITEM_TYPE], 12);
        assertEq(itemMaxSupplies[TOP_ITEM_TYPE], 14);
        assertEq(itemMaxSupplies[HAT_ITEM_TYPE], 16);
    }

    function testGetItemCurrentSupply() public {
        runTestCoatMint();
        runStartMint();
        vm.startPrank(minter);
        collection.mintItem{value:itemPrices[PANTS_ITEM_TYPE]}(PANTS_ITEM_TYPE, minterSignature);
        collection.mintItem{value:itemPrices[HAT_ITEM_TYPE]}(HAT_ITEM_TYPE, minterSignature);
        collection.mintItem{value:itemPrices[PANTS_ITEM_TYPE]}(PANTS_ITEM_TYPE, minterSignature);
        collection.mintItem{value:itemPrices[TOP_ITEM_TYPE]}(TOP_ITEM_TYPE, minterSignature);
        collection.mintItem{value:itemPrices[TOP_ITEM_TYPE]}(TOP_ITEM_TYPE, minterSignature);
        collection.mintItem{value:itemPrices[TOP_ITEM_TYPE]}(TOP_ITEM_TYPE, minterSignature);
        collection.mintItem{value:itemPrices[TOP_ITEM_TYPE]}(TOP_ITEM_TYPE, minterSignature);
        collection.mintItem{value:itemPrices[HAT_ITEM_TYPE]}(HAT_ITEM_TYPE, minterSignature);
        (uint[5] memory itemCurrentSupplies,,) = collection.itemSupplyInfo();
        assertEq(itemCurrentSupplies[COAT_ITEM_TYPE], 5);
        assertEq(itemCurrentSupplies[DRESS_ITEM_TYPE], 0);
        assertEq(itemCurrentSupplies[PANTS_ITEM_TYPE], 2);
        assertEq(itemCurrentSupplies[TOP_ITEM_TYPE], 4);
        assertEq(itemCurrentSupplies[HAT_ITEM_TYPE], 2);
    }

    function testGetItemPrice() public {
        (,, uint[5] memory itemPriceValues) = collection.itemSupplyInfo();
        assertEq(itemPriceValues[COAT_ITEM_TYPE], 0);
        assertEq(itemPriceValues[DRESS_ITEM_TYPE], 0.1 ether);
        assertEq(itemPriceValues[PANTS_ITEM_TYPE], 0.2 ether);
        assertEq(itemPriceValues[TOP_ITEM_TYPE], 0.3 ether);
        assertEq(itemPriceValues[HAT_ITEM_TYPE], 0.4 ether);
    }


}