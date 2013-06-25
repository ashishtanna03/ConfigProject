package com.action;

import com.opensymphony.xwork2.ActionSupport;
import com.service.AuthorService;
import com.service.BookService;

import java.util.ArrayList;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: Ashish
 * Date: 3/24/13
 * Time: 3:22 AM
 * To change this template use File | Settings | File Templates.
 */
public class SuggestionList extends ActionSupport {

    private String searchQuery;

    private BookService bookService;
    private AuthorService authorService;

    private List<String> suggestions;

    public void setSearchQuery(String searchQuery) {
        this.searchQuery = searchQuery;
    }

    public List<String> getSuggestions() {
        return suggestions;
    }

    public String generateList(){
        suggestions = new ArrayList<String>(0);

        for (String bookName : bookService.getSuggestionsByBookName(searchQuery)) {
            suggestions.add(bookName);
        }

        for (String isbnNo : bookService.getSuggestionsByIsbn10(searchQuery)) {
            suggestions.add(isbnNo);
        }

        for (String isbnNo : bookService.getSuggestionsByIsbn13(searchQuery)) {
            suggestions.add(isbnNo);
        }

        for (String authorName : authorService.getSuggestionsByAuthorName(searchQuery)) {
            suggestions.add(authorName);
        }

        for (String publisherName : bookService.getSuggestionsByPublisherName(searchQuery)) {
            suggestions.add(publisherName);
        }

        return SUCCESS;
    }

    public void setBookService(BookService bookService) {
        this.bookService=bookService;
    }

    public void setAuthorService(AuthorService authorService) {
        this.authorService=authorService;
    }
}
