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

    // Funktion för att lägga till en bok
    function addBook(string memory bookAuthor, string memory bookTitle, uint16 publicationYear) public {
        require(!authorBooks[bookAuthor][bookTitle].exist, "Book already exists");

        authorBooks[bookAuthor][bookTitle] = Book(bookTitle, publicationYear, true);
        authorBooksTitles[bookAuthor].push(bookTitle);
    }

    // Funktion för att hämta hem antalet böcker av en viss författare
    function getBookCountByAuthor(string memory bookAuthor) public view returns(uint) {
        return authorBooksTitles[bookAuthor].length;
    }

    function updateBook(string memory bookAuthor, string memory oldTitle, string memory newTitle, uint16 publicationYear) public {
        require(authorBooks[bookAuthor][oldTitle].exist, "Book does not exist");
       // require(!authorBooks[bookAuthor][newTitle].exist, "New title already exists");

        if (keccak256(bytes(oldTitle)) != keccak256(bytes(newTitle))) {
            authorBooks[bookAuthor][newTitle] = Book(newTitle, publicationYear, true);
            delete authorBooks[bookAuthor][oldTitle];

            for (uint i = 0; i < authorBooksTitles[bookAuthor].length; i++) {
                if(keccak256(bytes(authorBooksTitles[bookAuthor][i])) == keccak256(bytes(oldTitle))) {
                    authorBooksTitles[bookAuthor][i] = newTitle;

                    break;
                }
            }
        } else {
            authorBooks[bookAuthor][oldTitle].year = publicationYear;
        }
    }

    function deleteBook(string memory bookAuthor, string memory bookTitle) public {
        require(authorBooks[bookAuthor][bookTitle].exist, "Book already exists");

        delete authorBooks[bookAuthor][bookTitle];

         for (uint i = 0; i < authorBooksTitles[bookAuthor].length; i++) {
            if (keccak256(bytes(authorBooksTitles[bookAuthor][i])) == keccak256(bytes(bookTitle))) {
                authorBooksTitles[bookAuthor][i] = authorBooksTitles[bookAuthor][authorBooksTitles[bookAuthor].length - 1];
                authorBooksTitles[bookAuthor].pop();

                break;
            }
         }
    }

    function getTitlesByAuthor(string memory bookAuthor) public view returns(string[] memory) {
        return authorBooksTitles[bookAuthor];
    }

    function getTitlesAndYears(string memory bookAuthor) public view returns(string[] memory bookTitles, uint[] memory publicationYears) {
        // uint bookCount = authorBooksTitles[bookAuthor].length;
        uint bookCount = getBookCountByAuthor(bookAuthor);

        bookTitles = new string[](bookCount);
        publicationYears = new uint[](bookCount);

        for (uint i = 0; i < bookCount; i++) {
            string memory title = authorBooksTitles[bookAuthor][i];
            
            bookTitles[i] = title;
            publicationYears[i] = authorBooks[bookAuthor][title].year;
        }

        return(bookTitles, publicationYears);
    }
}