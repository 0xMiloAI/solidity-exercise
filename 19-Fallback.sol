pragma solidity ^0.8.21;
contract Fallbacck{
    /*Solidity支持两种特殊的回调函数，receive()和fallback()，他们主要在两种情况下被使用：
    接收ETH
    处理合约中不存在的函数调用（代理合约proxy contract）*/
    /*receive:
    receive()函数是在合约收到ETH转账时被调用的函数。一个合约最多有一个receive()函数，
    声明方式与一般函数不一样，不需要function关键字：receive() external payable { ... }。
    receive()函数不能有任何的参数，不能返回任何值，必须包含external和payable。*/
    // 定义事件 
    event Received(address Sender, uint Value);
    // 接收ETH时释放Received事件
    receive() external payable {
        emit Received(msg.sender, msg.value);
    }
    /*有些恶意合约，会在receive() 函数（老版本的话，
    就是 fallback() 函数）嵌入恶意消耗gas的内容或者使得执行故意失败的代码，
    导致一些包含退款和转账逻辑的合约不能正常工作，
    因此写包含退款等逻辑的合约时候，一定要注意这种情况。*/
    /*fallback:fallback()函数会在调用合约不存在的函数时被触发
    。可用于接收ETH，也可以用于代理合约proxy contract。
    fallback()声明时不需要function关键字，必须由external修饰，
    一般也会用payable修饰，用于接收ETH:fallback() external payable { ... }。*/
    event fallbackCalled(address Sender, uint Value, bytes Data);
    // fallback
    fallback() external payable{
        emit fallbackCalled(msg.sender, msg.value, msg.data);
    }
}