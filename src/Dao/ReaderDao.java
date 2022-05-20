package Dao;

import entity.Borrow;
import entity.PageBean;
import entity.Reader;

import java.util.List;

public interface ReaderDao {

    Reader IsReader(String rdID,String rdpassword);
    int Remove_reader(String... rdIDs);
    List<Reader> FindAllReader(String rdID);
    PageBean<Reader>  Paged_FindReader(PageBean<Reader> pageBean);
       int Return_book(String rdID,String bkID,String DateLendAct);
       int Borrow_book(Borrow borrow);
    int AddReader(Reader reader);
    int Modify_reader(Reader reader);


}
