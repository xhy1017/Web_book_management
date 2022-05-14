package service;

import Dao.ReaderDao;
import Dao.ReaderDao_impl;
import entity.Borrow;
import entity.PageBean;
import entity.Reader;

import java.util.List;

public class ReaderService_impl implements ReaderService {
    //创建rederdao层的对象去使用它
    //readerdao与service层连接起来了，一层一层调用
    private ReaderDao readerDao = new ReaderDao_impl();

    @Override
    public Reader IsReader(String rdID, String rdpassword) {
        //调用readerdao_impl实现的方法
        return readerDao.IsReader(rdID, rdpassword);
    }

    @Override
    public int Remove_reader(String... rdIDs) {
        return readerDao.Remove_reader(rdIDs);
    }

    @Override
    public List<Reader> FindAllReader(String rdID) {
        //调用readerdao_impl实现的方法
        return readerDao.FindAllReader(rdID);
    }

    @Override
    public PageBean<Reader> Paged_FindReader(PageBean<Reader> pageBean) {
        return readerDao.Paged_FindReader(pageBean);
    }

    @Override
    public int AddReader(Reader reader) {
        //调用readerdao_impl实现的方法
        return readerDao.AddReader(reader);
    }

    @Override
    public int Modify_reader(Reader reader) {
        return readerDao.Modify_reader(reader);
    }

    @Override
    public int Return_book(String rdID, String DateLendAct) {
        return readerDao.Return_book(rdID,DateLendAct);
    }

    @Override
    public int Borrow_book(Borrow borrow) {
        return readerDao.Borrow_book(borrow);
    }
}
