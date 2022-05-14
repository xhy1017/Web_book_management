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

@WebServlet(name = "Find_lend_book_Servlet", value = "/Find_lend_book_Servlet")
public class Find_lend_book_Servlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
       doPost(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //统一浏览器以及服务器编码解码格式
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        //getWriter 字符流 输出文本内容 outputStream 输出二进制字节数组 字节流
        PrintWriter writer= response.getWriter();
        System.out.println("第二次"+request.getSession().isNew());
        String rdID = request.getParameter("rdID");
        System.out.println("用户名"+rdID);
        BookService bookService=new BookService_impl();
        List<Book> bookList =bookService.Find_lend_books(rdID);
        if (bookList == null){
            writer.println("您还没有借阅书籍呢");
        }
        else {
            System.out.println(bookList.toString());
            Gson gson=new Gson();
            String lend_book = gson.toJson(bookList);
            writer.println(lend_book);
        }
    }
}
