package controller;

import entity.Borrow;
import service.ReaderService;
import service.ReaderService_impl;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "Borrow_book_Servlet", value = "/Borrow_book_Servlet")
public class Borrow_book_Servlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        PrintWriter writer = response.getWriter();
       Borrow borrow =new Borrow();
        System.out.println("读者ID"+request.getParameter("rdID"));
       borrow .setRdID(request.getParameter("rdID"));
        System.out.println("书号"+request.getParameter("bkID"));
       borrow.setBkID(request.getParameter("bkID"));
        System.out.println("借书时间"+request.getParameter("DateBorrow"));
       borrow.setDateBorrow(request.getParameter("DateBorrow"));
        System.out.println("还书时间"+request.getParameter("DateLendPlan"));
       borrow.setDateLendPlan(request.getParameter("DateLendPlan"));
        ReaderService readerService=new ReaderService_impl();
        int i = readerService.Borrow_book(borrow);
        if(i>0){
            writer.print("借书成功!");
        }
        else
        {
            writer.print("借书失败!");
        }
    }
}
