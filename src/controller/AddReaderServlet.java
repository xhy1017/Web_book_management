package controller;

import entity.Reader;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import service.ReaderService;
import service.ReaderService_impl;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.*;
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
                 Reader reader=new Reader();
                for (FileItem fileItem:fileItems){
                    if(fileItem.isFormField())//普通字段表单
                    {
                        //属性名，及key名字
                        String fieldName = fileItem.getFieldName();
                        System.out.println(fieldName);
                        switch (fieldName) {
                            case "rdID"-> reader.setRdID(fileItem.getString("UTF-8"));
                            case "rdName"-> reader.setRdName(fileItem.getString("UTF-8"));
                            case "rdDept"-> reader.setRdDept(fileItem.getString("UTF-8"));
                            case "rdType"-> reader.setRdType(fileItem.getString("UTF-8"));
                            case "rdQQ"->reader.setRdQQ(fileItem.getString("UTF-8"));
                            default -> throw new IllegalStateException("Unexpected value: " + fieldName);
                        }
                    }
                    else {
                        //获取文件表单属性名:
                        System.out.println(fileItem.getFieldName());
                        //只能有一个/ 这样访问的才是tomcat目录，
                        reader.setUser_Image_URL("User_Images/"+reader.getRdID()+".png");
                        //获取图片名
                        System.out.println(fileItem.getName());
                        //文件输入流
                        inputStream=fileItem.getInputStream();
                        //动态路径tomcat路径
                        String dynamicPath = this.getServletContext().getRealPath("/User_Images/");
                        System.out.println(dynamicPath);
                        String staticPath = "C:\\Users\\x'h'y\\IdeaProjects\\Web_library_management\\web\\User_Images";
                        System.out.println(staticPath);
                        File dynamicFile=new File(dynamicPath,reader.getRdID()+".png");
                        File staticFile=new File(staticPath,reader.getRdID()+".png");
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
                ReaderService readerService = new ReaderService_impl();
                int i = readerService.AddReader(reader);
                if(i>0){
                    writer.println("添加读者成功");
                    List<Reader> readerList=new ArrayList<>();
                    readerList.add(reader);
                    request.getSession().setAttribute("add_reader",readerList);
                }
                else {
                    writer.println("添加读者失败");
                }
            } catch (FileUploadException e) {
                e.printStackTrace();
            }
        }
    }
}
