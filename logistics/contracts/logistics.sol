// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract logistics {

    //////////////////////DECLARATION/////////////////

    struct package{
        bool isuidgenerated;
        uint itemid;
        string itemname;
        string transitstatus;
        uint orderstatus; //1=orderd; 2=in-transit; 3=delivered; 4=cancelled

        address customer;
        uint ordertime;


    }

    mapping (address => package) public packagemapping;

    //////////////////////DECLARATION END/////////////


    ////////////////////ORDERITEM FUNCTION/////////////////
    function OrderItem(uint _itemid, string _itemname) public returns (address){
        address uniqueId = address(sha256(msg.sender,now));

        packagemapping[uniqueId].isuidgenerated=true;
        packagemapping[uniqueId].itemid=_itemid;
        packagemapping[uniqueId].itemname=_itemname;
        packagemapping[uniqueId].transitstatus="Your package is ordered and is under process..."
        packagemapping[uniqueId].orderstatus=1;

        packagemapping[uniqueId].customer=msg.sender;
        packagemapping[uniqueId].ordertime=now;

        return uniqueId;

    }

    ////////////////////ORDERITEM FUNCTION END/////////////////


}