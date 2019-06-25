pragma solidity ^0.4.24;

import "./open-zeppelin/StandardToken.sol";
import "./open-zeppelin/BurnableToken.sol";
import "./open-zeppelin/Ownable.sol";

contract Cloudbric is StandardToken, BurnableToken, Ownable {
    using SafeMath for uint256;

    string public constant symbol = "CLBK";
    string public constant name = "Cloudbric";
    uint8 public constant decimals = 18;
    uint256 public constant INITIAL_SUPPLY = 1000000000 * (10 ** uint256(decimals));
    uint256 public constant ADMIN_ALLOWANCE = INITIAL_SUPPLY;

    // Address of token administrator
    address public adminAddr;

    // Enable transfer after token sale is completed
    bool public transferEnabled = false;

    // Accounts to be locked for certain period
    mapping(address => uint256) private lockedAccounts;

    /*
     *
     * Permissions when transferEnabled is false :
     *              ContractOwner    Admin    SaleContract    Others
     * transfer            x           v            v           x
     * transferFrom        x           v            v           x
     *
     * Permissions when transferEnabled is true :
     *              ContractOwner    Admin    SaleContract    Others
     * transfer            v           v            v           v
     * transferFrom        v           v            v           v
     *
     */

    /*
     * Check if token transfer is allowed
     * Permission table above is result of this modifier
     */
    modifier onlyWhenTransferAllowed() {
        require(transferEnabled == true
            || msg.sender == adminAddr);
        _;
    }

    /*
     * Check if token transfer destination is valid
     */
    modifier onlyValidDestination(address to) {
        require(to != address(0x0)
            && to != address(this)
            && to != owner
            && to != adminAddr);
        _;
    }

    modifier onlyAllowedAmount(address from, uint256 amount) {
        require(balances[from].sub(amount) >= lockedAccounts[from]);
        _;
    }
    /*
     * The constructor of Cloudbric contract
     *
     * @param _adminAddr: Address of token administrator
     */
    constructor(address _adminAddr) public {
        totalSupply_ = INITIAL_SUPPLY;

        balances[msg.sender] = totalSupply_;
        emit Transfer(address(0x0), msg.sender, totalSupply_);

        adminAddr = _adminAddr;
        approve(adminAddr, ADMIN_ALLOWANCE);
    }

    /*
     * Set transferEnabled variable to true
     */
    function enableTransfer() external onlyOwner {
        transferEnabled = true;
    }

    /*
     * Set transferEnabled variable to false
     */
    function disableTransfer() external onlyOwner {
        transferEnabled = false;
    }

    /*
     * Transfer token from message sender to another
     *
     * @param to: Destination address
     * @param value: Amount of CLB token to transfer
     */
    function transfer(address to, uint256 value)
        public
        onlyWhenTransferAllowed
        onlyValidDestination(to)
        onlyAllowedAmount(msg.sender, value)
        returns (bool)
    {
        return super.transfer(to, value);
    }

    /*
     * Transfer token from 'from' address to 'to' addreess
     *
     * @param from: Origin address
     * @param to: Destination address
     * @param value: Amount of tokens to transfer
     */
    function transferFrom(address from, address to, uint256 value)
        public
        onlyWhenTransferAllowed
        onlyValidDestination(to)
        onlyAllowedAmount(from, value)
        returns (bool)
    {
        return super.transferFrom(from, to, value);
    }

    /*
     * Burn token, only owner is allowed
     *
     * @param value: Amount of tokens to burn
     */
    function burn(uint256 value) public onlyOwner {
        require(transferEnabled);
        super.burn(value);
    }

    /*
     * Disable transfering tokens more than allowed amount from certain account
     *
     * @param addr: Account to set allowed amount
     * @param amount: Amount of tokens to allow
     */
    function lockAccount(address addr, uint256 amount)
        external
        onlyOwner
        onlyValidDestination(addr)
    {
        require(amount > 0);
        lockedAccounts[addr] = amount;
    }

    /*
     * Enable transfering tokens of locked account
     *
     * @param addr: Account to unlock
     */

    function unlockAccount(address addr)
        external
        onlyOwner
        onlyValidDestination(addr)
    {
        lockedAccounts[addr] = 0;
    }
}