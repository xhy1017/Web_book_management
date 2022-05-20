package controller;

import com.alibaba.fastjson.JSONObject;

import entity.Book;
import entity.PageBean;
import service.BookService;
import service.BookService_impl;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;


@WebServlet(name = "Paged_Servlet", value = "/Paged_Servlet")
public class Paged_Find_bookServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter writer = response.getWriter();
        //拿到参数,封装给pagebean;
        String bkID = request.getParameter("bkID");
        System.out.println("书号:" + bkID);
        String bkName=request.getParameter("bkName");
        System.out.println("书名:"+bkName);
        String bkAuthor=request.getParameter("bkAuthor");
        System.out.println("作者:"+bkAuthor);
        String bkStatus=request.getParameter("bkStatus");
        System.out.println("状态:"+bkStatus);
        Book book=new Book();
        PageBean<Book> pageBean= new PageBean<>();
        book.setBkID(bkID);
        book.setBkName(bkName);
        book.setBkAuthor(bkAuthor);
        book.setBkStatus(bkStatus);
        pageBean.setVague_query(book);
        //默认第一次查询后续点下一页的时候不用传pageSIZE，直接从session中拿到
        if (request.getParameter("pageSize") == null) {
           String pagesize= request.getSession().getAttribute("PageBean_book").toString();
            System.out.println(pagesize);
            JSONObject jsonObject=JSONObject.parseObject(pagesize);
            System.out.println(jsonObject);
            //拿到域中的pageSize
           pageBean.setPageSize(Integer.parseInt(jsonObject.getString("pageSize")));
        } else {
            pageBean.setPageSize(Integer.parseInt(request.getParameter("pageSize")));
        }
            //刚开始查询避免数据转换空指针异常，强制设置初始页面为1
            if (request.getParameter("currentPage") == null) {
                pageBean.setCurrentPage(1);
            } else {
                pageBean.setCurrentPage(Integer.parseInt(request.getParameter("currentPage")));
            }
            System.out.println("当前页面:" + pageBean.getCurrentPage());
            BookService bookService = new BookService_impl();
            pageBean= bookService.Paged_findbook(pageBean);
            //记录数大于0表明有满足条件的记录
            if (pageBean!=null&&pageBean.getTotalRecord()>0) {
//            sessionPage中的相同属性值会被覆盖，正好符合分页要求
                request.getSession().setAttribute("PageBean_book", pageBean);
                writer.println("分页查询成功!");
            } else {
                // sessionPage中的相同属性值会被覆盖，正好符合分页要求
                request.getSession().setAttribute("PageBean_book", pageBean);
                writer.println("未找到结果!");
            }
        }
    }
