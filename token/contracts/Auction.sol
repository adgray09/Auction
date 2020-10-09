// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;

contract Auction {

    address payable public host;
    address public highestBidder;
    uint public highestBid;
    string public item;

    // Boolean that shows auction has ended
    bool ended;

   // Events handled during auction  
    event HighestBidIncreased(address bidder, uint amount, string message);
    event AuctionEnded(address winner, uint amount, string item);
    event AuctionStarted(address host, string item);

    constructor(
        address payable _host,
        string memory _item
    ) {
        host = _host;
        item = _item;
    }


    function startAuction(string memory _itemToAuction) public {
        host = msg.sender;
        item = _itemToAuction;
        emit AuctionStarted(host, _itemToAuction);
    }

    
    function bid() public payable {
        require(msg.value > 0, "Value must be higher than 0");

        // Checking if there the auction is still going on
        require(!ended);
        // Checking if their bid is higher than the highest
        require(msg.value > highestBid, "There already is a higher bid.");

        highestBid = msg.value;
        highestBidder = msg.sender;
        emit HighestBidIncreased(msg.sender, msg.value, "New Highest Bid");

    }

    //a mapping of the addresses to how much they bid
    mapping (address => uint) public ownerToBidAmount;

    

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
    function endAuction() public {
        require(!ended, "The auction is still going on");

        //the only user that can end the auction is the one that started it.
        require(msg.sender == host);
        //mark the current auction as ended
        ended = true;

        //emit the auction ended event
        emit AuctionEnded(highestBidder, highestBid, item);

        //transer the highest bid to the host
        host.transfer(highestBid);

    }
}
