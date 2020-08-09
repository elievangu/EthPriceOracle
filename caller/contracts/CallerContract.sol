pragma solidity 0.5.0;

// Import from the "./EthPriceOracleInterface.sol" file
import "./EthPriceOracleInterface.sol";

// Import the contents of "openzeppelin-solidity/contracts/ownership/Ownable.sol"
import "openzeppelin-solidity/contracts/ownership/Ownable.sol";

contract CallerContract is Ownable {
  
  // Declare `EthPriceOracleInterface`
  EthPriceOracleInterface private oracleInstance;
  address private oracleAddress;

  // Mapping that set every request id status as true or false
  mapping(uint256 => bool) myRequests;

  // Declaration of an event named newOracleAddressEvent
  event newOracleAddressEvent(address oracleAddress);

  // Declaration of an event named ReceivedNewRequestIdEvent
  event ReceivedNewRequestIdEvent(uint256 id);
  
  // Add the `onlyOwner` modifier to the `setOracleInstanceAddress` function definition
  function setOracleInstanceAddress (address _oracleInstanceAddress) public onlyOwner {
    oracleAddress = _oracleInstanceAddress;
    
    // Instantiate `EthPriceOracleInterface`
    oracleInstance = EthPriceOracleInterface(oracleAddress);
    
    // Fire `newOracleAddressEvent`
    emit newOracleAddressEvent(oracleAddress);
  }

  // Define the `updateEthPrice` function
  function updateEthPrice () public {
    
    uint256 id = oracleInstance.getLatestEthPrice();
    myRequests[id] = true;
    emit ReceivedNewRequestIdEvent(id);
  }
}