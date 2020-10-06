// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;

contract Auction {
    
    address payable public beneficiary;
    address public highestBidder;
    uint public auctionEndTime;
    uint public highestBid;

    mapping(address => uint) pendingReturns;

    // Boolean that shows auction has ended 
    bool ended;

   // Events handled during auction  
    event HighestBidIncreased(address bidder, uint amount, string message);
    event AuctionEnded(address winner, uint amount);

    constructor(
        uint _biddingTime,
        address payable _beneficiary
    ) {
        beneficiary = _beneficiary;
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

        if (highestBid != 0) {
            pendingReturns[highestBidder] += highestBid;
        }
        // Keeping track of highest bidder
        highestBidder = msg.sender;
        // Value of the highest bid
        highestBid = msg.value;
        // Event for bid increasing with the sender and their value
        emit HighestBidIncreased(msg.sender, msg.value, "New Highest Bidder");
    }
}