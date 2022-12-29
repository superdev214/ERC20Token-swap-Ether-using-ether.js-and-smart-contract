pragma solidity ^0.8.9;

 import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

// interface IERC20 {

//     function totalSupply() external view returns (uint256);
//     function balanceOf(address account) external view returns (uint256);
//     function allowance(address owner, address spender) external view returns (uint256);

//     function transfer(address recipient, uint256 amount) external returns (bool);
//     function approve(address spender, uint256 amount) external returns (bool);
//     function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);


//     event Transfer(address indexed from, address indexed to, uint256 value);
//     event Approval(address indexed owner, address indexed spender, uint256 value);
// }


// contract ERC20Basic is IERC20 {

//     string public constant name = "ERC20Basic";
//     string public constant symbol = "ERC";
//     uint8 public constant decimals = 18;


//     mapping(address => uint256) balances;

//     mapping(address => mapping (address => uint256)) allowed;

//     uint256 totalSupply_ = 10 ether;


//    constructor() {
//     balances[msg.sender] = totalSupply_;
//     }

//     function totalSupply() public override view returns (uint256) {
//     return totalSupply_;
//     }

//     function balanceOf(address tokenOwner) public override view returns (uint256) {
//         return balances[tokenOwner];
//     }

//     function transfer(address receiver, uint256 numTokens) public override returns (bool) {
//         require(numTokens <= balances[msg.sender]);
//         balances[msg.sender] = balances[msg.sender]-numTokens;
//         balances[receiver] = balances[receiver]+numTokens;
//         emit Transfer(msg.sender, receiver, numTokens);
//         return true;
//     }

//     function approve(address delegate, uint256 numTokens) public override returns (bool) {
//         allowed[msg.sender][delegate] = numTokens;
//         emit Approval(msg.sender, delegate, numTokens);
//         return true;
//     }

//     function allowance(address owner, address delegate) public override view returns (uint) {
//         return allowed[owner][delegate];
//     }

//     function transferFrom(address owner, address buyer, uint256 numTokens) public override returns (bool) {
//         require(numTokens <= balances[owner]);
//         require(numTokens <= allowed[owner][msg.sender]);

//         balances[owner] = balances[owner]-numTokens;
//         allowed[owner][msg.sender] = allowed[owner][msg.sender]-numTokens;
//         balances[buyer] = balances[buyer]+numTokens;
//         emit Transfer(owner, buyer, numTokens);
//         return true;
//     }
// }


contract DEXToken is ERC20{
    event Bought(uint256 amount);
    event Sold(uint256 amount);
    uint256 ratio = 10000;
   constructor(uint256 totalSupply) ERC20("SwapToken Protocol", "SWT"){
     _mint(address(this), totalSupply * 10 ** decimals());
    }
    function setRatio(uint256 _ratio)  external{
        ratio = _ratio;
    }
    function getRatio() public view returns(uint256){
        return ratio;
    }
    function deposit() payable public {
        uint256 amountTobuy = msg.value;
        uint256 dexBalance = balanceOf(address(this));
        require(amountTobuy > 0, "You need to send some ether");
        // require(amountTobuy <= dexBalance / getRatio(), "Not enough tokens in the reserve");
        // token.transfer(msg.sender, amountTobuy * getRatio());
        require(amountTobuy <= dexBalance, "Not enough tokens in the reserve");
         this.transfer(msg.sender, amountTobuy);
       // payable(msg.sender).transfer(amountTobuy);
        emit Bought(amountTobuy);
    }

    function withdraw(uint256 amount) public {
        require(amount > 0, "You need to sell at least some tokens");
        uint256 allowance = this.allowance(msg.sender, address(this));
        require(allowance >= amount, "Check the token allowance");
        this.transferFrom(msg.sender, address(this), amount);
        // payable(msg.sender).transfer(amount * getRatio());
         payable(msg.sender).transfer(amount);
        emit Sold(amount);
    }

}