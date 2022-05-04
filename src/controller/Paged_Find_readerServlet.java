package controller;

import com.alibaba.fastjson.JSONObject;
import entity.Book;
import entity.PageBean;
import entity.Reader;
import service.BookService;
import service.BookService_impl;
import service.ReaderService;
import service.ReaderService_impl;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet(name = "Find_reader Servlet", value = "/Find_readerServlet")
public class Paged_Find_readerServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
                doPost(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/json;charset=UTF-8");
        PrintWriter writer = response.getWriter();
        /*  */
        String rdID = request.getParameter("rdID");
        System.out.println("读者id号:" + rdID);
        String rdName=request.getParameter("rdName");
        System.out.println("姓名:"+rdName);
        String rdType = request.getParameter("rdType");
        System.out.println("类型:"+rdType);
        String rdDept=request.getParameter("rdDept");
        System.out.println("院系:"+rdDept);
        String rdBorrowQty=request.getParameter("rdBorrowQty");
        System.out.println(rdBorrowQty);
        Reader reader =new Reader();
        PageBean<Reader> pageBean=new PageBean<>();
        reader.setRdID(rdID);
        reader.setRdName(rdName);
        reader.setRdType(rdType);
        reader.setRdDept(rdDept);
        reader.setRdBorrowQty(rdBorrowQty);
        pageBean.setVague_query(reader);
        //后续点下一页的时候不用传pageSIZE，直接从session中拿到
        if (request.getParameter("pageSize") == null) {
            String pagesize= request.getSession().getAttribute("PageBean_reader").toString();
            System.out.println(pagesize);
            //转json对象
            JSONObject jsonObject=JSONObject.parseObject(pagesize);
            System.out.println(jsonObject);
            //拿到域中的pageSize
            pageBean.setPageSize(Integer.parseInt(jsonObject.getString("pageSize")));
        } else {
            /* 非空即选择了页面大小*/
            pageBean.setPageSize(Integer.parseInt(request.getParameter("pageSize")));
        }
        //刚开始查询避免数据转换空指针异常，强制设置丢到数据库里的初始页面为1，数据库返回如果每页数据会改为0给页面
        if (request.getParameter("currentPage") == null) {
            pageBean.setCurrentPage(1);
        } else {
            pageBean.setCurrentPage(Integer.parseInt(request.getParameter("currentPage")));
        }
        System.out.println("当前页面:" + pageBean.getCurrentPage());
        //调用dao层方法
        ReaderService readerService = new ReaderService_impl();
        pageBean = readerService.Paged_FindReader(pageBean);
        //记录数大于0表明有满足条件的记录
        if (pageBean!=null&&pageBean.getTotalRecord()>0) {
//            sessionPage中的相同属性值会被覆盖，正好符合分页要求
            request.getSession().setAttribute("PageBean_reader", pageBean);
            writer.println("分页查询成功!");
        } else {
            // sessionPage中的相同属性值会被覆盖，正好符合分页要求
            request.getSession().setAttribute("PageBean_reader", pageBean);
            writer.println("未找到结果!");
        }
    }
}
