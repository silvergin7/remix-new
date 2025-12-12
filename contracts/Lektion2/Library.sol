// SPDX-License-Identifier: MIT
pragma solidity 0.8.31;

contract Library {
    struct Book {
        string title;
        string author;
        uint16 year;
    }

    // Vi skapar en array av book struct
    Book[] public books;

    function addBook(
        string memory bookTitle,
        string memory bookAuthor,
        uint16 bookYear
    ) public {
        books.push(Book(bookTitle, bookAuthor, bookYear));
    }

    // Funktion för att ta reda på hur många böcker vi har i biblioteket
    function bookCount() public view returns (uint) {
        return books.length;
    }

    function removeBook(uint index) public {
        require(index < books.length, "This book does not exist");
        // Delete kommer att nollställa värdena på detta index, men index ligger kvar
        delete books[index];
    }

    function removeBookIndex(uint index) public {
        require(index < books.length, "This book does not exist");
        books[index] = books[books.length - 1];
        books.pop();
    }

    function removeBookKeepOrder(uint index) public {
        require(index < books.length, "This book does not exist");
        for (uint i = index; i < books.length - 1; i++) {
            books[i] = books[i + 1];
        }
        books.pop();
    }
}
