pragma solidity ^0.8.21;
//selfdestruct命令可以用来删除智能合约，并将该合约剩余ETH转到指定地址。
//使用：selfdestruct(_addr);
//Demo-转移ETH功能
contract DeleteContract {
    uint public value = 10;
    constructor() payable {}
    receive() external payable {}
    function deleteContract() external {
        // 调用selfdestruct销毁合约，并把剩余的ETH转给msg.sender
        selfdestruct(payable(msg.sender));
    }
    function getBalance() external view returns(uint balance){
        balance = address(this).balance;
    }
}
/*在DeleteContract合约中，我们写了一个public状态变量value，两个函数：
getBalance()用于获取合约ETH余额，deleteContract()用于自毁合约，并把ETH转入给发起人。*/
//Demo-同笔交易内实现合约创建-自毁
contract DeployContract {

    struct DemoResult {
        address addr;
        uint balance;
        uint value;
    }

    constructor() payable {}

    function getBalance() external view returns(uint balance){
        balance = address(this).balance;
    }

    function demo() public payable returns (DemoResult memory){
        DeleteContract del = new DeleteContract{value:msg.value}();
        DemoResult memory res = DemoResult({
            addr: address(del),
            balance: del.getBalance(),
            value: del.value()
        });
        del.deleteContract();
        return res;
    }
}