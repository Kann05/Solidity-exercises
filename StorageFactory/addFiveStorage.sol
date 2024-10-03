//SPDX-LICENSE-IDENTIFIER: MIT

pragma solidity 0.8.26;

import {SimpleStorage} from "./simpleStorage.sol";

contract addFiveStorage is SimpleStorage{
    function store(uint256 getNumber) public override {
        myFavoriteNumber = getNumber + 5;
    }
}