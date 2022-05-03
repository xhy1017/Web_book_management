package service;

import Dao.BookDao;
import Dao.BookDao_impl;
import entity.Book;
import entity.PageBean;


import java.util.List;

public class BookService_impl implements BookService {
    private BookDao bookDao = new BookDao_impl();

    @Override
    public int AddBook(Book book) {
        return bookDao.AddBook(book);
    }

    @Override
    public int Remove_book(String[] bkIDs) {
        return bookDao.Remove_book(bkIDs);
    }

    @Override
    public List<Book> FindAllBook(String bkID) {
        return bookDao.FindAllBook(bkID);
    }

    @Override
    public PageBean<Book> Paged_findbook( PageBean<Book> pageBean) {
        return bookDao.Paged_findbook(pageBean);
    }

    @Override
    public int Modify_book(Book book) {
        return bookDao.Modify_book(book);
    }
}