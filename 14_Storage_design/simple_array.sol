pragma solidity 0.8.0;

contract simpleList {

// Advantages
// Can get all the data at once

// Drawbacks
//- In order to read the balance of the certain address the whole array must be looped
//- We do not aware if there are duplicates


  struct EntityStruct {
    address entityAddress;
    uint entityData;
  }

  EntityStruct[] public entityStructs;

  function newEntity(address entityAddress, uint entityData) public returns(EntityStruct memory) {
    EntityStruct memory newEntity;
    newEntity.entityAddress = entityAddress;
    newEntity.entityData    = entityData;
    entityStructs.push(newEntity);
    return entityStructs[entityStructs.length - 1];
  }

  function updateEntity(uint row, uint data) public returns(bool success){ //execution cost update: 7736 gas gas, 
    require(row <= entityStructs.length-1, "There is no entry in this row!");
    entityStructs[row].entityData = data;
    return true;
  }

  function getEntityCount() public view returns(uint entityCount) {
    return entityStructs.length;
  }
}