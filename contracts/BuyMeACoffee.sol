// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

//Deployed to Goerli at this 0x960CfdB5C814d6286791Dc12e3284105f8aa6594

contract BuyMeACoffee {
    //Event to emit when a Memo is created
    event NewMemo(address from, uint256 timestamp, string name, string message);

    //Memo struct.
    struct Memo {
        address from;
        uint256 timestamp;
        string name;
        string message;
    }

    //List of all memos received from friends.
    Memo[] memos;

    //Address of contract deployer.
    address payable owner;

    //Deploy logic
    constructor() {
        owner = payable(msg.sender);
    }

    /**
     * @dev buy a coffee for owner (sends an ETH tip and leaves a memo)
     * @param _name name of the coffee purchaser
     * @param _message a nice message from the purchaser
     */
    function buyCoffee(string memory _name, string memory _message)
        public
        payable
    {
        require(msg.value > 0, "can't buy a coffee with 0 eth");

        // Add the memo to storage!
        memos.push(Memo(msg.sender, block.timestamp, _name, _message));

        // Emit a log event when a new memo is created!
        emit NewMemo(msg.sender, block.timestamp, _name, _message);
    }

    /**
     * @dev send the entire balance stored in this contract to the owner
     */
    function withdrawTips() public {
        address(this).balance;
        require(owner.send(address(this).balance));
    }

    /**
     * @dev fetches all stored memos
     */
    function getMemos() public view returns (Memo[] memory) {
        return memos;
    }
}
