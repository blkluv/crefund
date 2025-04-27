// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract GapLoan {
    struct Loan {
        uint256 id;
        address borrower;
        uint256 principal;
        uint256 interestBps;
        uint256 maturity;
        uint256 funded;
        bool closed;
    }
    
    uint256 public nextId = 1;
    mapping(uint256 => Loan) public loans;
    mapping(uint256 => mapping(address => uint256)) public contributions;
    address public usdt;
    address public usdc;
    
    constructor(address _usdt, address _usdc) {
        usdt = _usdt;
        usdc = _usdc;
    }
    
    event LoanCreated(uint256 id, address borrower);
    event Funded(uint256 id, address investor, uint256 amount);
    event Repaid(uint256 id);
    event Withdrawn(uint256 id, address investor, uint256 amount);
    
    function createLoan(uint256 principal, uint256 interestBps, uint256 termDays) external {
        loans[nextId] = Loan(nextId, msg.sender, principal, interestBps, block.timestamp + termDays * 1 days, 0, false);
        emit LoanCreated(nextId, msg.sender);
        nextId++;
    }
    
    // fund in native token
    function fund(uint256 id) external payable {
        Loan storage ln = loans[id];
        require(!ln.closed, "closed");
        ln.funded += msg.value;
        contributions[id][msg.sender] += msg.value;
        emit Funded(id, msg.sender, msg.value);
    }
    
    // fund in stablecoin
    function fundToken(uint256 id, uint256 amount, bool useUSDC) external {
        Loan storage ln = loans[id];
        require(!ln.closed, "closed");
        address token = useUSDC ? usdc : usdt;
        IERC20(token).transferFrom(msg.sender, address(this), amount);
        ln.funded += amount;
        contributions[id][msg.sender] += amount;
        emit Funded(id, msg.sender, amount);
    }
    
    function repay(uint256 id) external payable {
        Loan storage ln = loans[id];
        require(msg.sender == ln.borrower, "only borrower");
        uint256 due = ln.principal + (ln.principal * ln.interestBps) / 10000;
        require(msg.value >= due, "not enough");
        ln.closed = true;
        emit Repaid(id);
    }
    
    // withdraw principal + pro-rata interest
    function withdraw(uint256 id, bool receiveUSDC) external {
        Loan storage ln = loans[id];
        require(ln.closed, "not repaid");
        uint256 paid = contributions[id][msg.sender];
        require(paid > 0, "no contribution");
        uint256 totalDue = ln.principal + (ln.principal * ln.interestBps) / 10000;
        uint256 amount = (paid * totalDue) / ln.funded;
        contributions[id][msg.sender] = 0;
        if (receiveUSDC) {
            IERC20(usdc).transfer(msg.sender, amount);
        } else {
            payable(msg.sender).transfer(amount);
        }
        emit Withdrawn(id, msg.sender, amount);
    }
}