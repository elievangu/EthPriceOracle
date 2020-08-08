pragma solidity 0.5.0;

// Import from the "./EthPriceOracleInterface.sol" file
import "./EthPriceOracleInterface.sol";

// Import the contents of "openzeppelin-solidity/contracts/ownership/Ownable.sol"
import "openzeppelin-solidity/contracts/ownership/Ownable.sol;"
contract CallerContract is Ownable {
  
  // Declare `EthPriceOracleInterface`
  EthPriceOracleInterface private oracleInstance;
  address private oracleAddress;
  // Declaration of an event named newOracleAddressEvent
  event newOracleAddressEvent(address oracleAddress);
  
  // Add the `onlyOwner` modifier to the `setOracleInstanceAddress` function definition
  function setOracleInstanceAddress(address _oracleInstanceAddress) public onlyOwner {
    oracleAddress = _oracleInstanceAddress;
    
    // Instantiate `EthPriceOracleInterface`
    oracleInstance = EthPriceOracleInterface(oracleAddress);
    
    // Fire `newOracleAddressEvent`
    newOracleAddressEvent(oracleAddress);
  }
}