//这次学习值的类型
pragma solidity ^0.8.21;
contract ValueTypes{
//1.布尔型：
bool public _bool=true;
bool public _bool1=! _bool;
bool public _bool3=_bool && _bool1;
bool public _bool4=_bool || _bool1;
//2.整型：
int public _int=-1;   //整数，包括负数
uint public _uint=1;//无符号整数
uint256 public _number=22903990;//256位无符号整数
uint256 public _number1=_number+1;
uint256 public _number2=2**2;//指数
uint256 public _number3=7%2;//取余数
bool public _numberbool=_number2>_number3;//比较运算符
/*3.地址类型，分两类；
1.普通地址：存20字节，即以太坊地址大小
2.payable address:多了transfer和send两个方法，
可以接收转账*/
address public _address=0x7A58c0Be72BE218B41C608b7Fe7C5bB630736C71;
//普通地址的呈现
address payable public _address1=payable(_address);
//可以转账，查余额
uint256 public balance=_address1.balance;
/*.balance 是 Solidity 内置的成员，用来获取该地址当前持有的 ETH 余额（单位是 wei）。
所以这行代码就是把 _address1 地址上的余额读取出来，并存到一个状态变量 balance 里。
4.定节字长数组：
定长；属于值类型。数组长度在声明后不可改变有bytes1，8，32
不定长：属于引用类型在声明后可以改变，包括bytes*/
bytes32 public _byte32="MiniSolidity";
bytes1 public _byte=_byte32[0];
//字符串“minisolidity”以字节的方式储进变量_byte32，值为byte32的第一个字节
//5.枚举enum，冷门。。。
// 用enum将uint 0， 1， 2表示为Buy, Hold, Sell
enum ActionSet { Buy, Hold, Sell }
// 创建enum变量 action
ActionSet action = ActionSet.Buy;
}

