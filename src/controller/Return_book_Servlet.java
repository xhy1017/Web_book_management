package controller;

import service.ReaderService;
import service.ReaderService_impl;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "Return_book_Servlet", value = "/Return_book_Servlet")
public class Return_book_Servlet extends HttpServlet {
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
        String rdID = request.getParameter("rdID");
        System.out.println("第三次"+request.getSession().isNew());
        System.out.println("读者号"+rdID);
        String bkId = request.getParameter("bkID");
        System.out.println("书号"+bkId);
        String dateLendAct = request.getParameter("DateLendAct");
        System.out.println("实际还书日期"+dateLendAct);
        ReaderService readerService=new ReaderService_impl();
        int i = readerService.Return_book(rdID,bkId,dateLendAct);
        if(i>0){
            writer.println("还书成功!");
        }
        else {
            writer.println("还书失败!");
        }
    }
}
