// SPDX-License-Identifier: MIT
pragma solidity 0.8.31;

contract HelloWorld {
    // Ett smart kontrakt består av variabler och funktioner
    // State variabel
    string public message = "Hello World!";

    // Write funktion
    // Vi vill kunna skicka in ett nytt meddelande, för att uppdatera message variabeln
    // newMessage är en lokal variabel
    function setMessage(string memory newMessage) public {
    message = newMessage; 
    }
}