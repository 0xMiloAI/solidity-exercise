pragma solidity ^0.8.21;
contract Mapping{
    //映射；通过键(key)来查询对应的值
    //声明映射的格式为mapping(_KeyType => _ValueType)，
    //其中_KeyType和_ValueType分别是Key和Value的变量类型。
    mapping(uint => address) public idToAddress; // id映射到地址
    mapping(address => address) public swapPair; // 币对的映射，地址到地址
    //映射规则：
    /*1.映射的_KeyType只能选择Solidity内置的值类型，比如uint，address等，不能用自定义的结构体。
    而_ValueType可以使用自定义的类型。
    struct Student{
    uint256 id;
    uint256 score; 
    }
    mapping(Student => uint) public testVar;
    会报错，因为_KeyType使用了我们自定义的结构体。
    2.映射的存储位置必须是storage，因此可以用于合约的状态变量，
    函数中的storage变量和library函数的参数。
    不能用于public函数的参数或返回结果中，因为mapping记录的是一种关系 (key - value pair)。
    3.如果映射声明为public，那么Solidity会自动给你创建一个getter函数，
    可以通过Key来查询对应的Value
    4.给映射新增的键值对的语法为_Var[_Key] = _Value，
    其中_Var是映射变量名，_Key和_Value对应新增的键值对。
    */
    function writeMap (uint _Key, address _Value) public{
    idToAddress[_Key] = _Value;
    }
    //映射原理
     /*1.映射不储存任何键（Key）的资料，也没有length的资料。
     因为映射的存储和底层原理与哈希表相似，
     一个哈希映射的键（Key）并不储存，它的值（Value）也并非直接储存。
     2.映射使用keccak256(h(key) . slot)计算存取value的位置。
     3.: 因为Ethereum会定义所有未使用的空间为0，所以未赋值（Value）的键（Key）
     初始值都是各个type的默认值，如uint的默认值是0。*/
}