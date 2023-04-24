pragma solidity ^0.8.18;

import "forge-std/Test.sol";
import "forge-std/console2.sol";
import "../src/DRAUPCollection00.sol";
import "../src/ExampleRenderer.sol";

contract UpgradeRendererCase is Test {
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
        collection = new DRAUPCollection00(initialSupplies, itemPrices, 'https://example.com/yolo/', testSigner, 3);
        collection.transferOwnership(owner);
        vm.deal(owner, 100 ether);
        vm.deal(minter, 100 ether);
        runStartMint();
        runTestCoatMint();
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

    function testNonOwnerCannotUpgradeRenderer() public {
        IRenderer renderer = new ExampleRenderer();
        vm.expectRevert();
        collection.setRenderer(renderer);
    }

    function testUpgradeRenderer() public {
        assertEq(address(0), address(collection.renderer()));
        IRenderer renderer = new ExampleRenderer();
        vm.prank(owner);
        collection.setRenderer(renderer);
        assertEq(address(renderer), address(collection.renderer()));
        string memory uri1 = collection.tokenURI(0);
        assertEq(uri1, "https://www.example.com/0.json");
    }


}