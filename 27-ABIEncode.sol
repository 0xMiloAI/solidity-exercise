pragma solidity ^0.8.21;
//ABI编码
contract ABIEncode{
    uint x = 10;
    address addr = 0x7A58c0Be72BE218B41C608b7Fe7C5bB630736C71;
    string name = "0xAA";
    uint[2] array = [5, 6]; 
    //abi.encode
    //ABI被设计出来跟智能合约交互，他将每个参数填充为32字节的数据，并拼接在一起
    //如果你要和合约交互，你要用的就是abi.encode。
    function encode() public view returns(bytes memory result) {
        result = abi.encode(x, addr, name, array);
    }
    //abi.encodePacked:将给定参数根据其所需最低空间编码
    //当你想省空间，并且不与合约交互的时候，可以使用abi.encodePacked
    //abi.encodePacked因为不会做填充，所以不同的输入在拼接后可能会产生相同的编码结果，导致冲突
    function encodePacked() public view returns(bytes memory result) {
        result = abi.encodePacked(x, addr, name, array);
    }
    //abi.encodeWithSignature:第一个参数为函数签名,当调用其他合约的时候可以使用。
    function encodeWithSignature() public view returns(bytes memory result) {
        result = abi.encodeWithSignature("foo(uint256,address,string,uint256[2])", x, addr, name, array);
    }
    //abi.encodeWithSelector:第一个参数为函数选择器，为函数签名Keccak哈希的前4个字节。
    function encodeWithSelector() public view returns(bytes memory result) {
        result = abi.encodeWithSelector(bytes4(keccak256("foo(uint256,address,string,uint256[2])")), x, addr, name, array);
    }
    //ABI解码：abi.decode用于解码abi.encode生成的二进制编码，将它还原成原本的参数。
    function decode(bytes memory data) public pure returns(uint dx, address daddr, string memory dname, uint[2] memory darray) {
        (dx, daddr, dname, darray) = abi.decode(data, (uint, address, string, uint[2]));
    }
}