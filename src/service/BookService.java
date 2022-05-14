package service;

import entity.Book;
import entity.PageBean;

import java.util.List;

public interface BookService {
    int AddBook(Book book);
    int Remove_book(String... bkIDs);
    List<Book> FindAllBook(String bkID);
    PageBean<Book> Paged_findbook( PageBean<Book> pageBean);
    int  Modify_book(Book book);
    List<Book> Find_lend_books(String rdID);

}
