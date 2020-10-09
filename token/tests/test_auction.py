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
    
