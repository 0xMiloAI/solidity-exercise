pragma solidity ^0.8.21;
//异常，写智能合约时经常会出bug
error TransferNotOwner();//自定义error
error TransferNotOwnerA(address sender);//自定义带参数的error
//执行时，error必须搭配revert使用
contract Error{
     // 定义每个 tokenId 的拥有者
    mapping(uint256 => address) private _owners;

    // 构造函数初始化一些示例数据（可选）
    constructor() {
        _owners[1] = msg.sender; // 假设部署者拥有 tokenId 1
    }
    function transferOwner1(uint256 tokenId,address newOwner)public{
    if(_owners[tokenId]!=msg.sender){
        revert TransferNotOwner();//revert TransferNotOwner(msg.sender);
    }
    _owners[tokenId]=newOwner;
}
/*我们定义了一个transferOwner1()函数，它会检查代币的owner是不是发起人，
如果不是，就会抛出TransferNotOwner异常；如果是的话，就会转账*/
//require:require(检查条件，"异常的描述")，当检查条件不成立的时候，就会抛出异常。
function transferOwner2(uint256 tokenId, address newOwner) public {
    require(_owners[tokenId] == msg.sender, "Transfer Not Owner");
    _owners[tokenId] = newOwner;
}
//assert:assert(检查条件），当检查条件不成立的时候，就会抛出异常。
function transferOwner3(uint256 tokenId, address newOwner) public {
    assert(_owners[tokenId] == msg.sender);
    _owners[tokenId] = newOwner;
}
}
/*error方法gas最少，其次是assert，require方法消耗gas最多！
因此，error既可以告知用户抛出异常的原因，又能省gas，大家要多用！*/