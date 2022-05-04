package Dao;

import Utils.JDBCUtils;
import entity.PageBean;
import entity.Reader;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ReaderDao_impl implements ReaderDao {
    //实现类中具体实现方法
//实现Rederdao的findreader方法/*
//    数据库连接对象
    private Connection conn = null;
    //预编译对象，防止sql注入
    private PreparedStatement pst = null;
    //结果集对象
    private ResultSet rs = null;

    @Override
    public Reader IsReader(String rdID, String rdpassword) {
        try { //开始连接
            conn = JDBCUtils.getConnection();
            //定义需要的sql语句
            String sql = "select *from reader where rdID=? and rdpassword=? ";
            pst = conn.prepareStatement(sql);
            pst.setString(1, rdID);
            pst.setString(2, rdpassword);
            //执行sql语句
            ResultSet rs = pst.executeQuery();
            //新建一个读者对象
            Reader reader = null;
            while (rs.next()) {
                reader = new Reader();
                //与数据库字段名一致
                String UID = rs.getString("rdID");
                String Upsd = rs.getString("rdpassword");
                String Uname=rs.getString("rdName");
                //赋值给用户对象
                reader.setRdID(UID);
                reader.setRdpassword(Upsd);
                reader.setRdName(Uname);
            }
            //获取的用户对象若不为空，返回
            return reader;
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

    @Override
    public int Remove_reader(String... rdIDs) {
        int i=0;
        for (String rdID : rdIDs) {
            i = Remove_reader(rdID);
        }
        return i;
    }
    public int Remove_reader(String ID) {
        try {
            conn=JDBCUtils.getConnection();
            String sql="delete from reader where rdID=?";
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
    public List<Reader> FindAllReader(String rdID) {
    //不输入读者id时的情形
        if (!"".equals(rdID)) {
            try { //开始连接
                conn = JDBCUtils.getConnection();
                //定义需要的sql语句
                String sql = "select *from reader where rdID=?";
                //预编译
                pst = conn.prepareStatement(sql);
                //给？赋值
                pst.setString(1,rdID);
                //执行sql语句
                ResultSet rs = pst.executeQuery();
                //新建一个读者对象
                Reader reader;
                //新建一个list集合
                List<Reader> list = new ArrayList<>();
                while (rs.next()) {
                    reader = new Reader();
                    //与数据库字段名一致
                    String UID = rs.getString("rdID");
                    String Utype = rs.getString("rdType");
                    String name = rs.getString("rdName");
                    String dept = rs.getString("rdDept");
                    String qq = rs.getString("rdQQ");
                    String num = rs.getString("rdBorrowQty");
                    //赋值给用户对象
                    reader.setRdID(UID);
                    reader.setRdType(Utype);
                    reader.setRdName(name);
                    reader.setRdDept(dept);
                    reader.setRdQQ(qq);
                    reader.setRdBorrowQty(num);
                    list.add(reader);
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
        }
        //输入的读者ID为空值，查询全部读者
        else {
            try {
                conn = JDBCUtils.getConnection();
                //定义需要的sql语句 排个序 联表查询 reader表给个别名 r ;readerType表给个别名c 将读者类型名rdType转化为对应的名字
                String sql="select rdID,c.rdTypeName,rdName,rdDept,rdQQ,rdBorrowQty from reader r,readertype c where r.rdType=c.rdType order by rdID DESC";
                pst = conn.prepareStatement(sql);
                //执行sql语句
                ResultSet rs = pst.executeQuery();
                //新建一个读者对象
                Reader reader;
                //新建一个list集合
                List<Reader> list = new ArrayList<>();
                while (rs.next()) {
                    reader = new Reader();
                    //与数据库字段名一致
                    String UID = rs.getString("rdID");
                    String UtypeName = rs.getString("rdTypeName");
                    String name = rs.getString("rdName");
                    String dept = rs.getString("rdDept");
                    String qq = rs.getString("rdQQ");
                    String num = rs.getString("rdBorrowQty");
                    //赋值给用户对象
                    reader.setRdID(UID);
                    reader.setRdTypeName(UtypeName);
                    reader.setRdName(name);
                    reader.setRdDept(dept);
                    reader.setRdQQ(qq);
                    reader.setRdBorrowQty(num);
                    list.add(reader);
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
        return null;
    }
    @Override
    public PageBean<Reader> Paged_FindReader(PageBean<Reader> pageBean) {
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
            String vague_sql="select * from reader  where 1=1";
            StringBuffer stringBuffer=new StringBuffer(vague_sql);
            if(pageBean.getVague_query().getRdID()!=null&& !"".equals(pageBean.getVague_query().getRdID())){
                stringBuffer.append(" and rdID like '%").append(pageBean.getVague_query().getRdID()).append("%'");
            }
            if(pageBean.getVague_query().getRdName()!=null&& !"".equals(pageBean.getVague_query().getRdName())){
                stringBuffer.append(" and rdName like '%").append(pageBean.getVague_query().getRdName()).append("%'");
            }
            if(pageBean.getVague_query().getRdDept()!=null&& !"".equals(pageBean.getVague_query().getRdDept())){
                stringBuffer.append(" and rdDept like '%").append(pageBean.getVague_query().getRdDept()).append("%'");
            }
            if(pageBean.getVague_query().getRdBorrowQty()!=null&!"".equals(pageBean.getVague_query().getRdBorrowQty())){
                stringBuffer.append(" and rdBorrowQty like '%").append(Integer.parseInt(pageBean.getVague_query().getRdBorrowQty())).append("%'");
            }
            if(pageBean.getVague_query().getRdType()!=null&&!"".equals(pageBean.getVague_query().getRdType())){
                stringBuffer.append(" and rdType like '%").append(Integer.parseInt(pageBean.getVague_query().getRdType())).append("%'");
            }
            stringBuffer.append(" limit ?,?");
            System.out.println(stringBuffer);
            //toString 或者valueOf
            pst = conn.prepareStatement(stringBuffer.toString());
            pst.setInt(1, index);
            pst.setInt(2, pageBean.getPageSize());
            System.out.println(pst.toString());
            rs = pst.executeQuery();
            List<Reader> readerList=new ArrayList<>();
            while (rs.next())
            {
                Reader reader=new Reader();
                reader.setRdID(rs.getString("rdID"));
                switch (rs.getInt("rdType")) {
                    case 1 -> reader.setRdTypeName("教师");
                    case 2 -> reader.setRdTypeName("本科生");
                    case 3 -> reader.setRdTypeName("硕士研究生");
                    case 4 -> reader.setRdTypeName("博士研究生");
                    case 5 -> reader.setRdTypeName("高中生");
                    default -> throw new IllegalStateException("Unexpected value: " + rs.getInt("rdType"));
                }
                reader.setRdName(rs.getString("rdName"));
                reader.setRdDept(rs.getString("rdDept"));
                reader.setRdQQ(rs.getString("rdQQ"));
                reader.setRdBorrowQty(String.valueOf(rs.getInt("rdBorrowQty")));
                reader.setUser_Image_URL(rs.getString("user_Image_URL"));
                readerList.add(reader);
            }
            //设置总记录数
            pageBean.setTotalRecord(totalCount);
            //设置可以分的总页数
            pageBean.setTotalPages(totalPages);
            //设置每页数据
            pageBean.setList(readerList);
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
    public int CountTotalRecord(PageBean<Reader> pageBean){
        try {
            conn=JDBCUtils.getConnection();
            String vague_sql="select count(*) from reader where 1=1";
            StringBuffer stringBuffer=new StringBuffer(vague_sql);
            if(pageBean.getVague_query().getRdID()!=null&& !"".equals(pageBean.getVague_query().getRdID())){
                stringBuffer.append(" and rdID like '%").append(pageBean.getVague_query().getRdID()).append("%'");
            }
            if(pageBean.getVague_query().getRdName()!=null&& !"".equals(pageBean.getVague_query().getRdName())){
                stringBuffer.append(" and rdName like '%").append(pageBean.getVague_query().getRdName()).append("%'");
            }
            if(pageBean.getVague_query().getRdDept()!=null&& !"".equals(pageBean.getVague_query().getRdDept())){
                stringBuffer.append(" and rdDept like '%").append(pageBean.getVague_query().getRdDept()).append("%'");
            }
            if(pageBean.getVague_query().getRdBorrowQty()!=null&&!"".equals(pageBean.getVague_query().getRdBorrowQty())){
                stringBuffer.append(" and rdBorrowQty like '%").append(Integer.parseInt(pageBean.getVague_query().getRdBorrowQty())).append("%'");
            }
            if(pageBean.getVague_query().getRdType()!=null&&!"".equals(pageBean.getVague_query().getRdType())){
                stringBuffer.append(" and rdType like '%").append(Integer.parseInt(pageBean.getVague_query().getRdType())).append("%'");
            }
            System.out.println(stringBuffer);
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
    @Override
    public int addReader(Reader reader) {
        try {
            conn= JDBCUtils.getConnection();
            String sql = "INSERT INTO reader values(?,?,?,?,?,0,123456)";
            pst=conn.prepareStatement(sql);
            pst.setString(1,reader.getRdID());
            pst.setString(2,reader.getRdType());
            pst.setString(3,reader.getRdName());
            pst.setString(4,reader.getRdDept());
            pst.setString(5,reader.getRdQQ());
            return pst.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
        finally {
            try {
                JDBCUtils.close(pst,conn);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return 0;
    }
    @Override
    public int Modify_reader(Reader reader) {
        try {
            conn=JDBCUtils.getConnection();
            String sql="UPDATE reader set";
            StringBuffer stringBuffer=new StringBuffer(sql);
            //拼接的时候别忘了单引号
            if(reader.getRdName()!=null && !"".equals(reader.getRdName())){
                stringBuffer.append(" rdName='").append(reader.getRdName()).append("',");
            }
            if (reader.getRdDept()!=null&&!"".equals(reader.getRdDept())){
                stringBuffer.append(" rdDept='").append(reader.getRdDept()).append("',");
            }
            if(reader.getRdType()!=null&&!"".equals(reader.getRdType())){
                stringBuffer.append(" rdType='").append(reader.getRdType()).append("',");
            }
            if(reader.getRdBorrowQty()!=null&&!"".equals(reader.getRdBorrowQty())){
                stringBuffer.append(" rdBorrowQty='").append(reader.getRdBorrowQty()).append("',");
            }
            if(reader.getRdQQ()!=null&&!"".equals(reader.getRdQQ())){
                stringBuffer.append(" rdQQ='").append(reader.getRdQQ()).append("',");
            }
            //URL不能为空
            if(reader.getUser_Image_URL()!=null&&!"".equals(reader.getUser_Image_URL())){
                stringBuffer.append(" user_Image_URL='").append(reader.getUser_Image_URL()).append("'");
            }
            stringBuffer.append(" where rdID='").append(reader.getRdID()).append("'");
            System.out.println(stringBuffer);
            pst=conn.prepareStatement(stringBuffer.toString());
            return pst.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
            
}

