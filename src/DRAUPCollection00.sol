// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

//
// This software is developed by DRAUP, Inc. "DRAUP" is a trademark of DRAUP, Inc.
// in the United States and other countries. Nothing herein grants you any rights in
// or to DRAUP, Inc.'s trade names or trademarks, all of which are expressly
// reserved to DRAUP, Inc.
//
//
//
//                            DRAUP COLLECTION 00
//
//                          DRAUP X NICOLAS SASSOON
//
//                              SEEN ON SCREEN
//
//
//                                                           .,,
//                                                           ;░░▒▒
//                                                           ;░φφ░╚╠
//                                                       .░φ░░░░Γ╙╙
//                                                       '░░░░
//                                                           ░░░░
//                                                           ¡░░░░
//                                                           ¡░░░░
//                                                           ¡░░░¡░
//                                                           :░░▒░!-
//                                                           ¡░¡░▒░│-
//                                                       .│''░▒░┐'░
//                                                       ;''¡░╠▒░.'░
//                                                   .,,;'''¡░╠╠░░. ┌
//                                               .░░░░░░┐..¡¡░╠╠▒░┐ '.
//                                               .░│¡░░░░░░░¡░░░▒╠▒░░. '~
//                                               ;│.¡░░░░░░░░░░░░▒╠╠░░' .
//                                           ;░┌¡░░░░░░░░░░░░▒╠╠╠░░'.░⌐
//                                             ;░.¡░░φ▒▒▒▒▒░░░░▒▒╠╬▒░░\░░
//                                           ;░┐¡░φ╠╠╬╬╠╠▒▒▒▒▒╠╠╬╠▒░░░░
//                                       .░░.░φ▒╠╬╬╬╣╣╣╬╬╠╠╠╠╬╬▒░░░░
//                                       .░░│░░▒╠╠╠╠╬╬╬▓██▓▓╬╬╬╬▒░░░░
//                                       ░░░░φ▒╩╚╩╚╚Γ└''└│╙╙╚╩╩╩╚╙Γ"
//                                   .\¡░φ▒░░░░░░░       ''''''
//                                   ¡¡░▒░░░│││¡└
//                                   .¡░░░░░│'''¡'
//                               .░░░░░░░░┐''│¡~
//                       .,░φ░░░░░░░░░░░░░│..'!░
//                   .░░░░░░░░░░░░░░░░░░░░░░┐. !-
//                   ;░░φ▒▒▒▒░░░░░░░░░░░░░░░░░░░┐.'-
//               .░░φ▒▒▒▒░░░░░░▒▒▒▒╠╠╠▒▒▒▒▒▒▒φ░░░¡░.
//               .░░▒╠╠▒░░░░░░░░▒╠╠╩╩╩╩╩╩╬╬╣╣╣▓╣╬▒▒φ░░;
//               .¡░▒╠╠▒░░░░░░░░░░Γ░└'''''''""╙╙╩╬╬╬╬╣╣╬▒φ░»,
//               :░φ╠╬▒▒░░░░░░░░░░             '''!╙╚╩╠╠╠╠╠╠╠▒φφφ░,
//               :░▒╬╬▒▒░░░░░░░░'                   '!░░░╠╠╠╠╠╠╠▒▒▒░░░.
//               :░╠╬╬▒▒░░░░░░░'                     .░░░▒▒╠╠╠╠▒▒▒▒▒▒░░░.
//               '░╚╬╬▒▒░░░░░░                     .≥░░░▒▒▒▒▒▒▒▒▒▒▒▒▒░░░┐-
//               !░╠╬▒▒░░░░░                  ,;φ░░░░▒▒▒▒▒▒▒▒▒▒▒╠╠▒▒▒░░░┌.
//               ^░╠╬╠▒▒░░░               ,φ░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒╠╠╠▒▒▒░░░│¡
//               !╚╬╬▒▒░▒░            »░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒╠╠╠╠╠▒▒▒░░░░░
//               '░╠╬▒▒▒▒░         ,φ░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒╠╠╠╠╠╠╠╠╠▒▒░░░░░
//                   '╚╠▒▒▒▒░       ;░░░▒▒▒╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠▒▒░░░░░
//                   ░╠▒▒▒▒▒░  .,φφ▒▒▒╠╠╠╬╬╬╬╬╬╬╬╬╬╬╬╠╠╠╬╬╬╬╬╬╬╬╬╬╠╠▒▒░░░░
//                   ]╠▒▒▒▒▒▒▒╠╠╠╠╠╠╠╬╬╬╬╬╬╬╬╬╬╬╬╬╬╬╬╬╬╬╬╬╬╬╬╬╬╬╬╬╬╠▒▒░░░'
//                   ]╠▒▒▒▒▒▒▒╠╠╠╬╬╬╬╬╬╬╬╬╬╬╬╬╬╬╬╬╬╬╬╬╬╬╬╬╬╬╬╬╬╬╬╬╬╠▒▒▒░'
//                   !╠╠▒▒▒▒▒▒╠╠╠╠╬╬╬╬╬╬╬╬╬╬╬╬╬╬╣▓▓▓▓▓▓▓▓▓▓▓▓╬╬╬╬╬╬╠╠╩░'
//                   '╙╬╬▒▒▒▒▒╠╠╠╠╠╠╬╬╬╬╬╬╬╬╬╬╬╬╣▓▓▓▓▓▓▓▓▓▓▓▓▓▓╬╬╬╬╩Γ"
//                   '!╚╣╬╬╠╠╠╠╠╠╠╬╬╬╬╬╬╬╬╬╬╬╬╬╬╣▓▓▓▓▓▓▓▓▓▓▓▓╬╬╩╙░'
//                       '░╚╣▓▓╬╬╬╬╬╬╬╬╬╬╬╬╬╬╬╬╬╬╬╬╬╣▓▓▓▓▀╩╩╙╙░└''
//                       '!╙╩╣▓▓╣╬╬╬╬╬╬╬╬╬╬╬╬╬╬╬╬╬╬╬╩╙░"''
//                           '!╙╚╬▓▓▓▓▓╬╬╬╬╬╬╬╬╬╬╩╙Γ"'
//
//
//
import {Ownable} from "openzeppelin-contracts/contracts/access/Ownable.sol";
import {ERC721A} from "erc721a/contracts/ERC721A.sol";
import {DefaultOperatorFilterer} from "operator-filter-registry/src/DefaultOperatorFilterer.sol";

