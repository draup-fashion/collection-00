pragma solidity ^0.8.18;

import "forge-std/Test.sol";
import "forge-std/console2.sol";
import "../src/StaticSiteRenderer.sol";

contract StaticSiteCase is Test {
  StaticSiteRenderer public infoContract;
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
        infoContract = new StaticSiteRenderer();
        vm.deal(owner, 100 ether);
        vm.deal(minter, 100 ether);
    }
    // token uri checks
    function testTokenUri0O() public {
        string memory tokenUri = infoContract.tokenURI(0);
        assertEq(tokenUri, 'https://www.draup.xyz/api/collection_00/0');
    }
    function testTokenUri1O() public {
        string memory tokenUri = infoContract.tokenURI(1);
        assertEq(tokenUri, 'https://www.draup.xyz/api/collection_00/1');
    }
    function testTokenUri67O() public {
        string memory tokenUri = infoContract.tokenURI(67);
        assertEq(tokenUri, 'https://www.draup.xyz/api/collection_00/67');
    }
    function testTokenUri1230O() public {
        string memory tokenUri = infoContract.tokenURI(1230);
        assertEq(tokenUri, 'https://www.draup.xyz/api/collection_00/1230');
    }
    function testTokenUri109() public {
        string memory tokenUri = infoContract.tokenURI(109);
        assertEq(tokenUri, 'https://www.draup.xyz/api/collection_00/109');
    }
}
