pragma solidity ^0.8.21;
/*有两个public变量：num和sender，分别是uint256和address类型；
有一个函数，可以将num设定为传入的_num，并且将sender设为msg.sender。*/
// 被调用的合约C
contract C {
    uint public num;
    address public sender;

    function setVars(uint _num) public payable {
        num = _num;
        sender = msg.sender;
    }
}
//发起调用的合约B
/*约B必须和目标合约C的变量存储布局必须相同 
—— 即存在两个 public 变量且变量类型顺序为 uint256 和 address*/
contract B {
    uint public num;
    address public sender;
}
contract Delegatecall{
    //delegatecall语法和call类似:delegatecall语法和call类似
    /*应用：
    1：代理合约（Proxy Contract）：将智能合约的存储合约和逻辑合约分开：
    代理合约（Proxy Contract）存储所有相关的变量，并且保存逻辑合约的地址；
    所有函数存在逻辑合约（Logic Contract）里，通过delegatecall执行。
    当升级时，只需要将代理合约指向新的逻辑合约即可。
    2.EIP-2535 Diamonds（钻石）：钻石是一个支持构建可在生产中扩展的模块化智能合约系统的标准。
    钻石是具有多个实施合约的代理合约。 更多信息请查看：钻石标准简介。*/
    // 通过call来调用C的setVars()函数，将改变合约C里的状态变量
    function callSetVars(address _addr, uint _num) external payable{
        // call setVars()
        (bool success, bytes memory data) = _addr.call(
            abi.encodeWithSignature("setVars(uint256)", _num)
            );
        }
         // 通过delegatecall来调用C的setVars()函数，将改变本合约里的状态变量
        function delegatecallSetVars(address _addr, uint _num) external payable{
            // delegatecall setVars()
            (bool success, bytes memory data) = _addr.delegatecall(
                abi.encodeWithSignature("setVars(uint256)", _num)
            );
        }
}