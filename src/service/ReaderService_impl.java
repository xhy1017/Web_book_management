package service;

import Dao.ReaderDao;
import Dao.ReaderDao_impl;
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
    public int addReader(Reader reader) {
        //调用readerdao_impl实现的方法
        return readerDao.addReader(reader);
    }
}
