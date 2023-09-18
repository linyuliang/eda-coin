// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "./BlackList.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Snapshot.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";

/// @custom:security-contact linyuliang.85@gmail.com
contract EdaToken is BlackList, ERC20Burnable, ERC20Snapshot, ERC20Permit {

    constructor(
        address _holder,
        string memory _name,
        string memory _symbol
    ) ERC20(_name, _symbol) ERC20Permit(_name) {
        _mint(_holder, 100_000_000 * 10 ** decimals());
    }

    function snapshot() public onlyOwner {
        _snapshot();
    }

    // The following functions are overrides required by Solidity.
    function _beforeTokenTransfer(address from, address to, uint256 amount)
    internal
    override(ERC20, ERC20Snapshot)
    {
        super._beforeTokenTransfer(from, to, amount);
    }

    function transfer(address to, uint256 amount) public override returns (bool) {
        require(!isBlackListed[msg.sender],string(abi.encodePacked("account ", Strings.toHexString(msg.sender), " blacklisted")));
        return super.transfer(to, amount);
    }

    function transferFrom(address from, address to, uint256 amount) public override returns (bool) {
        require(!isBlackListed[from],string(abi.encodePacked("account ", Strings.toHexString(from), " blacklisted")));
        return super.transferFrom(from, to, amount);
    }
}
