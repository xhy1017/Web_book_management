package controller;

import entity.Book;
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

@WebServlet(name = "Find_bookServlet", value = "/Find_bookServlet")
public class Find_bookServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html;charset=UTF-8");
        PrintWriter writer = resp.getWriter();
        String bkID = req.getParameter("bkID");
        System.out.println(bkID);
        BookService bookService=new BookService_impl();
        List<Book> list = bookService.FindAllBook(bkID);
        req.getSession().setAttribute("list_book",list);
        writer.println("查询成功!");
//        req.getRequestDispatcher("/add_book.jsp").forward(req,resp);
    }
}
