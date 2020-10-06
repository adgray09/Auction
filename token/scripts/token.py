#!/usr/bin/python3

from brownie import Token, accounts


def main():
    accounts.load("metamask")
    return Token.deploy("Test Token", "TST", 18, 1e21, {'from': accounts[0]})
