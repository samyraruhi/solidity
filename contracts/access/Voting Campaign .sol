// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Voting {
    struct Contestant {
        uint256 voteCount;
        bool exists;
    }

    struct VotingCampaign {
        string name;
        uint256 startTime;
        uint256 endTime;
        mapping(address => bool) hasVoted;// keep track of whether an address has voted or not
        mapping(string => Contestant) contestants;
    }

    address public owner;
    mapping(uint256 => VotingCampaign) public campaigns;
    uint256 public campaignCount;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can perform this action");
        _;
    }

    constructor() {
        owner = msg.sender;
        campaignCount = 0;
    }

   function createVotingCampaign(string memory name, uint256 durationInSeconds) public onlyOwner {
    require(durationInSeconds > 0, "Duration must be greater than zero");

    uint256 startTime = block.timestamp;////allows for time-based operations
    uint256 endTime = startTime + durationInSeconds;

    VotingCampaign storage newCampaign = campaigns[campaignCount + 1];//array called campaigns
    newCampaign.name = name;
    newCampaign.startTime = startTime;
    newCampaign.endTime = endTime;

    campaignCount++;//indicating that a new campaign has been added to the array.
}


    function vote(uint256 campaignId, string memory contestantName) public {
        require(campaignId > 0 && campaignId <= campaignCount, "Invalid campaign ID");
        require(
            block.timestamp >= campaigns[campaignId].startTime,
            "Voting has not started"
        );
        require(
            block.timestamp <= campaigns[campaignId].endTime,
            "Voting has ended"
        );
        require(
            !campaigns[campaignId].hasVoted[msg.sender],
            "Already voted."
        );

        campaigns[campaignId].hasVoted[msg.sender] = true;
        campaigns[campaignId].contestants[contestantName].voteCount++;
        campaigns[campaignId].contestants[contestantName].exists = true;
    }

    function getResult(uint256 campaignId, string memory contestantName) public view returns (uint256) {
        require(campaignId > 0 && campaignId <= campaignCount, "Invalid campaign ID");
        require(
            block.timestamp > campaigns[campaignId].endTime,
            "Voting is still in progress."
        );
        require(
            campaigns[campaignId].contestants[contestantName].exists,
            "Contestant does not exist."
        );

        return campaigns[campaignId].contestants[contestantName].voteCount;
    }
}
