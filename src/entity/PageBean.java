package entity;

import java.util.List;

public class PageBean<T> {
//  每页记录数
    private int pageSize;
//   总页数
    private int totalPages;
//   总记录数
    private int totalRecord;
//    当前页
    private int currentPage;
//    查询到的读者list集合
    private List<T> list;
    //reader对象
    T Vague_query;
    public T getVague_query() {
        return Vague_query;
    }

    public void setVague_query(T vague_query) {
        Vague_query = vague_query;
    }
    public PageBean() {

    }

    public List<T> getList() {
        return list;
    }
    public PageBean(int pageSize, int totalPages, int totalRecord, int currentPage, List<T> list) {
        this.pageSize = pageSize;
        this.totalPages = totalPages;
        this.totalRecord = totalRecord;
        this.currentPage = currentPage;
        this.list = list;
    }

    public void setList(List<T> list) {
        this.list = list;
    }

    public int getPageSize() {
        return pageSize;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }

    public int getTotalPages() {
        return totalPages;
    }

    public void setTotalPages(int totalPages) {
        this.totalPages = totalPages;
    }

    public int getTotalRecord() {
        return totalRecord;
    }

    public void setTotalRecord(int totalRecord) {
        this.totalRecord = totalRecord;
    }

    public int getCurrentPage() {
        return currentPage;
    }

    public void setCurrentPage(int currentPage) {
        this.currentPage = currentPage;
    }

    @Override
    public String toString() {
        //????д???toString?????????????json??????????
        return '{' +
                "pageSize"+':'+pageSize +
                ", totalPages"+':' + totalPages +
                ", totalRecord"+':' + totalRecord +
                ", currentPage"+':' + currentPage +
                '}';
    }

}
