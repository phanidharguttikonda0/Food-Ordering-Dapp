// SPDX-License-Identifier: UNLICENCED

pragma solidity ^0.8.17 ;

import './MaintainingDetails.sol' ;

contract MaintainingNFT is Maintaining{

    uint256 private token_id = 1 ;

    struct NFT{ //* Structure of NFT
        uint256 id ; // token id
        uint256 value ; // for each token there will be a value represents how much offer it gives
        uint256 constraint ; // how much amount above u have to buy inorder to applicable
        string data ;// Description about Coopan
        string name ;// name of the coopan
        string image_url ; // the url of the ipfs 
    }

    mapping(uint256 => address) public owner ;
    mapping(uint256 => NFT) public structure ;
    mapping(address => mapping(uint256 => uint256)) public details ; // id => number of copies

    modifier check(address _addr){
        //* check address is the restarunt or Admin
        require(getrestarunt(_addr) || admin == _addr, 'Only Admin or restarunt user can mint NFTs') ;
        _;
    }

    modifier isadmin(address _addr){
        //* checking whether the address is admin or not
        require(admin == _addr, 'Not an Admin') ;
        _;
    }
    modifier isrestarunt(address _addr){
        //* is this address is restarunt or not
        require(getrestarunt(_addr), 'Not an Restarunt user') ;
        _;
    }

    modifier isowner(address _addr, uint256 id){
        //* checking whether the msg.sender is the owner of the NFT 
        require(owner[id] == _addr,'Not an owner of that NFT') ;
        _;
    }

    modifier isuser(address _addr){
        //* checking whether the given address is the user are not
        require(getUser(_addr),'Not an User') ;
        _;
    }

    function mint(uint256 value, uint256 constraint, string memory name, string memory data,
     string memory image_url, uint256 amount)public check(msg.sender){

        structure[token_id] = NFT(token_id,value,constraint,data,name,image_url) ;
        owner[token_id] = msg.sender ;
        details[msg.sender][token_id] = amount ;
    }

    function burn(uint256 id, address from) private {
        
        details[from][id] -= 1 ;
    } 

    function sendToUser(uint256 id, address _to) public check(msg.sender) isowner(msg.sender, id)
    isuser(_to){

        require(details[msg.sender][id] >= 1, 'In-Sufficient NFTs in owners bank') ;
        details[msg.sender][id] -= 1 ;
        details[_to][id] += 1 ;   
    }

    function applyNFT(uint256 id, address _to)public isuser(msg.sender) isrestarunt(_to) 
    isowner(_to, id)
    {
        require(details[msg.sender][id] >= 1, 'In-Sufficient NFTs You had') ;

    }

    function paid(uint256 id, address from) public{
        // we are going to burn that token after payement from that user.. 
        burn(id, from) ;
    }
}