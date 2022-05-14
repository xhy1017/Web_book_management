package controller;


import Utils.isMobileAgent;
import entity.Reader;
import service.ReaderService;
import service.ReaderService_impl;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.LinkedHashMap;
import java.util.Objects;

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
        //获得用户类型//移动端登录 Android 使用的是OKHTTP请求，请求头为okhttp/4.9.3，既然这样直接当他是，不去管他的真实Agent
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
               resp.setHeader("rdName",URLEncoder.encode(reader.getRdName(),"UTF-8"));
               req.getRequestDispatcher("/Find_bookServlet").forward(req,resp);
           }
           else {
                  writer.println("登录失败");
           }
            return;
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
        //service调用dao层方法，获取的参数值传递给FindReader
        Reader reader = readerService.IsReader(rdid, pwd);
//        判断reader是否存在，若1则跳转管理页面，否则提示用户名或密码错误
        if(reader!=null) {//登陆成功，跳转页面
            //设置到了session对象属性中
            System.out.println("LOGIN打印的"+req.getSession().getId());
            req.getSession().setAttribute("msg",reader);
            resp.sendRedirect("admin.jsp");
        }
        else {
            req.getSession().setAttribute("errormsg","账号不存在或者账号密码错误");
            resp.sendRedirect("login.jsp");
//            //设置响应数据格式
//            resp.setContentType("text/json;charset=UTF-8");
//            //
//            Gson gson=new Gson();
//            //LINKED HASHMAP使得json输出有序存放
//            JSONObject jsonObject=new JSONObject(new LinkedHashMap<>());
//            //json数据key一定要与Android端bean类属性名一样否则转化不了为java类对象
//            jsonObject.put("rdid",rdid);
//            jsonObject.put("rdpassword",pwd);
//            String json = gson.toJson(jsonObject);
//            //字符输出流
//            PrintWriter writer = resp.getWriter();
//            writer.println(json);
        }

    }
}
