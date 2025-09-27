pragma solidity ^0.8.21;
contract ArrayAndStruct{
    //数组，用来存储一组数据
    //固定长度数组：
    uint[8] array1;
    bytes1[5] array2;
    address[100] array3;
    //可变长度数组，声明时不指定数组长度
    uint[] array4;
    bytes1[] array5;
    address[] array6;
    bytes array7;//bytes比较特殊，是数组但不用加[]
    //创建数组规则
    //memory修饰的动态数组，可用new，但必须声明长度，且长度不可改变
    //uint[] memory array8=new uint[](5);
    //bytes memory array9=new bytes(9);
    //数组里的每一个元素的type都是以第一个元素为准的，如果没有指定，默认最小单位
    //如果是动态数组，则需要一个个赋值
    function createArray() external pure returns (uint[] memory) {
    uint[] memory x = new uint[](3);
    x[0] = 1;
    x[1] = 2;
    x[2] = 3;
    return x;
    }
    /*数组成员
    length: 数组有一个包含元素数量的length成员，memory数组的长度在创建后是固定的。
    push(): 动态数组拥有push()成员，可以在数组最后添加一个0元素，并返回该元素的引用。
    push(x): 动态数组拥有push(x)成员，可以在数组最后添加一个x元素。
    pop(): 动态数组拥有pop()成员，可以移除数组最后一个元素。*/
    function arrayPush() public returns ( uint[] memory){
        uint[2] memory a=[uint(1),2];
        array4=a;
        array4.push(3);
        return array4;
    }
    //结构体
    struct Student{
        uint256 id;
        uint256 score;
    }
    Student student;//初始一个student的结构体
    //给结构体赋值的方法
    //1.在函数中创建一个storage的struct引用
    function initStudent1() external{
    Student storage _student = student; // assign a copy of student
    _student.id = 11;
    _student.score = 100;
    }
    // 方法2:直接引用状态变量的struct
    function initStudent2() external{
    student.id = 1;
    student.score = 80;
    }
    // 方法3:构造函数式
    function initStudent3() external {
    student = Student(3, 90);
    }
    // 方法4:key value
    function initStudent4() external {
    student = Student({id: 4, score: 60});
    }
}