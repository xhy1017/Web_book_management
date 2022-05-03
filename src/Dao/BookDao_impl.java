package Dao;

import Utils.JDBCUtils;
import entity.Book;
import entity.PageBean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
/* 查书、添加书、修改书*/
public class BookDao_impl implements BookDao {
    //    全局变量
    private Connection conn = null;
    //预编译对象，防止sql注入
    private PreparedStatement pst = null;
    //结果集对全局变量
    private ResultSet rs = null;

    @Override
    public int AddBook(Book book) {
        try {
            conn = JDBCUtils.getConnection();
            String sql = "INSERT INTO book values(?,?,?,?,?,?,?,?)";
            //预编译sql语句
            pst = conn.prepareStatement(sql);
            pst.setString(1, book.getBkID());
            pst.setString(2, book.getBkName());
            pst.setString(3, book.getBkAuthor());
            pst.setString(4, book.getBkPress());
            pst.setString(5, book.getBkPrice());
            pst.setString(6, book.getBkStatus());
            pst.setString(7, book.getBkURL());
            pst.setString(8, book.getBkResume());
            return pst.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                JDBCUtils.close(pst, conn);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return 0;
    }
    @Override
    public int Remove_book(String... bkIDs) {
        int i=0;
        for (String bkID : bkIDs) {
            i = Remove_book(bkID);
        }
      return i;
    }
    public int Remove_book(String ID) {
        try {
            conn=JDBCUtils.getConnection();
            String sql="delete from book where bkID=?";
            pst=conn.prepareStatement(sql);
            pst.setString(1,ID);
            return pst.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        finally {
            try {
                JDBCUtils.close(pst, conn);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return 0;
    }

    @Override
    public List<Book> FindAllBook(String bkID) {
        if (bkID != "") {
            try { //开始连接
                conn = JDBCUtils.getConnection();
                //定义需要的sql语句
                String sql = "select *from book where bkID=?";
                //预编译
                pst = conn.prepareStatement(sql);
                //给？赋值
                pst.setString(1, bkID);
                //执行sql语句
                ResultSet rs = pst.executeQuery();

                //新建一个list集合
                List<Book> list = new ArrayList<>();
                while (rs.next())
                {
                    //新建一个读者对象
                    Book book = new Book();
                    //与数据库字段名一致
                    book.setBkID(rs.getString("bkID"));
                    book.setBkName(rs.getString("bkName"));
                    book.setBkAuthor(rs.getString("bkAuthor"));
                    book.setBkPrice(rs.getString("bkPrice"));
                    book.setBkPress(rs.getString("bkPress"));
                    book.setBkStatus(rs.getString("bkStatus"));
                    //赋值给用户对象
                    list.add(book);
                }
                //返回获取的list集合
                return list;
            } catch (SQLException e) {
                e.printStackTrace();
            }
            //关闭连接
            finally {
                try {
                    //关闭连接
                    JDBCUtils.close(rs, pst, conn);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            return null;
        }

        //输入的读者ID为空值，查询全部读者
        else {
            try {
                conn = JDBCUtils.getConnection();
                //定义需要的sql语句
                String sql = "select *from book";
                pst = conn.prepareStatement(sql);
                //执行sql语句
                ResultSet rs = pst.executeQuery();
                //新建一个读者对象

                //新建一个list集合
                List<Book> list = new ArrayList<>();
                while (rs.next()) {
                    Book book = new Book();
                    //与数据库字段名一致
                    book.setBkID(rs.getString("bkID"));
                    book.setBkName(rs.getString("bkName"));
                    book.setBkAuthor(rs.getString("bkAuthor"));
                    book.setBkPrice(rs.getString("bkPress"));
                    book.setBkPrice(rs.getString("bkPrice"));
                    book.setBkStatus(rs.getString("bkStatus"));
                    //赋值给用户对象
                    list.add(book);
                }
                //返回获取的list集合
                return list;
            } catch (SQLException e) {
                e.printStackTrace();
            }
            //关闭连接
            finally {
                try {
                    //关闭连接
                    JDBCUtils.close(rs, pst, conn);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            return null;
        }
    }

    @Override
    //带分页功能的查询
    public PageBean<Book> Paged_findbook(PageBean<Book> pageBean) {
        //放在外面执行有看符合条件的多少条记录
        //总记录数
        int totalCount=CountTotalRecord(pageBean);
        //余数>0页数加1.为0刚好一页
        int totalPages=(totalCount%pageBean.getPageSize()==0)? totalCount/pageBean.getPageSize() :(totalCount/pageBean.getPageSize()+1);
        int index =( pageBean.getCurrentPage()-1) * pageBean.getPageSize();
        //若未找到结果，当前页设置为0
        if (totalPages==0){
            pageBean.setCurrentPage(0);
             index=0;
        }
        // //起始索引=（当前页-1）*每页条数

            try {
                conn = JDBCUtils.getConnection();
                String vague_sql="select * from book where 1=1";
                StringBuffer stringBuffer=new StringBuffer(vague_sql);
                if(pageBean.getVague_query().getBkID()!=null&& !"".equals(pageBean.getVague_query().getBkID())){
                    stringBuffer.append(" and bkID like '%").append(pageBean.getVague_query().getBkID()).append("%'");
                }
                if(pageBean.getVague_query().getBkName()!=null&& !"".equals(pageBean.getVague_query().getBkName())){
                    stringBuffer.append(" and bkName like '%").append(pageBean.getVague_query().getBkName()).append("%'");
                }
                if(pageBean.getVague_query().getBkAuthor()!=null&& !"".equals(pageBean.getVague_query().getBkAuthor())){
                    stringBuffer.append(" and bkAuthor like '%").append(pageBean.getVague_query().getBkAuthor()).append("%'");
                }
                if(pageBean.getVague_query().getBkStatus()!=null){
                    stringBuffer.append(" and bkStatus like '%").append(pageBean.getVague_query().getBkStatus()).append("%'");
                }
                stringBuffer.append(" limit ?,?");
                System.out.println(stringBuffer);

                //toString 或者valueOf
                pst = conn.prepareStatement(stringBuffer.toString());
                pst.setInt(1, index);
                pst.setInt(2, pageBean.getPageSize());
                System.out.println(pst.toString());
                rs = pst.executeQuery();
                List<Book> bookList=new ArrayList<>();
                while (rs.next())
                {
                    Book book=new Book();
                    book.setBkID(rs.getString("bkID"));
                    book.setBkName(rs.getString("bkName"));
                    book.setBkAuthor(rs.getString("bkAuthor"));
                    book.setBkPrice(rs.getString("bkPrice"));
                    book.setBkPress(rs.getString("bkPress"));
                    book.setBkStatus(rs.getString("bkStatus"));
                    book.setBkURL(rs.getString("bkURL"));
                    book.setBkResume(rs.getString("bkResume"));
                    bookList.add(book);
                }
                //设置总记录数
                pageBean.setTotalRecord(totalCount);
                //设置可以分的总页数
                pageBean.setTotalPages(totalPages);
                //设置每页数据
                pageBean.setList(bookList);
                //pagesize是用户设置传过来的
                return pageBean;
            } catch (SQLException e) {
                e.printStackTrace();
            }
              finally {
                   try {
                       JDBCUtils.close(rs,pst,conn);
                   } catch (Exception e) {
                       e.printStackTrace();
                   }
            }
            return null;
    }

    @Override
    public int Modify_book(Book book) {
        try {
            conn=JDBCUtils.getConnection();
            String sql="UPDATE book set";
            StringBuffer stringBuffer=new StringBuffer(sql);
            //拼接的时候别忘了单引号
            if(book.getBkName()!=null && !"".equals(book.getBkName())){
             stringBuffer.append(" bkName='").append(book.getBkName()).append("',");
            }
            if (book.getBkAuthor()!=null&&!"".equals(book.getBkAuthor())){
                stringBuffer.append(" bkAuthor='").append(book.getBkAuthor()).append("',");
            }
            if(book.getBkPress()!=null&&!"".equals(book.getBkPress())){
                stringBuffer.append(" bkPress='").append(book.getBkPress()).append("',");
            }
            if(book.getBkPrice()!=null&&!"".equals(book.getBkPrice())){
                stringBuffer.append(" bkPrice='").append(book.getBkPrice()).append("',");
            }
            if(book.getBkStatus()!=null&&!"".equals(book.getBkStatus())){
                stringBuffer.append(" bkStatus='").append(book.getBkStatus()).append("',");
            }
            //URL不能为空
            if(book.getBkURL()!=null&&!"".equals(book.getBkURL())){
                stringBuffer.append(" bkURL='").append(book.getBkURL()).append("'");
            }
              stringBuffer.append(" where bkID='").append(book.getBkID()).append("'");
              System.out.println(stringBuffer);
             pst=conn.prepareStatement(stringBuffer.toString());
             return pst.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }


    public int CountTotalRecord(PageBean<Book> pageBean){
       try {
           conn=JDBCUtils.getConnection();
           String vague_sql="select count(*) from book where 1=1";
           StringBuffer stringBuffer=new StringBuffer(vague_sql);
           if(pageBean.getVague_query().getBkID()!=null&& !"".equals(pageBean.getVague_query().getBkID())){
               stringBuffer.append(" and bkID like '%").append(pageBean.getVague_query().getBkID()).append("%'");
           }
           if(pageBean.getVague_query().getBkName()!=null&& !"".equals(pageBean.getVague_query().getBkName())){
               stringBuffer.append(" and bkName like '%").append(pageBean.getVague_query().getBkName()).append("%'");
           }
           if(pageBean.getVague_query().getBkAuthor()!=null&& !"".equals(pageBean.getVague_query().getBkAuthor())){
               stringBuffer.append(" and bkAuthor like '%").append(pageBean.getVague_query().getBkAuthor()).append("%'");
           }
           if(pageBean.getVague_query().getBkStatus()!=null){
               stringBuffer.append(" and bkStatus like '%").append(pageBean.getVague_query().getBkStatus()).append("%'");
           }
           System.out.println(stringBuffer);
//           String sql="select count(*) from book";
//           pst=conn.prepareStatement(sql);
           pst=conn.prepareStatement(stringBuffer.toString());
           rs=pst.executeQuery();
           int totalCount=0;
           if(rs.next()){
               totalCount= rs.getInt(1);
           }
           System.out.println(totalCount);
           return totalCount;
       } catch (SQLException e) {
           e.printStackTrace();
       }
       finally {
           try {
               JDBCUtils.close(rs,pst,conn);
           } catch (Exception e) {
               e.printStackTrace();
           }
       }
       return 0;
}
}
