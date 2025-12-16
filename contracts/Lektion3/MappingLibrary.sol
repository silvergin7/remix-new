// SPDX-License-Identifier: MIT
pragma solidity 0.8.31;

contract MappingLibrary {
    struct Book {
        string title;
        uint16 year;
        bool exist;
    }

    // Vi skapar en mapping med författarens namn som nyckel
    // Vi skapar en ny mapping som värde, där key är bokens titel
    mapping(string => mapping(string => Book)) public authorBooks;

    // Vi skapar en andra mapping, med författarens som key och en array av titlar som värde
    mapping(string => string[]) public authorBooksTitles;

    function addBook(string memory bookAuthor, string memory bookTitle, uint16 publicationYear) public {
        require(!authorBooks[bookAuthor][bookTitle].exist, "Book already exists");

        authorBooks[bookAuthor][bookTitle] = Book(bookTitle, publicationYear, true);
        authorBooksTitles[bookAuthor].push(bookTitle);
    }
}