// define constants for the item types
uint256 constant COAT_ITEM_TYPE = 0;
uint256 constant DRESS_ITEM_TYPE = 1;
uint256 constant JEANS_ITEM_TYPE = 2;
uint256 constant CORSET_ITEM_TYPE = 3;
uint256 constant HAT_ITEM_TYPE = 4;

contract DRAUPCollection00 is ERC721A, Ownable, DefaultOperatorFilterer {
    uint256[5] private maxSupplies;
    string public baseTokenURI;

    constructor(uint256[5] memory setSupply, string memory baseURI) ERC721A("DRAUP COLLECTION 00", "DRAUP:00") {
        maxSupplies = setSupply;
        baseTokenURI = baseURI;
    }

    function getMaxSupply() public view returns (uint256) {
        return maxSupplies[0] + maxSupplies[1] + maxSupplies[2] + maxSupplies[3] + maxSupplies[4];
    }

    function getItemMaxSupply(uint256 itemType) public view returns (uint256) {
        return maxSupplies[itemType];
    }

    function getItemSupply(uint256 itemType) public view returns (uint256) {
        return maxSupplies[itemType];
    }

    // hero pieces minted by DRAUP using short form generative techniques
    function mintCoats(address to, string[] calldata seeds) public onlyOwner {
        uint256 itemType = COAT_ITEM_TYPE;
        require(maxSupplies[itemType] >= seeds.length, "Not enough supply for minting");
        maxSupplies[itemType] -= seeds.length;
        for (uint i=0; i<seeds.length; i++) {
            _mint(to, 1);
        }
    }

    // main collection pieces minted by public using long form generative techniques
    // for our random seed strategy see: TK
    function mintItems(address to, uint256 itemType) public onlyOwner {
        require(maxSupplies[itemType] > 0, "Not enough supply for minting");
        maxSupplies[itemType] -= 1;
        _mint(to, 1);
    }

    // on-chain royalty enforcement integration
    function setApprovalForAll(address operator, bool approved) public override onlyAllowedOperatorApproval(operator) {
        super.setApprovalForAll(operator, approved);
    }

    function approve(address operator, uint256 tokenId) public override payable onlyAllowedOperatorApproval(operator) {
        super.approve(operator, tokenId);
    }

    function transferFrom(address from, address to, uint256 tokenId) public override payable onlyAllowedOperator(from) {
        super.transferFrom(from, to, tokenId);
    }

    function safeTransferFrom(address from, address to, uint256 tokenId) public override payable onlyAllowedOperator(from) {
        super.safeTransferFrom(from, to, tokenId);
    }

    function safeTransferFrom(address from, address to, uint256 tokenId, bytes memory data)
        public
        override
        payable
        onlyAllowedOperator(from)
    {
        super.safeTransferFrom(from, to, tokenId, data);
    }

}