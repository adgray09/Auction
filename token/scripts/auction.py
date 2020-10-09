from brownie import Auction, accounts


def main():
    accounts.load("metamask")
    return Auction.deploy({'from': accounts[0]})