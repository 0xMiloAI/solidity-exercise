//返回值
pragma solidity ^0.8.21;
contract Return{
    /*有两个关键字
    return：在函数体里，返回指定变量；
    returns：在函数名后面，声明返回变量类型及变量名*/
    function returnMultiple() public pure returns(uint256,bool,uint256[3] memory){
        return(1,true,[uint256(1),2,5]);
    }
    /*用returns声明了有多个返回值的函数，
    这里memory是uint256[3]的指定位置，因为对于复杂类型
    ，solidity要求在返回类型明确指定位置，对外部可见通常用memory*/
    //命名式返回,也支持return
    function returnNamed() public pure returns(uint256 _number,bool _bool,uint256[3] memory _array){
        _number=2;
        _bool=false;
        _array=[uint256(3),2,1];
    }
    // 命名式返回，依然支持return
    function returnNamed2() public pure returns(uint256 _number, bool _bool, uint256[3] memory _array){
        return(1, true, [uint256(1),2,5]);
    }
    //解构式赋值
   function readReturn() public pure{
     uint256 _number;
     bool _bool;
     bool _bool2;
     uint256[3] memory _array;
     (_number, _bool, _array) = returnNamed();
     //读取所有返回值：声明变量，然后将要赋值的变量用,隔开，按顺序排列
     (, _bool2, ) = returnNamed();
     //读取部分返回值：声明要读取的返回值对应的变量，不读取的留空。在下面的代码中，我们只读取_bool，而不读取返回的_number和_array
   }
}