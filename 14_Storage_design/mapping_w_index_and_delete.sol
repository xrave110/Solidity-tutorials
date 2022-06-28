pragma solidity 0.8.0;

contract mappedWithUnorderedIndexAndDelete {

//Advantages
//- simple access to specific address (do not need to loop through the array)
//- we can loop through the array/mapping

//Drwabacks
// - cant get all the data at once
// - there is always data in teh mapping (even if you do not intearct with it) 


// Advantages
// Can get all the data at once

// Drawbacks
//- In order to read the balance of the certain address the whole array must be looped

  struct EntityStruct {
    uint entityData;
    //more data
    uint listPointer; //0   index in the array
  }

  mapping(address => EntityStruct) public entityStructs;
  address[] public entityList;

  function isEntity(address entityAddress) public view returns(bool isIndeed) {
    if(entityList.length == 0) return false;
    return (entityList[entityStructs[entityAddress].listPointer] == entityAddress);
  }

  function getEntityCount() public view returns(uint entityCount) {
    return entityList.length;
  }

  function newEntity(address entityAddress, uint entityData) public returns(bool success) {
    if(isEntity(entityAddress)) revert();
    entityStructs[entityAddress].entityData = entityData;
    entityList.push(entityAddress);
    entityStructs[entityAddress].listPointer = entityList.length - 1;
    return true;
  }

  function updateEntity(address entityAddress, uint entityData) public returns(bool success) {
    if(!isEntity(entityAddress)) revert();
    entityStructs[entityAddress].entityData = entityData;
    return true;
  }
  
  //[ADRESS1, ADDRESS2, ADDRESS3, ADDRESS4] => [ADRESS1, ADDRESS4, ADDRESS3]

  function deleteEntity(address entityAddress) public returns(bool success) {
    if(!isEntity(entityAddress)) revert();
    uint rowToDelete = entityStructs[entityAddress].listPointer; // = 1
    address keyToMove   = entityList[entityList.length-1]; //save address4
    entityList[rowToDelete] = keyToMove;
    entityStructs[keyToMove].listPointer = rowToDelete; //= 2
    entityList.pop();
    delete entityStructs[entityAddress];
    return true;
  }

}