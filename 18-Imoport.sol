pragma solidity ^0.8.21;
//import:帮助我们在一个文件中引用另一个文件的内容，提高代码的可重用性和组织性
/*引用：
1.通过源文件相对位置导入
文件结构
├── Import.sol
└── Yeye.sol

// 通过文件相对位置import
import './Yeye.sol';
2.通过源文件网址导入网上的合约的全局符号
// 通过网址引用
import 'https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Address.sol';
3.通过npm的目录导入；
import '@openzeppelin/contracts/access/Ownable.sol';
4.通过源文件全局名称导入：
import {Yeye} from './Yeye.sol';*/
// 通过文件相对位置import
import './Yeye.sol';
// 通过`全局符号`导入特定的合约
import {Yeye} from './Yeye.sol';
// 通过网址引用
import 'https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Address.sol';
// 引用OpenZeppelin合约
import '@openzeppelin/contracts/access/Ownable.sol';

contract Import {
    // 成功导入Address库
    using Address for address;
    // 声明yeye变量
    Yeye yeye = new Yeye();

    // 测试是否能调用yeye的函数
    function test() external{
        yeye.hip();
    }
}
