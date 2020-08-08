pragma solidity 0.5.0;

//1. Import from the "./EthPriceOracleInterface.sol" file
import "./EthPriceOracleInterface.sol";
contract CallerContract {
  // 2. Declare `EthPriceOracleInterface`
  address private oracleAddress;
  function setOracleInstanceAddress(address _oracleInstanceAddress) public {
    oracleAddress = _oracleInstanceAddress;
    //3. Instantiate `EthPriceOracleInterface`
  }
}