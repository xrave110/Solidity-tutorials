pragma solidity 0.8.0;
contract mappingWithStruct {

//Advantages
//- simple access to specific address (do not need to loop through the array)

//Drwabacks
// - cant get all the data at once
// - we dont know how many elements are 
// - there is always data in the mapping (even if you do not intearct with it) 

// Is entity allows to distinguish if we intearcted already with the contract


  struct EntityStruct {
    uint entityData;
    bool isEntity;
  }

  mapping (address => EntityStruct) public entityStructs;

  function newEntity(address entityAddress, uint entityData) public returns(bool success) {
    if(isEntity(entityAddress)) revert(); 
    entityStructs[entityAddress].entityData = entityData;
    entityStructs[entityAddress].isEntity = true;
    return true;
  }
  
  function isEntity(address entityAddress) public view returns(bool isIndeed) {
    return entityStructs[entityAddress].isEntity;
  }

  function deleteEntity(address entityAddress) public returns(bool success) {
    if(!isEntity(entityAddress)) revert();
    entityStructs[entityAddress].isEntity = false;
    return true;
  }

  function updateEntity(address entityAddress, uint entityData) public returns(bool success) {
    if(!isEntity(entityAddress)) revert();
    entityStructs[entityAddress].entityData = entityData;
    return true;
  }
}