#!/usr/bin/python3

import pytest
import brownie
from brownie import accounts

@pytest.fixture(scope="module")
def auction(Auction,accounts):
    return Auction.deploy({'from': accounts[0]})

def test_startAuction(accounts, auction):
    auction.startAuction("Test item")
    assert auction.item() == "Test item"
    
def test_endAuction(accounts, auction):
    auction.endAuction()
    
    assert auction.ended() == True
    
def test_host(accounts, auction):
    auction.startAuction("Test item")
    assert auction.host() == accounts[0]
