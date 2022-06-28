 
pragma solidity ^0.8.0;

contract Kittycontract {

    string public constant name = "TestKitties";
    string public constant symbol = "TK";
    
    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);

    event Birth(
        address owner, 
        uint256 kittenId, 
        uint256 mumId, 
        uint256 dadId, 
        uint256 genes
    );

    struct Kitty {
        uint256 genes;
        uint64 birthTime;
        uint32 mumId;
        uint32 dadId;
        uint16 generation;
    }

    struct TokenIds {
        uint256[] contractTokenIds;
        mapping(uint256 => uint256) ownersTokenId; //mapping contractTokenId to ownersTokenId
    }

    Kitty[] kitties;

    mapping (uint256 => address) public kittyIndexToOwner;
    mapping (address => TokenIds) ownershipTokenIdxs;


    function balanceOf(address owner) external view returns (uint256 balance){
        return ownershipTokenIdxs[owner].contractTokenIds.length;
    }

    function totalSupply() public view returns (uint) {
        return kitties.length;
    }

    function ownerOf(uint256 _tokenId) external view returns (address)
    {
        return kittyIndexToOwner[_tokenId];
    }

    function transfer(address _to,uint256 _tokenId) external
    {
        require(_to != address(0));
        require(_to != address(this));
        require(_owns(msg.sender, _tokenId));

        _transfer(msg.sender, _to, _tokenId);
    }
    
    function getAllCatsFor(address _owner) external view returns (uint[] memory cats){
        uint[] memory result;
        for (uint i = 0; i < ownershipTokenIdxs[_owner].contractTokenIds.length; i++) {
            result[i] = ownershipTokenIdxs[_owner].contractTokenIds[i];
        }
        return result;
    }
    
    function createKittyGen0(uint256 _genes) public returns (uint256) {
        return _createKitty(0, 0, 0, _genes, msg.sender);
    }

    function _createKitty(
        uint256 _mumId,
        uint256 _dadId,
        uint256 _generation,
        uint256 _genes,
        address _owner
    ) private returns (uint256) {
        Kitty memory _kitty = Kitty({
            genes: _genes,
            birthTime: uint64(block.timestamp),
            mumId: uint32(_mumId),
            dadId: uint32(_dadId),
            generation: uint16(_generation)
        });
        
        kitties.push(_kitty);

        uint256 newKittenId = kitties.length - 1;

        emit Birth(_owner, newKittenId, _mumId, _dadId, _genes);

        _transfer(address(0), _owner, newKittenId);

        return newKittenId;

    }

    function _transfer(address _from, address _to, uint256 _tokenId) internal {
        uint256 tokenToTransfer = ownershipTokenIdxs[_from].ownersTokenId[_tokenId]; // element (ownerId) which should be transeferd
        uint256 lastToken = ownershipTokenIdxs[_from].ownersTokenId[ownershipTokenIdxs[_from].contractTokenIds.length-1]; // last element of ownershipTokenCount[_from]

        ownershipTokenIdxs[_to].contractTokenIds.push(_tokenId);
        ownershipTokenIdxs[_to].ownersTokenId[_tokenId] = ownershipTokenIdxs[_to].contractTokenIds.length-1;

        kittyIndexToOwner[_tokenId] = _to;

        if (_from != address(0)) {
            ownershipTokenIdxs[_from].contractTokenIds[tokenToTransfer] = ownershipTokenIdxs[_from].contractTokenIds[lastToken];
            ownershipTokenIdxs[_from].contractTokenIds.pop();
        }

        // Emit the transfer event.
        emit Transfer(_from, _to, _tokenId);
    }

    function _owns(address _claimant, uint256 _tokenId) internal view returns (bool) {
      return kittyIndexToOwner[_tokenId] == _claimant;
  }
  

}