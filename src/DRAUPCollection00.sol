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
import {ERC721} from "openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";
import {DefaultOperatorFilterer} from "operator-filter-registry/src/DefaultOperatorFilterer.sol";


// define constants for the item types
uint256 constant CORSET_ITEM_TYPE = 0;
uint256 constant JACKET_ITEM_TYPE = 1;


contract DRAUPCollection00 is ERC721, DefaultOperatorFilterer {
    uint256[5] private maxSupplies;
    string public baseTokenURI;

    constructor(uint256[5] memory setSupply, string memory baseURI) ERC721("DRAUP COLLECTION 00", "DRAUP:00") {
        maxSupplies = setSupply;
        baseTokenURI = baseURI;
    }

    function getMaxTotalSupply() public view returns (uint256) {
        return maxSupplies[0] + maxSupplies[1] + maxSupplies[2] + maxSupplies[3] + maxSupplies[4];
    }

    function getMaxSupply(uint256 itemType) public view returns (uint256) {
        return maxSupplies[itemType];
    }

    function getSupply(uint256 itemType) public view returns (uint256) {
        return maxSupplies[itemType];
    }

    // on-chain royalty enforcement integration
    function setApprovalForAll(address operator, bool approved) public override onlyAllowedOperatorApproval(operator) {
        super.setApprovalForAll(operator, approved);
    }

    function approve(address operator, uint256 tokenId) public override onlyAllowedOperatorApproval(operator) {
        super.approve(operator, tokenId);
    }

    function transferFrom(address from, address to, uint256 tokenId) public override onlyAllowedOperator(from) {
        super.transferFrom(from, to, tokenId);
    }

    function safeTransferFrom(address from, address to, uint256 tokenId) public override onlyAllowedOperator(from) {
        super.safeTransferFrom(from, to, tokenId);
    }

    function safeTransferFrom(address from, address to, uint256 tokenId, bytes memory data)
        public
        override
        onlyAllowedOperator(from)
    {
        super.safeTransferFrom(from, to, tokenId, data);
    }

}