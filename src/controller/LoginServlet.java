package controller;


import Utils.isMobileAgent;
import entity.Reader;
import service.ReaderService;
import service.ReaderService_impl;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

@WebServlet (name = "LoginServlet",urlPatterns = "/Login")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
               doPost(req,resp);
    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //统一浏览器以及服务器编码解码格式
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html;charset=UTF-8");
        resp.setCharacterEncoding("UTF-8");
        //getWriter 字符流 输出文本内容 outputStream 输出二进制字节数组 字节流
        PrintWriter writer= resp.getWriter();
        //获得用户类型//移动端登录 Android 使用的是OKHTTP请求，默认请求头为okhttp/4.9.3，没有设备信息
        String header = req.getHeader("User-Agent");
        System.out.println(header);
        String cookie2= req.getHeader("Cookie");
        System.out.println("第一次"+cookie2);
        if(isMobileAgent.isMobileDevice(header)){
            System.out.println("请求方法"+req.getMethod());
            //看有没有cookie
            //第一次访问是新的，
            System.out.println("会话"+req.getSession().isNew());
            String rdid = req.getParameter("rdID").trim();
            String pwd= req.getParameter("rdpassword").trim();
            System.out.println(rdid);
            System.out.println(pwd);
            //创建readerservice对象
            ReaderService readerService=new ReaderService_impl();
            //service调用dao层方法，获取的参数值传递给FindReader
            Reader reader = readerService.IsReader(rdid, pwd);
            System.out.println(reader);
            //登录成功
           if(reader!=null){
               //请求转发
               req.getSession().setAttribute("msg",reader);
               //可以把整个reader发给请求头
               resp.setHeader("rdName",URLEncoder.encode(reader.getRdName(), StandardCharsets.UTF_8));//编码再发送
               req.getRequestDispatcher("/Find_bookServlet").forward(req,resp);//请求转发
           }
           else {
                  writer.println("登录失败");
           }
            return;//返回
        }
        //非移动端处理
        StringBuffer url = req.getRequestURL();
        System.out.println("获取的请求路径"+url);
        String method=req.getMethod();
        System.out.println("获取的请求方法"+method);
        String queryString=req.getQueryString();
        System.out.println("参数为"+queryString);
       //获取输入的参数
        String rdid = req.getParameter("rdID").trim();
        String pwd= req.getParameter("rdpassword").trim();
        //创建readerservice对象
        ReaderService readerService=new ReaderService_impl();
        //service调用dao层方法，获取的参数值传递给IsReader
        Reader reader = readerService.IsReader(rdid, pwd);
//        判断reader是否存在，若1则跳转管理页面，否则提示用户名或密码错误
        if(reader!=null) {//登陆成功，跳转页面
            //设置到了session对象属性中
            System.out.println("LOGIN打印的"+req.getSession().getId());
            req.getSession().setAttribute("msg",reader);
            resp.sendRedirect("admin.jsp");
        }
        else {
            req.getSession().setAttribute("errormsg","账号不存在或者账号密码错误");//前端页面提示信息
            resp.sendRedirect("login.jsp");
        }

    }
}
