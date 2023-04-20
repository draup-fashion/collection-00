pragma solidity ^0.8.18;

import "forge-std/Test.sol";
import "forge-std/console2.sol";
import "../src/DRAUPCollection00.sol";

contract InfoMethodsCase is Test {
  DRAUPCollection00 public collection;
    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);
    address private owner = vm.addr(uint256(keccak256(abi.encodePacked("owner"))));
    address private safe = vm.addr(uint256(keccak256(abi.encodePacked("safe"))));
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
        testSeeds[0] = bytes32(uint256(1));
        testSeeds[1] = bytes32(uint256(2));
        testSeeds[2] = bytes32(uint256(3));
        testSeeds[3] = bytes32(uint256(4));
        testSeeds[4] = bytes32(uint256(5));
        vm.prank(owner);
        collection.mintCoats(safe, testSeeds);
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

    function testTokenInfoForCoats() public {
        runTestCoatMint();
        (uint itemType, bytes32 seed) = collection.tokenInfo(0);
        assertEq(itemType, COAT_ITEM_TYPE);
        assertEq(seed, bytes32(uint256(1)));
    }

    function testTokenInfoForOtherItems() public {
        runTestCoatMint();
        uint nextTokenId = collection.totalSupply();
        runStartMint();
        vm.startPrank(minter);
        vm.difficulty(54252123);
        bytes32 calculatedSeed1 = keccak256(abi.encodePacked(nextTokenId, block.difficulty, blockhash(block.number - 1), minter));
        collection.mintItem{value:itemPrices[PANTS_ITEM_TYPE]}(PANTS_ITEM_TYPE, minterSignature);
        vm.difficulty(25423323);
        bytes32 calculatedSeed2 = keccak256(abi.encodePacked(nextTokenId+1, block.difficulty, blockhash(block.number - 1), minter));
        collection.mintItem{value:itemPrices[HAT_ITEM_TYPE]}(HAT_ITEM_TYPE, minterSignature);
        (uint itemType1, bytes32 seed1) = collection.tokenInfo(nextTokenId);
        assertEq(itemType1, PANTS_ITEM_TYPE);
        assertEq(seed1, calculatedSeed1);
        (uint itemType2, bytes32 seed2) = collection.tokenInfo(nextTokenId+1);
        assertEq(itemType2, HAT_ITEM_TYPE);
        assertEq(seed2, calculatedSeed2);
    }

    function testTokensOfOwner() public {
        runTestCoatMint();
        uint nextTokenId = collection.totalSupply();
        runStartMint();
        vm.startPrank(minter);
        vm.difficulty(4783123);
        collection.mintItem{value:itemPrices[TOP_ITEM_TYPE]}(TOP_ITEM_TYPE, minterSignature);
        collection.mintItem{value:itemPrices[DRESS_ITEM_TYPE]}(DRESS_ITEM_TYPE, minterSignature);
        (uint[] memory minterTokenIds, uint[] memory minterTokenItemTypes, string [] memory minterTokenUris ) = collection.tokensOfOwner(minter);
        assertEq(minterTokenIds.length, 2);
        assertEq(minterTokenIds[0], nextTokenId);
        assertEq(minterTokenIds[1], nextTokenId+1);
        assertEq(minterTokenItemTypes.length, 2);
        assertEq(minterTokenItemTypes[0], TOP_ITEM_TYPE);
        assertEq(minterTokenItemTypes[1], DRESS_ITEM_TYPE);
        assertEq(minterTokenUris.length, 2);
        assertEq(minterTokenUris[0], collection.tokenURI(nextTokenId));
        assertEq(minterTokenUris[1], collection.tokenURI(nextTokenId+1));
    }

    function testTokenURIDefault() public {
        runTestCoatMint();
        uint nextTokenId = collection.totalSupply();
        runStartMint();
        vm.startPrank(minter);
        vm.difficulty(4783123);
        collection.mintItem{value:itemPrices[TOP_ITEM_TYPE]}(TOP_ITEM_TYPE, minterSignature);
        collection.mintItem{value:itemPrices[DRESS_ITEM_TYPE]}(DRESS_ITEM_TYPE, minterSignature);
        string memory tokenURI1 = collection.tokenURI(0);
        string memory tokenURI1Expected = string(
                abi.encodePacked(
                    'https://example.com/yolo/',
                    PaddedString.digitsToString(0, 3),
                    "/item_",
                    PaddedString.digitsToString(0, 3),
                    "_metadata_",
                    PaddedString.digitsToString(0, 1),
                    ".json"
                )
        );
        assertEq(keccak256(abi.encodePacked(tokenURI1)), keccak256(abi.encodePacked(tokenURI1Expected)));

        string memory tokenURI2 = collection.tokenURI(nextTokenId);
        string memory tokenURI2Expected = string(
                abi.encodePacked(
                    'https://example.com/yolo/',
                    PaddedString.digitsToString(nextTokenId, 3),
                    "/item_",
                    PaddedString.digitsToString(nextTokenId, 3),
                    "_metadata_",
                    PaddedString.digitsToString(3, 1),
                    ".json"
                )
        );
        assertEq(keccak256(abi.encodePacked(tokenURI2)), keccak256(abi.encodePacked(tokenURI2Expected)));

        uint tokenId3 = nextTokenId+1;
        string memory tokenURI3 = collection.tokenURI(tokenId3);
        string memory tokenURI3Expected = string(
                abi.encodePacked(
                    'https://example.com/yolo/',
                    PaddedString.digitsToString(tokenId3, 3),
                    "/item_",
                    PaddedString.digitsToString(tokenId3, 3),
                    "_metadata_",
                    PaddedString.digitsToString(1, 1),
                    ".json"
                )
        );
        assertEq(keccak256(abi.encodePacked(tokenURI3)), keccak256(abi.encodePacked(tokenURI3Expected)));

    }

}