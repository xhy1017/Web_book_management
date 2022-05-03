package Dao;

import entity.PageBean;
import entity.Reader;

import java.util.List;

public interface ReaderDao {

    Reader IsReader(String rdID,String rdpassword);
    int Remove_reader(String... rdIDs);
    List<Reader> FindAllReader(String rdID);
    PageBean<Reader>  Paged_FindReader(PageBean<Reader> pageBean);

    int addReader(Reader reader);



}
