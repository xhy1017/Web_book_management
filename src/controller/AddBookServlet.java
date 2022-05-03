package controller;

import com.alibaba.fastjson.JSONObject;
import com.google.gson.Gson;
import entity.Book;
import service.BookService;
import service.BookService_impl;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;

@WebServlet(name = "BookServlet", value = "/AddBookServlet")
public class AddBookServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
          //post参数在body里面
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html;charset=UTF-8");
        //writer一定要在这三个之后，不然会乱码
        PrintWriter writer=resp.getWriter();
        Book book=new Book();
        book.setBkID(req.getParameter("bkID"));
        book.setBkName(req.getParameter("bkName"));
        book.setBkAuthor(req.getParameter("bkAuthor"));
        book.setBkPress(req.getParameter("bkPress"));
        book.setBkPrice(req.getParameter("bkPrice"));
        book.setBkStatus(req.getParameter("bkStatus"));
        //服务层对象调用readerdao方法
        BookService bookService=new BookService_impl();
        int i= bookService.AddBook(book);
        if(i>0)
        {  List<Book> list=new ArrayList<>();
            list.add(book);
            req.getSession().setAttribute("add_book",list);
            writer.println("添加书籍成功");
        }
        else {
            resp.setContentType("text/json;charset=UTF-8");
            //创建一个GSON对象
            Gson gson=new Gson();
            //使得json输出有序存放
            JSONObject jsonObject=new JSONObject(new LinkedHashMap<>());
            //json数据key一定要与Android端bean类属性名一样否则转化不了为java类对象
            jsonObject.put("rdid",book.getBkID());
            jsonObject.put("rdpassword",book.getBkName());
            String json = gson.toJson(jsonObject);
            //字符输出流
            writer.println(json);
        }
    }
}
