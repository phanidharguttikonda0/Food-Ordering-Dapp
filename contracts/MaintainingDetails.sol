// SPDX-License-Identifier: UNLICENCED

pragma solidity ^0.8.17 ;


//* over in this contract we are maintaning admin and restarunt addresss and also user address
contract Maintaining{

    mapping(address => bool) public restarunt ;
    mapping(address => bool) public user ;
    address public admin ;
    constructor(){
        admin = msg.sender ;
    }

    function setrestarunt() public{
        restarunt[msg.sender] = true ;
    }

    function setUser() public{
        user[msg.sender] = true ;
    }

    function getrestarunt(address _addr) public view returns(bool){
        return restarunt[_addr] ;
    }

    function getUser(address _addr) public view returns(bool){
        return user[_addr] ;
    }
}