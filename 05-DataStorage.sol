//变量数据存储和作用域storage/memory/calldata
pragma solidity ^0.8.21;
contract DataStorage{
    /*引用类型：包括数组（array）和结构体（struct）
    由于变量类型比较复杂，占用空间大，使用时必须声明数据存储位置*/
    /*数据存储位置有三类：
    storage：在链上，类似计算机硬盘；
    memory & calldata：在临时内存里；
    gas消费：sto>mem>cal;
    细分：
    memory：参数和临时变量一般用它，不上链。如果返回类型是变长情况下，必需加memory修饰，string，bytes，array等
    calldata：和memory类似。不同在于calldata变量不能修改*/
    function fCalldata(uint[] calldata _x)public pure returns(uint[] calldata){
        //参数为calldata数组，不能被修改
        //_x[0]=3; //报错，不能修改
        //返回数组需要加memory
        return(_x);
    }
    //数据位置和赋值规则：赋值本质上是创建引用指向本体，因此修改本体或者是引用，变化可以被同步
     //storage <-> storage：创建引用，指向本体，修改引用相当于修改本体
    //memory <-> memory：创建引用，指向本体，修改引用相当于修改本体
    //storage <-> memory：创建独立的副本，修改副本不影响本体
    //memory <-> local memory：创建引用，指向本体，修改引用
    uint[] x = [1,2,3];//状态变量：数组x
    function fStorage() public{
        //声明一个storage的变量xstorage，指向下，修改xStorage也会影响x
        uint[] storage xStorage = x;
        xStorage[0] = 100;
    }
    //变量的作用域：状态变量，局部变量，全局变量
    //状态变量：在合约内，函数外，所有函数都可以访问，gas消耗高，在合约内，函数外声明
    /*contract Variables{
        uint public x=1;
        uint public y;
        string public z;
    }可以在函数里更改状态变量的值*/
    //局部变量：在函数内，临时变量,数据存储在内存里，不上链。gas低
    function bar() external pure returns(uint){
        uint xx=1;
        uint yy=3;
        uint zz=xx+yy;
        return(zz);
    }
    //全局变量：全局变量是全局范围工作的变量和函数，都是solidity预留关键字，可以不声明直接使用
    //全局变量：block，msg，tx，gasleft，abi等
    function global() external view returns(address, uint, bytes memory){
    address sender = msg.sender;
    uint blockNum = block.number;
    bytes memory data = msg.data;
    return(sender, blockNum, data);
}
   /*常用的全局变量:
   blockhash(uint blockNumber): (bytes32) 给定区块的哈希值 – 只适用于最近的256个区块, 不包含当前区块。
   block.coinbase: (address payable) 当前区块矿工的地址
   block.gaslimit: (uint) 当前区块的gaslimit
   block.number: (uint) 当前区块的number
   block.timestamp: (uint) 当前区块的时间戳，为unix纪元以来的秒
   gasleft(): (uint256) 剩余 gas
   msg.data: (bytes calldata) 完整call data
   msg.sender: (address payable) 消息发送者 (当前 caller)
   msg.sig: (bytes4) calldata的前四个字节 (function identifier)
   msg.value: (uint) 当前交易发送的 wei 值
   block.blobbasefee: (uint) 当前区块的blob基础费用。这是Cancun升级新增的全局变量。
   blobhash(uint index): (bytes32) 返回跟当前交易关联的第 index 个blob的版本化哈希（第一个字节为版本号，当前为0x01，后面接KZG承诺的SHA256哈希的最后31个字节）。若当前交易不包含blob，则返回空字节。这是Cancun升级新增的全局变量。*/
   /*以太单位：
   Solidity中不存在小数点，以0代替为小数点，来确保交易的精确度，并且防止精度的损失，
   利用以太单位可以避免误算的问题，方便程序员在合约中处理货币交易
   wei: 1
   gwei: 1e9 = 1000000000
   ether: 1e18 = 1000000000000000000*/
   function weiUnit() external pure returns(uint) {
    assert(1 wei == 1e0);
    assert(1 wei == 1);
    return 1 wei;
    }
    function gweiUnit() external pure returns(uint) {
    assert(1 gwei == 1e9);
    assert(1 gwei == 1000000000);
    return 1 gwei;
    }
    function etherUnit() external pure returns(uint) {
    assert(1 ether == 1e18);
    assert(1 ether == 1000000000000000000);
    return 1 ether;
    }
    /*时间单位：
    可以在合约中规定一个操作必须在一周内完成，
    或者某个事件在一个月后发生。这样就能让合约的执行可以更加精确，
    不会因为技术上的误差而影响合约的结果。因此，时间单位在Solidity中是一个重要的概念，
    有助于提高合约的可读性和可维护性。
    seconds: 1
    minutes: 60 seconds = 60
    hours: 60 minutes = 3600
    days: 24 hours = 86400
    weeks: 7 days = 604800*/
    function secondsUnit() external pure returns(uint) {
    assert(1 seconds == 1);
    return 1 seconds;
    }
    function minutesUnit() external pure returns(uint) {
    assert(1 minutes == 60);
    assert(1 minutes == 60 seconds);
    return 1 minutes;
    }
    function hoursUnit() external pure returns(uint) {
    assert(1 hours == 3600);
    assert(1 hours == 60 minutes);
    }
}