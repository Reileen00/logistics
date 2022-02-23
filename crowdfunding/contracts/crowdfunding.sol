// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract crowdfunding {
  
    struct Request{
        bool complete;
        string description;
        uint value;
        address recipient;
        

    }


    Request[] public requests;
    address public manager;
    uint public minimumContribution;
    address[] public approvers;

    modifier restricted(){
        require(msg.sender== manager);
        _;
    }

    function Campaigns(uint minimum) public {
        manager=msg.sender;
        minimumContribution=minimum;
    }

    function contribute() public payable{
        require(msg.value > minimumContribution);

        approvers.push(msg.sender);
    }

    function createRequest( string memory description , uint value, address recipient) public restricted{
        Request memory newRequest = Request({
            description: description,
            value:value,
            recipient:recipient,
            complete:false
        });

        requests.push(newRequest);

    }
    function approveRequest(uint index) public{
        Request storage request = requests[index];
        
        require( approvers [msg.sender]);
        require(!requests[index].approvals[msg.sender]);

        requests[index].approvals[msg.sender]=true;
        requests[index].approvalCount++;

    }
}