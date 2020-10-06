// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;

contract Auction {

    address payable public host;
    address public highestBidder;
    uint public auctionEndTime;
    uint public highestBid;

    // Boolean that shows auction has ended 
    bool ended;

   // Events handled during auction  
    event HighestBidIncreased(address bidder, uint amount, string message);
    event AuctionEnded(address winner, uint amount);

    constructor(
        uint _biddingTime,
        address payable _host
    ) {
        host = _host;
        auctionEndTime = block.timestamp + _biddingTime;
    }
    
    function bid() public payable {
        require(msg.value > 0, "Value must be higher than 0");
        // Checking if there is still time in auction
        require(block.timestamp <= auctionEndTime,"Auction already ended."
        );
        // Checking if their bid is higher than the highest
        require(msg.value > highestBid, "There already is a higher bid."
        );


    //a mapping of the addresses to how much they bid
    mapping (address => uint) public ownerToBidAmount
    }

    //this function must be public therefore each user should withdraw their bid
    //themselves because iterating over the mapping would drastically increase gas cost
    function withdraw() public returns (bool) {
        //get how much they had bid
        uint bidAmount = ownerToBidAmount[msg.sender];

        //set their bid amount in our mapping to be 0
        ownerToBidAmount[msg.sender] = 0;

        //send the address the amount back
        if (!msg.sender.send(bidAmount)) {
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
        emit AuctionEnded(highestBidder, highestBid);

        //transer the highest bid to the host
        host.transfer(HighestBid);

    }


}