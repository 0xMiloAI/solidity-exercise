pragma solidity ^0.8.21;
//在合约中创建新合约
/*create的用法很简单，就是new一个合约，并传入新合约构造函数所需的参数：
Contract x = new Contract{value: _value}(params)
其中Contract是要创建的合约名，x是合约对象（地址），如果构造函数是payable，
可以创建时转入_value数量的ETH，params是新合约构造函数的参数。*/
/*极简Uinswap
1.UniswapV2Pair: 币对合约，用于管理币对
2.UniswapV2Factory: 工厂合约，用于创建新的币对，并管理币对地址。*/
//下面进行实践，Pair合约
contract Pair{
    address public factory; // 工厂合约地址
    address public token0; // 代币1
    address public token1; // 代币2

    constructor() payable {
        factory = msg.sender;
    }
    //Pair合约很简单，包含3个状态变量：factory，token0和token1
    // called once by the factory at time of deployment
    function initialize(address _token0, address _token1) external {
        require(msg.sender == factory, 'UniswapV2: FORBIDDEN'); // sufficient check
        token0 = _token0;
        token1 = _token1;
    }
}
//PairFactory
contract PairFactory{
    mapping(address => mapping(address => address)) public getPair; // 通过两个代币地址查Pair地址
    address[] public allPairs; // 保存所有Pair地址

    function createPair(address tokenA, address tokenB) external returns (address pairAddr) {
        // 创建新合约
        Pair pair = new Pair(); 
        // 调用新合约的initialize方法
        pair.initialize(tokenA, tokenB);
        // 更新地址map
        pairAddr = address(pair);
        allPairs.push(pairAddr);
        getPair[tokenA][tokenB] = pairAddr;
        getPair[tokenB][tokenA] = pairAddr;
    }
}
/*工厂合约（PairFactory）有两个状态变量getPair是两个代币地址到币对地址的map，
方便根据代币找到币对地址；allPairs是币对地址的数组，存储了所有币对地址。
PairFactory合约只有一个createPair函数，根据输入的两个代币地址tokenA和tokenB来创建新的Pair合约*/
