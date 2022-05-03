package Dao;

import entity.Book;
import entity.PageBean;

import java.util.List;

public interface BookDao {
    //增加书籍
    int AddBook(Book book);
    //批量删除书籍
    int Remove_book(String... bkIDs);
    //查询所有书籍
    List<Book> FindAllBook(String bkID);
    //分页的模糊查询
    PageBean<Book> Paged_findbook(PageBean<Book> pageBean);
    //修改书籍
    int  Modify_book(Book book);
}
