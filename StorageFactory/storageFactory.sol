//SPDX-LICENSE-IDENTIFIER: MIT

pragma solidity 0.8.26;

import {SimpleStorage} from "./simpleStorage.sol";

    

contract StorageFactory{
    SimpleStorage[] public listSimpleStorage;
    function createSimpleStorageContract() public{
        listSimpleStorage.push() =  new SimpleStorage();

    }

    function sfStore(uint256 _simpleStorageIndex, uint256 _newSimpleStorageNumber) public {
         SimpleStorage mySimpleStorage = listSimpleStorage[_simpleStorageIndex];
         mySimpleStorage.store(_newSimpleStorageNumber);
         
         
    }

    
   
    function sfGet(uint256 _simpleStorageIndex) public view returns(uint256){
         
        
        return listSimpleStorage[_simpleStorageIndex].retrieve();
    }
}