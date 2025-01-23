// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.7;

import {Test, console} from "forge-std/Test.sol";
import {Encoding} from "../src/Encoding.sol";

contract EncodingTest is Test {
    Encoding public encoding;

    function setUp() public {
        encoding = new Encoding();
    }

    function test_CombineStrings() public view {
        string memory combined = encoding.combineStrings();
        assertEq(combined, "Welcome to My Blockchain");
    }
    
    function test_EncodeNumber() public view {
        bytes memory numberToBytes = encoding.encodeNumber();
        bytes memory expected = hex"0000000000000000000000000000000000000000000000000000000000000001";
        assertEq(numberToBytes, expected);
    }

    function test_EncodeString() public view {
        bytes memory stringToBytes = encoding.encodeSomeString();
        bytes memory expected = hex"0000000000000000000000000000000000000000000000000000000000000020000000000000000000000000000000000000000000000000000000000000000b736f6d6520737472696e67000000000000000000000000000000000000000000";
        assertEq(stringToBytes, expected);
    }

    function test_EncodeStringPacked() public view {
        bytes memory stringToBytes = encoding.encodeSomeStringPacked();
        bytes memory expected = hex"736f6d6520737472696e67";
        assertEq(stringToBytes, expected);
    }

}
