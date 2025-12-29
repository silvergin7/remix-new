// SPDX-License-Identifier: MIT
pragma solidity 0.8.31;

contract Voting {
    enum VotingState { NotStarted, Ongoing, Ended }

    // Vi gör en state variabel som innehåller värdet på vår enum

    VotingState public votingState;

    struct Candidate {
        string name;
        uint voteCount;
    }

    Candidate[] public candidates;

    mapping(address => bool) public hasVoted;
    string public winner;

    constructor(string[] memory votingOptions) {
        for (uint i = 0; i < votingOptions.length; i++) {
            candidates.push(Candidate({
                name: votingOptions[i],
                voteCount: 0
            }));
        }

        votingState = VotingState.NotStarted;
    }

    modifier inState(VotingState state) {
        require(votingState == state, "Invalid state. Action cannot be performed");
        _;
    }

    function startVoting() public inState(VotingState.NotStarted) {
        votingState = VotingState.Ongoing;
    }

    function vote(string memory votingOption) public inState(VotingState.Ongoing) {
        require(!hasVoted[msg.sender], "You have already voted. You can only vote once.");
        bool found = false;

        for (uint i = 0; i < candidates.length; i++) {
            if(keccak256(bytes(candidates[i].name)) == keccak256(bytes(votingOption))) {
                candidates[i].voteCount += 1;
                found = true;

                if(candidates[i].voteCount == 5) {
                    winner = candidates[i].name;
                    votingState = VotingState.Ended;
                }

                break;
            }
        }

        require(found, "Candidate not found. Please try again!");
        
        hasVoted[msg.sender] = true;
    }
}