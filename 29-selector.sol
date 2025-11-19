pragma solidity ^0.8.21;
contract Selector{
    //msg.data是Solidity中的一个全局变量，值为完整的calldata（调用函数时传入的数据）。
    // event 返回msg.data
event Log(bytes data);
function mint(address to) external{
    emit Log(msg.data);
}
//基础类型参数
//固定长度类型参数
//可变长度类型参数
//映射类型参数
}