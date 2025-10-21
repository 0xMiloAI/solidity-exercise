pragma solidity ^0.8.21;
/*call:call 是address类型的低级成员函数，它用来与其他合约交互。
它的返回值为(bool, bytes memory)，分别对应call是否成功以及目标函数的返回值。
1.call是Solidity官方推荐的通过触发fallback或receive函数发送ETH的方法。
2,不推荐用call来调用另一个合约，因为当你调用不安全合约的函数时，你就把主动权交给了它
3.当我们不知道对方合约的源代码或ABI，就没法生成合约变量；
这时，我们仍可以通过call调用对方合约的函数
规则：目标合约地址.call(字节码);
其中字节码利用结构化编码函数abi.encodeWithSignature获得：abi.encodeWithSignature("函数签名", 逗号分隔的具体参数)
call在调用合约时可以指定交易发送的ETH数额和gas数额：目标合约地址.call{value:发送数额, gas:gas数额}(字节码);*/
//目标合约：
contract OtherContract {
    uint256 private _x = 0; // 状态变量x
    // 收到eth的事件，记录amount和gas
    event Log(uint amount, uint gas);
    
    fallback() external payable{}

    // 返回合约ETH余额
    function getBalance() view public returns(uint) {
        return address(this).balance;
    }

    // 可以调整状态变量_x的函数，并且可以往合约转ETH (payable)
    function setX(uint256 x) external payable{
        _x = x;
        // 如果转入ETH，则释放Log事件
        if(msg.value > 0){
            emit Log(msg.value, gasleft());
        }
    }

    // 读取x
    function getX() external view returns(uint x){
        x = _x;
    }
}
//利用Call调用目标合约：
contract Call{
    //1. Response事件:定义一个Response事件，输出call返回的success和data，方便我们观察返回值。
    // 定义Response事件，输出call返回的结果success和data
    event Response(bool success, bytes data);
    //2.调用setX函数;转入msg.value数额的ETH，并释放Response事件输出success和data：
    function callSetX(address payable _addr, uint256 x) public payable {
    // call setX()，同时可以发送ETH
    (bool success, bytes memory data) = _addr.call{value: msg.value}(
        abi.encodeWithSignature("setX(uint256)", x)
    );

    emit Response(success, data); //释放事件
    }
    //3. 调用getX函数:
    function callGetX(address _addr) external returns(uint256){
    // call getX()
    (bool success, bytes memory data) = _addr.call(
        abi.encodeWithSignature("getX()")
    );

    emit Response(success, data); //释放事件
    return abi.decode(data, (uint256));
    }
    //4. 调用不存在的函数:
    function callNonExist(address _addr) external{
    // call 不存在的函数
    (bool success, bytes memory data) = _addr.call(
        abi.encodeWithSignature("foo(uint256)")
    );

    emit Response(success, data); //释放事件
    }
    //我们call了不存在的foo函数。call仍能执行成功，并返回success，但其实调用的目标合约fallback函数。
}