pragma solidity ^0.8.18;

import "forge-std/Test.sol";
import "forge-std/console2.sol";
import "../src/DRAUPCollection00.sol";

contract FinanceCaseTest is Test {
    DRAUPCollection00 public collection;
    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);
    address private owner = vm.addr(uint256(keccak256(abi.encodePacked("owner"))));
    address private minter = vm.addr(uint256(keccak256(abi.encodePacked("minter"))));
    address private safe = vm.addr(uint256(keccak256(abi.encodePacked("safe"))));
    address private bobby = vm.addr(uint256(keccak256(abi.encodePacked("bobby"))));
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

    function setupRevenueWallet() public {
        vm.prank(owner);
        collection.setRevenueWallet(safe);
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

    // test sending funds to the contract via EVM call
    function testSendFundsToContract() public {
        address t = address(collection);
        address payable s = payable(t);
        vm.prank(minter);
        s.transfer(0.1 ether);
        uint balance = address(collection).balance;
        assertEq(balance, 0.1 ether);
    }

    function testPreventWithdrawalToEmptyAddress() public {
        assertEq(collection.revenueWallet(), address(0));
        vm.deal(address(collection), 1.2 ether);
        vm.prank(bobby);
        vm.expectRevert();
        collection.processCurrentBalance();
    }

    function testWithdrawsFullBalanceToRevenueWallet() public {
        setupRevenueWallet();
        assertEq(collection.revenueWallet(), safe);
        assertEq(safe.balance, 0);
        vm.deal(address(collection), 1.2 ether);
        vm.prank(bobby);
        collection.processCurrentBalance();
        assertEq(safe.balance, 1.2 ether);
    }

    function testRoyaltyOnLargeAmounts() public {
        (address a1, uint256 amount1) = collection.royaltyInfo(1, 1000);
        assertEq(a1, address(collection));
        assertEq(amount1, 75);
        (address a2, uint256 amount2) = collection.royaltyInfo(1, 1_000_000);
        assertEq(a2, address(collection));
        assertEq(amount2, 75_000);
    }


    function testRoyaltyOnSmallAmounts() public {
        (address a1, uint256 amount1) = collection.royaltyInfo(1, 100);
        assertEq(a1, address(collection));
        assertEq(amount1, 7);
    }

}
