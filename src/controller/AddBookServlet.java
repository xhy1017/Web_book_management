package controller;

import com.alibaba.fastjson.JSONObject;
import com.google.gson.Gson;
import entity.Book;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import service.BookService;
import service.BookService_impl;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.*;
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
        //输入流
        InputStream inputStream;
        //文件输出流
        FileOutputStream Static_fileOutputStream;
        FileOutputStream Dynamic_fileOutputStream;
        //判断是否多段数据.（只有是多段的数据，才是文件上传的）
        if(ServletFileUpload.isMultipartContent(req)){
            //创建 FileItemFactory 工厂实现类
            FileItemFactory fileItemFactory=new DiskFileItemFactory();
            //.创建用于解析上传数据的工具类
            ServletFileUpload servletFileUpload=new ServletFileUpload(fileItemFactory);
            try {
                List<FileItem> fileItems=servletFileUpload.parseRequest(req);
                Book book = new Book();
                for (FileItem fileItem:fileItems){
                    if(fileItem.isFormField())//普通字段表单
                    {
                        //属性名，及key名字
                        String fieldName = fileItem.getFieldName();
                        System.out.println(fieldName);
                        switch (fieldName) {
                            case "bkID"-> book.setBkID(fileItem.getString("UTF-8"));
                            case "bkName"-> book.setBkName(fileItem.getString("UTF-8"));
                            case "bkAuthor"-> book.setBkAuthor(fileItem.getString("UTF-8"));
                            case "bkPress"-> book.setBkPress(fileItem.getString("UTF-8"));
                            case "bkPrice"->book.setBkPrice(fileItem.getString("UTF-8"));
                            case "bkStatus"->book.setBkStatus(fileItem.getString("UTF-8"));
                            case "bkResume" -> {
                                System.out.println(fileItem.getString("UTF-8"));
                                book.setBkResume(fileItem.getString("UTF-8"));
                            }
                            default -> throw new IllegalStateException("Unexpected value: " + fieldName);
                        }
                    }
                    else {
                        //获取文件表单属性名:
                        System.out.println(fileItem.getFieldName());
                        //只能有一个/ 这样访问的才是tomcat目录，
                        book.setBkURL("images/"+book.getBkID()+".png");
                        //获取图片名
                        System.out.println(fileItem.getName());
                        //文件输入流
                        inputStream=fileItem.getInputStream();
                        //动态路径tomcat路径
                        String dynamicPath = this.getServletContext().getRealPath("/images/");
                        System.out.println(dynamicPath);
                        String staticPath = "C:\\Users\\x'h'y\\IdeaProjects\\Web_library_management\\web\\images";
                        System.out.println(staticPath);
                        File dynamicFile=new File(dynamicPath,book.getBkID()+".png");
                        File staticFile=new File(staticPath,book.getBkID()+".png");
                        int len;
                        byte[] buf = new byte[1024];
                        Static_fileOutputStream=new FileOutputStream(staticFile);
                        Dynamic_fileOutputStream=new FileOutputStream(dynamicFile);
                        while((len=inputStream.read(buf))!=-1){
                            Static_fileOutputStream.write(buf,0,len);
                            Dynamic_fileOutputStream.write(buf,0,len);
                        }
                    }
                }
                BookService bookService = new BookService_impl();
                int i = bookService.AddBook(book);
                if(i>0){
                    writer.println("添加图书成功");
                    req.getSession().setAttribute("add_book",book);
                }
                else {
                    writer.println("添加失败");
                }
            } catch (FileUploadException e) {
                e.printStackTrace();
            }
        }
//            resp.setContentType("text/json;charset=UTF-8");
//            //创建一个GSON对象
//            Gson gson=new Gson();
//            //使得json输出有序存放
//            JSONObject jsonObject=new JSONObject(new LinkedHashMap<>());
//            //json数据key一定要与Android端bean类属性名一样否则转化不了为java类对象
//            jsonObject.put("rdid",book.getBkID());
//            jsonObject.put("rdpassword",book.getBkName());
//            String json = gson.toJson(jsonObject);
//            //字符输出流
//            writer.println(json);

    }
}
