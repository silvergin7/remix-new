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

    function addBook(string memory bookTitle, string memory bookAuthor, uint16 bookYear) public {
        books.push(Book(bookTitle, bookAuthor, bookYear));
    }
}