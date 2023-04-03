import {ERC721} from "openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";


contract DRAUPCollection00 is ERC721 {
    uint256 public immutable MAX_SUPPLY;
    string public baseTokenURI;

    constructor(uint256 maxSupply, string memory baseURI) ERC721("COLLECTION 00", "DRAUP:00") {
        MAX_SUPPLY = maxSupply;
        baseTokenURI = baseURI;
    }

}