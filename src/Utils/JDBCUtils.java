package Utils;

import com.alibaba.druid.pool.DruidDataSourceFactory;

import javax.sql.DataSource;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;

public class JDBCUtils {
    private static DataSource dataSource ;

    /**�Ÿո�
     * �ļ��Ķ�ȡ��ֻ��Ҫ��ȡһ�μ����õ���Щֵ��ʹ�þ�̬�����
     * ���ļ��ж�ȡ��Ϣ
     * Ȼ�����Utils�����Գ�ʼ��
     **/
    //��̬������ʼ��DataSource���������Ϣ
    static{
        try {
            //1.���������ļ�
            Properties pro = new Properties();
            pro.load(JDBCUtils.class.getClassLoader().getResourceAsStream("druid.properties"));
            //2.��ȡDataSource
            dataSource = DruidDataSourceFactory.createDataSource(pro);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * ��ȡ����
     * @return ���Ӷ���
     */
    public static Connection getConnection() throws SQLException {
        /*
          ��̬����
          ��������url user password
          ����Connection����
         */
        return dataSource.getConnection();
    }

    public  static void close(Statement stmt, Connection conn){
        close(null,stmt,conn);
    }

    public static void close(ResultSet rs, Statement stmt, Connection conn){


        if(rs != null){
            try {
                rs.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }


        if(stmt != null){
            try {
                stmt.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        if(conn != null){
            try {
                conn.close();//�黹����
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public static DataSource getDataSource(){
        return  dataSource;
    }
}

