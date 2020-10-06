// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.7.0;

contract Auction {

    address payable public host;
    address public highestBidder;
    uint public HighestBid;
    uint public auctionEndtime; 


    mapping (uint => address) public ownerToBidAmount


    //this function must be public therefore each user should withdraw their bid
    //themselves because iterating over the mapping would drastically increase gas cost
    function withdraw() public returns (bool) {
        //get how much they had bid
        uint bidAmount = ownerToBidAmount[msg.sender];

        //set their bid amount in our mapping to be 0
        ownerToBidAmount[msg.sender] = 0;

        //send the address the amount back
        if (!msg.sender.send(amount)) {
            //if the send failed for some reason return false
            return false;
        }
        else {
            return true;
        }
    }

    //function to end the auction and send the person who started it the highest bid
    function auctionEnded() public {
        require(block.timestamp >= auctionEndTime, "Auction has not ended yet");
        require(!ended, "The auction is still going on");

        //mark the current auction as ended
        ended = true;

        //emit the auction ended event
        emit auctionEnded(highestBidder, HighestBid);

        //transer the highest bid to the host
        host.transer(HighestBid);

    }


}