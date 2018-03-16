pragma solidity ^0.4.2;

contract EntitlementRegistry{function get(string _name)constant returns(address);function getOrThrow(string _name)constant returns(address);}
contract Entitlement{function isEntitled(address _address)constant returns(bool);}

contract MyContract entitledUsersOnly {

  // BlockOne ID bindings

  // The following address works on homestead, ropsten, rinkeby and norsborg
  EntitlementRegistry entitlementRegistry = EntitlementRegistry(0xBbfc11cD1eC8591C96CC0985108ac82a73e7dCf4);

  function getEntitlement() constant returns(address) {
      return entitlementRegistry.getOrThrow("com.tr.test333");
  }

  modifier entitledUsersOnly {
    if (!Entitlement(getEntitlement()).isEntitled(msg.sender)) throw;
    _;
  }

  // Your implementation goes here
    uint public blue = 0;
   uint public red = 0;

   contract Voting {
  /* mapping field below is equivalent to an associative array or hash.
  The key of the mapping is candidate name stored as type bytes32 and value is
  an unsigned integer to store the vote count
  */
  
  mapping (bytes32 => uint8) public votesReceived;
  
  /* Solidity doesn't let you pass in an array of strings in the constructor (yet).
  We will use an array of bytes32 instead to store the list of candidates
  */
  
  bytes32[] public candidateList;

  /* This is the constructor which will be called once when you
  deploy the contract to the blockchain. When we deploy the contract,
  we will pass an array of candidates who will be contesting in the election
  */
  function Voting(bytes32[] candidateNames) public {
    candidateList = candidateNames;
  }

  // This function returns the total votes a candidate has received so far
  function totalVotesFor(bytes32 candidate) view public returns (uint8) {
    require(validCandidate(candidate));
    return votesReceived[candidate];
  }

  // This function increments the vote count for the specified candidate. This
  // is equivalent to casting a vote
  function voteForCandidate(bytes32 candidate) public {
    require(validCandidate(candidate));
    votesReceived[candidate] += 1;
  }

  function validCandidate(bytes32 candidate) view public returns (bool) {
    for(uint i = 0; i < candidateList.length; i++) {
      if (candidateList[i] == candidate) {
        return true;
      }
    }
    return false;
  }
}


}
