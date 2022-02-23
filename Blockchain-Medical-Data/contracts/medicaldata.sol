// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract medicaldata {


    address Owner;

    struct citizen{
        bool isuidgenerated;
        string name;
        uint amountInsured;
   
    }

    mapping (address => citizen) public citizenmapping;
    mapping (address => bool) public doctormapping;

    constructor(){
        Owner=msg.sender;
    }

    modifier onlyOwner(){
        require(Owner==msg.sender);
        _;
    }

    function setDoctor(address _address) public onlyOwner() {
        require(!doctormapping[_address]);
        doctormapping[_address]=true;
    }

    function setCitizenData(string memory _name , uint _amountInsured) public onlyOwner() returns(address){
        address uniqueId=address(sha256(msg.sender));
        require(!citizenmapping[uniqueId].isuidgenerated);
        citizenmapping[uniqueId].isuidgenerated=true;
        citizenmapping[uniqueId].name=_name;
        citizenmapping[uniqueId].amountInsured= _amountInsured;

        return uniqueId;
    }

    function  useInsurance(address _uniqueId, uint _amountUsed) public returns(string){
        require(doctormapping[msg.sender]);
        if (citizenmapping[_uniqueId].amountInsured< _amountUsed){
            assert();
        }
        citizenmapping[_uniqueId].amountInsured -= _amountUsed;
        return "Insurance has been used successfully";
    }
}