package controller;

import com.google.gson.Gson;
import entity.Book;
import service.BookService;
import service.BookService_impl;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet(name = "Find_bookServlet", value = "/Find_bookServlet")
public class Find_bookServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html;charset=UTF-8");
        resp.setCharacterEncoding("UTF-8");
        PrintWriter writer = resp.getWriter();
        System.out.println("找all书打印的"+req.getSession().getId());//这个肯定是一样的
        String bkID = req.getParameter("bkID");
        System.out.println("书号  "+bkID);
        BookService bookService=new BookService_impl();
        List<Book> list = bookService.FindAllBook(bkID);
        Gson gson=new Gson();
        String json = gson.toJson(list);
        //JSSEIONID返回给android请求头中保持会话连接 30分钟默认有效期
        resp.setHeader("Cookie",req.getSession().getId());
        writer.println(json);
    }
}
