pragma solidity 0.5.0;

// Import from the "./EthPriceOracleInterface.sol" file
import "./EthPriceOracleInterface.sol";

// Import the contents of "openzeppelin-solidity/contracts/ownership/Ownable.sol"
import "openzeppelin-solidity/contracts/ownership/Ownable.sol";

contract CallerContract is Ownable {
  // 1. Declare ethPrice
  uint256 private ethPrice;
  // Declare `EthPriceOracleInterface`
  EthPriceOracleInterface private oracleInstance;
  address private oracleAddress;

  // Mapping that set every request id status as true or false
  mapping(uint256 => bool) myRequests;

  // Declaration of an event named newOracleAddressEvent
  event newOracleAddressEvent(address oracleAddress);

  // Declaration of an event named ReceivedNewRequestIdEvent
  event ReceivedNewRequestIdEvent(uint256 id);

  // 2. Declare PriceUpdatedEvent
  event PriceUpdatedEvent(uint256 ethPrice, uint256 id);
  
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
  //Declaration of the Callack function
  function callBack (uint256 _ethPrice, uint256 _id) public {
    require(myRequests[_id], "This request is not in my pending list");
    ethPrice = _ethPrice;
    delete myRequests[_id];
    emit PriceUpdatedEvent(_ethPrice, _id);
  }
}