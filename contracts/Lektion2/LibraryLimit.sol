// SPDX-License-Identifier: MIT
pragma solidity 0.8.31;

contract LibraryLimit {
    struct Book {
        string Title;
        string Author;
        uint16 year;
    }

    Book[5] public books;
    uint public bookCount = 0;

    function addBook(string memory bookTitle, string memory bookAuthor, uint16 bookYear) public {
        books[bookCount] = Book(bookTitle, bookAuthor, bookYear);
        bookCount++;
    }
}