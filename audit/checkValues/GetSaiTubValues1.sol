pragma solidity ^0.4.24;

contract SaiTub {
    function tag() public view returns (uint wad);
}

contract GetSaiTubValues {
    SaiTub public saiTub = SaiTub(0x448a5065aeBB8E423F0896E6c5D525C040f59af3);

    uint public tag;

    function update() public {
        tag = saiTub.tag();
    }
}