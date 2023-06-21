// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";

contract MyContract {
    event LeafVerified(bytes32 leaf);

    function verifyMerkleProof(bytes32[] memory proof, bytes32 root, bytes32 leaf) public {
        require(MerkleProof.verify(proof, root, leaf), "Invalid proof");

        emit LeafVerified(leaf);
    }
}
