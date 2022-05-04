package service;

import entity.PageBean;
import entity.Reader;

import java.util.List;

public interface ReaderService {
    //?ж??????????????????
    Reader IsReader(String rdID, String rdpassword);
    int Remove_reader(String... rdIDs);
    //?????
    List<Reader> FindAllReader(String rdID);
    PageBean<Reader> Paged_FindReader(PageBean<Reader> pageBean);
    //??????
    int addReader(Reader reader);
    int Modify_reader(Reader reader);
}
