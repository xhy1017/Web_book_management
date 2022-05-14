package controller;

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
import java.util.List;

@WebServlet(name = "Modify_Book_Servlet", value = "/Modify_Book_Servlet")
public class Modify_Book_Servlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            doPost(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//       去apache官网下载的fileUpload.jar包和io包
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter writer = response.getWriter();
//        String bkName = request.getParameter("bkName");
        //jsp设置了form-data确实拿不到数据了
//        System.out.println(bkName+"uuuuu");
        //输入流
        InputStream inputStream;
        //文件输出流
        FileOutputStream Static_fileOutputStream;
        FileOutputStream Dynamic_fileOutputStream;
        //判断是否多段数据.（只有是多段的数据，才是文件上传的）
        if(ServletFileUpload.isMultipartContent(request)){
            //创建 FileItemFactory 工厂实现类
            FileItemFactory fileItemFactory=new DiskFileItemFactory();
            //.创建用于解析上传数据的工具类
            ServletFileUpload servletFileUpload=new ServletFileUpload(fileItemFactory);
            try {
                List<FileItem> fileItems=servletFileUpload.parseRequest(request);
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
                            case "bkResume"-> {
                                System.out.println(fileItem.getString("UTF-8"));
                                book.setBkResume(fileItem.getString("UTF-8"));
                            }
                            default -> {
                                writer.println("请上传图片!");
                                throw new IllegalStateException("Unexpected value: " + fieldName);
                            }
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
                int i = bookService.Modify_book(book);
                System.out.println("返回值"+i);
                if(i>0){
                    writer.println("修改书籍成功");
                }
                else {
                    writer.println("修改书籍失败");
                }
            } catch (FileUploadException e) {
                e.printStackTrace();
            }
        }
    }
}
