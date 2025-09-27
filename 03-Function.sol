//本次为函数
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;
contract Function{
    /*整个框架：
    function <function name>([parameter types[, ...]]) 
    {internal|external|public|private} 
    [pure|view|payable] [virtual|override] 
    [<modifiers>]
    [returns (<return types>)]
    { <function body> }
    方括号里的是可写可不写的关键字；
    1.function:声明函数的固定方法。
    2.<function name>:函数名.
    3.([parameter types[, ...]]):参数，输入到函数的变量类型和名称。
    4.public：内外均可见；
     internal：仅在当前合约和派生合约中可见；
     private：仅在当前合约中可见；
     external：仅在当前合约和派生合约中可见。合约外部访问。
     注意：合约中定义的函数需要明确指定可见性，它们没有默认值。
    5.pure：纯函数，不允许修改或访问状态。
     view：视图函数，只允许访问状态但不允许修改。
     payable：可支付
     6.[virtual|override]：方法是否可以被重写，或者是否是重写方法
     virtual用在父合约上，标识的方法可以被子合约重写。
     override用在子合约上，表名方法重写了父合约的方法。
     7.[<modifiers>]：修饰符，用于在函数执行前或后添加额外的检查或操作。
    8.[returns (<return types>)]：返回值，函数执行后返回的变量类型和名称。
    9.<function body>:函数体。
*/
uint256 public number = 5;
function add() external {
    number = number + 1;
}
/*如果 add() 函数被标记为 pure，比如 function add() external pure，就会报错。
因为 pure 是不配读取合约里的状态变量的，更不配改写*/
function addPure(uint256 _number)external pure returns(uint256 new_number){
new_number=_number+1;
//这个可以，这个操作不会读取或写入状态变量。pure纯牛马
}
//view看客
function addView() external view returns(uint256 new_number) {
    new_number = number + 1;
}
//internal内部函数
function minus() internal {
    number = number - 1;
}
// 合约内的函数可以调用内部函数
function minusCall() external {
    minus();
}
/*因为内部函数无法直接调用，
必须再定义一个 external 的 minusCall() 函数，
通过它间接调用内部的 minus() 函数。*/
// payable: 递钱，能给合约支付eth的函数
function minusPayable() external payable returns(uint256 balance) {
    minus();    
    balance = address(this).balance;
}
/*我们定义一个 external payable 的 minusPayable() 函数，
间接地调用 minus()，并且返回合约里的 ETH 余额；
（this 关键字可以让我们引用合约地址）。
我们可以在调用 minusPayable() 时往合约里转入1个 ETH。*/
}