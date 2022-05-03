package controller;

import service.BookService;
import service.BookService_impl;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Arrays;

@WebServlet(name = "Remove_book_Servlet", value = "/Remove_book_Servlet")
public class Remove_book_Servlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
     doPost(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter writer = response.getWriter();
        String[] checkeds = request.getParameterValues("checked");
        System.out.println(Arrays.toString(checkeds));
        BookService bookService=new BookService_impl();
        int i = bookService.Remove_book(checkeds);
        if(i>0){
            writer.println("删除成功");
        }
        else {
            writer.println("删除失败");
        }

    }
}
