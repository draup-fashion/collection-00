pragma solidity ^0.8.18;

import "forge-std/Test.sol";
import "forge-std/console2.sol";
import "../src/DRAUPCollection00.sol";

contract VerificationCheckCase is Test {
    DRAUPCollection00 public collection;
    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);
    address private owner = vm.addr(uint256(keccak256(abi.encodePacked("owner"))));
    address private minter = vm.addr(uint256(keccak256(abi.encodePacked("minter"))));
    address private testSigner = 0x7eA005D1982a6cf8356289b94C6f0CbC33bE78C3;
    bytes private minterSignature = hex'77f59a1a67626d1311ae427cbd240d7ef5af7941a71d7df9158795d5655435700a99bf517107d43f81daecba20f8ac6a6b683c4abb5fa1775fed4b2393c6c9131c';
    bytes private anotherSignature = hex'7a639932365c67f33f80530baf06612020aef553aca08b8b1c79b2f5b4ea27a346237686c0352c9b0a693a10d0ad9a639c760f1299570bff73e94c11f5a1f2bb1c';

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
        collection = new DRAUPCollection00(initialSupplies, itemPrices, 'https://example.com/yolo/', testSigner);
        collection.transferOwnership(owner);
        vm.deal(owner, 100 ether);
        vm.deal(minter, 100 ether);
    }

    function testCheckValidVerification() public {
        vm.prank(owner);
        bool isValid = collection.isValidSignature(minter, minterSignature);
        assertEq(isValid, true);
    }

    function testCheckBogusVerification() public {
        vm.prank(owner);
        bool isValid = collection.isValidSignature(minter, anotherSignature);
        assertEq(isValid, false);
    }

}