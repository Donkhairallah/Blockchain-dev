// SPDX-License-Identifier: MIT
pragma solidity =0.8.11;

contract Trust 
{
    // address public kid;
    // uint public maturity;
    struct Kid{
        uint amount;
        uint maturity;
        bool paid;
    }

    mapping(address => Kid) public kids;
    address public admin;

    // mapping(address => uint) public amounts;
    // mapping(address=> uint) public maturities;
    // mapping(address => bool) public paid;


    constructor()
    {
        admin=msg.sender;
    }


    function addKid(address kid,uint timeToMaturiy) external payable
    {
        require(msg.sender==admin,'only admin');
       require(kids[msg.sender].amount==0 , 'kid already exist');
       kids[kid]=Kid(msg.value,block.timestamp+timeToMaturiy,false);

        // amounts[kid]=msg.value;
        // maturities[kid]=block.timestamp+timeToMaturiy;

    }

    function withdraw() external{
       Kid storage kid= kids[msg.sender];
        require(kid.maturity <=block.timestamp, 'too early');
        require(kid.amount>0 , 'only kid can withdraw');
        require(kid.paid==false,'paid already');
        kid.paid=true;

        payable(msg.sender).transfer(kid.amount);

    }

    // constructor(address _kid, uint timeToMaturiy) payable
    // {
    //     maturity=block.timestamp + timeToMaturiy;
    //     kid=_kid;

    // } 

    // function withdraw() external 
    // {
    //     require(block.timestamp >= maturity, 'too early');
    //     require(msg.sender == kid, 'only kid can withdraw');
    //     payable(msg.sender).transfer(address(this).balance);
    //     address, address payable;


    // }
}
