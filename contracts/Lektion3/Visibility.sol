// SPDX-License-Identifier: MIT
pragma solidity 0.8.31;

contract Visibility {
    // Publik funktion, kan anropas både inifrån och utifrån kontraktet

    function publicFunction() public pure returns(string memory) {
        return "This is a public function";
    }

    // Intern funktion, kan bara anropas inifrån kontraktet, ärvs ner till barnkontrakt
    function _internalFunction() internal pure returns(string memory) {
        return "This is an internal function";
    }

    // Privat funktion, kan bara anropas innifrån kontraktet, ärvs inte ner till barnkontrakt
    function _privateFunction() private pure returns(string memory) {
        return "This is a private function";
    }

    // Extern funktion, kan bara anropas utifrån kontraktet
    function externalFunction() external pure returns(string memory) {
        return "This is an external function";
    }

    function callInternalFunction() external pure returns(string memory) {
        return _internalFunction();
    }

    function callPrivateFunction() external pure returns(string memory) {
        return _privateFunction();
    }

    function callExternalFunction() public returns(string memory) {
        return this.externalFunction();
    }

    function greeting() public pure virtual returns(string memory) {
        return "Hello from the parent!";
    }
}

contract VisibilityChild is Visibility {
    // Vi provar att göra ett anrop till den interna funktionen
    function callInternalParentFunction() public pure returns(string memory) {
        return _internalFunction();
    }

    /* function callPrivateParentFunction() public pure returns(string memory) {
        return _privateFunction();
    } */

    function greeting() public pure override returns(string memory) {
        return "Hello from the child!";
    }
}