pragma solidity ^0.8.21;
contract Modifier{
    //构造函数
    address owner;//定义owner变量
    constructor(address initialOwner){
        owner=initialOwner;//部署合约时，将owner设置为传入initialOwner地地址
    }
    /*修饰器（modifier）：是Solidity特有的语法，类似于面向对象编程中的装饰器
    （decorator），声明函数拥有的特性，并减少代码冗余。*/
    //定义modifier
    modifier onlyOwner{
        require(msg.sender == owner);//检查调用者是否为owner地址
        _;//如果是的话，继续运行函数主体，否则报错并revert交易
    }
    function changeOwner(address _newOwner) external onlyOwner{
        owner = _newOwner; // 只有owner地址运行这个函数，并改变owner
        }
}