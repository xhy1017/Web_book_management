package controller;

import entity.Reader;
import service.ReaderService;
import service.ReaderService_impl;

import javax.script.ScriptContext;
import javax.script.SimpleScriptContext;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "AddReaderServlet", value = "/AddReaderServlet")
public class AddReaderServlet extends HttpServlet {
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
        ReaderService readerService=new ReaderService_impl();
        Reader reader=new Reader();
        reader.setRdID(request.getParameter("rdID"));
        reader.setRdType(request.getParameter("rdType"));
        reader.setRdName(request.getParameter("rdName"));
        reader.setRdDept(request.getParameter("rdDept"));
        reader.setRdQQ(request.getParameter("rdQQ"));
        //调用方法
        int i = readerService.addReader(reader);
        List<Reader> list2= new ArrayList<>();
        if(i>0)
        {   list2.add(reader);
            //list拿到session域中保存
            request.getSession().setAttribute("reader_list",list2);
            //可能打印不出来，因为被拦截了好像
            writer.println("添加读者成功!");
        }
        else{
            writer.println("添加失败!");
            //回到添加页面重定向
//            response.sendRedirect("/xxx.jsp");
        }
    }
}
