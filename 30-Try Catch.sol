pragma solidity ^0.8.21;
contract TryCatch{
    //try-catch只能被用于external函数或public函数或创建合约时constructor（被视为external函数）的调用
    
}
contract OnlyEven{
    constructor(uint a){
        require(a != 0, "invalid number");
        assert(a != 1);
    }

    function onlyEven(uint256 b) external pure returns(bool success){
        // 输入奇数时revert
        require(b % 2 == 0, "Ups! Reverting");
        success = true;
    }
}