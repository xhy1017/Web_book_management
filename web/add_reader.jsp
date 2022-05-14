<%--
  Created by IntelliJ IDEA.
  User: x'h'y
  Date: 2022/4/12
  Time: 20:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8"  %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <link rel="stylesheet" href="https://cdn.bootcdn.net/ajax/libs/twitter-bootstrap/4.6.1/css/bootstrap.min.css" >
    <title>添加读者</title>
</head>
<body>
<script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.6.0/jquery.js"></script>
<script src="https://cdn.bootcdn.net/ajax/libs/popper.js/1.16.1/umd/popper.min.js" ></script>
<script src="https://cdn.bootcdn.net/ajax/libs/twitter-bootstrap/4.6.1/js/bootstrap.min.js"></script>
<script>
    function valid_reader_form(){
        const rdID=document.getElementById("rdID").value;
        const rdName=document.getElementById("rdName").value;
        const rdDept=document.getElementById("rdDept").value;
        //读者ID验证
        var patterns=/^rd\d{7}?$/;
        // //出版社中文验证
        var reg=/^[\u4e00-\u9fa5]+$/;
        if(patterns.test(rdID)===false){
            alert("读者ID输入不合法\n请重新输入");
            document.getElementById("rdID").style.borderColor="#ea0404";
            return false;
        }
        if(reg.test(rdName)===false){
            alert("读者名字必须是中文");
            document.getElementById("rdName").style.borderColor="#ea0404";
            return false;
        }
        if(reg.test(rdDept)===false){
            alert("院系名也是中文呢!");
            document.getElementById("rdDept").style.borderColor="#ea0404";
            return false;
        }
        return true;
    }
</script>
<script>
    $(function (){
        $("#upreader").click(function ()
        {
            if(valid_reader_form()===true){
                if($("#upload_reader_picture")[0].files.length===0)
                {
                    alert("请添加图片!")
                    return;
                }
                //必须加个[0]转换为原生dom对象
                var formdata=new FormData($("#readerform")[0]);
                document.getElementById("readerform").reset();
                $("#show_img")[0].src="";
                document.getElementById("show_img").style.display='none';
                $.ajax(
                    {
                        url:"AddReaderServlet",
                        type:'POST',
                        data:formdata,
                        cache:false,//禁用缓存
                        //对于上传文件contentType = multipart/form-data作为请求头是必须的，而普通的 post 请求头是 application/x-www-form-urlencoded.所以如果没有设置成 false,是不能用来传输文件的
                        contentType:false,//F12打开请求头内容发现在 multipart/form-data 后面有boundary以及一串字符，这是分界符，后面的一堆字符串是随机生成的，目的是防止上传文件中出现分界符导致服务器无法正确识别文件起始位置。multipart/form-data 请求是基于 http 原有的请求方式 post 而来的。
                        //在 ajax 中 contentType 设置为 false 是为了避免 JQuery 对其操作，从而失去分界符，而使服务器不能正常解析文件。
                        processData:false,//不去处理数据、如果 processData 为 true,会被处理并转换为 query string
                        success:function (data){
                            console.log(data);
                            alert(data);
                            $("#readerform")[0].reset();
                            $("#show_img")[0].src="";
                            document.getElementById("show_img").style.display='none';
                            $("#test1").load("add_reader.jsp");
                        }
                    }
                )
            }
    });
    })
</script>
<form onsubmit="return valid_reader_form()" id="readerform" enctype="multipart/form-data">
    <table class="table table-hover">
        <tr>
            <td>读者id:</td>
            <td><input type="text" class="form-control col-md-3" placeholder="rd开头且数字不超过7位" id="rdID" name="rdID"></td>
        </tr>
        <tr>
            <td>读者类型:</td>
            <td>
                <select name="rdType" class="form-control col-md-3">
                    <option value="1">教师</option>
                    <option value="2">本科生</option>
                    <option value="3">硕士研究生</option>
                    <option value="4">博士研究生</option>
                    <option value="5">高中生</option>
            </select>
            </td>
        </tr>
        <tr>
            <td>姓名:</td>
            <td><input type="text" class="form-control col-md-3" placeholder="必须是中文" id="rdName" name="rdName"></td>
        </tr>
        <tr>
            <td>所属院系:</td>
            <td><input type="text" class="form-control col-md-3" placeholder="同上" id="rdDept" name="rdDept"></td>
        </tr>
        <tr>
        <td>QQ:</td>
        <td><input type="number" class="form-control col-md-3" placeholder="不要不填哦"  name="rdQQ"></td>
        </tr>
        <tr>
        <td>上传头像:</td>
       <td>
           <input type="file" name="rd_portraits" accept="image/jpeg,image/jpg,image/png" id="upload_reader_picture">
           <img id="show_img"  style="display: none;width: 100px;height: 100px;border-radius: 50%" alt="好看吗" src="">
       </td>
            <script>
                var getUserPhoto = document.getElementById("upload_reader_picture");
                getUserPhoto.onchange = function ()
                {
                    var file = this.files;
                    console.log(file);
                    var reader = new FileReader();
                    reader.readAsDataURL(file[0]);
                    reader.onload = function ()
                    {
                        var image = document.getElementById("show_img");
                        image.style.display='block'
                        image.src = reader.result;
                    };
                };
            </script>
        </tr>
        <tr>
            <td><input  type="reset"   class="col-sm-5 btn btn-outline-danger  "  value="重置"></td>
            <td><input id="upreader" type="button" class="col-sm-2 btn btn-outline-info  "  value="注册读者"></td>
        </tr>
    </table>
</form>
<table class="table table-hover ">
    <thead class="thead-light" >
    <tr>
        <th>读者ID</th>
        <th>读者类型</th>
        <th>姓名</th>
        <th>所属院系</th>
        <th>QQ</th>
        <th>已借书数量</th>
        <th>操作</th>
    </tr>
    </thead>
     <tbody>
     <%--查询的结果集list在servlet中被保存到域中--%>
     <c:if test="${not empty sessionScope.add_reader}">
<%--     从session域中拿到add_reader属性--%>
     <c:forEach items="${sessionScope.add_reader}" var="reader" varStatus="s">
     <tr>
             <%-- .rdID实际上是getrdiD方法--%>
         <td><strong>${reader.rdID}</strong></td>
         <td><strong>${reader.rdType}</strong></td>
         <td><strong>${reader.rdName}</strong></td>
         <td><strong>${reader.rdDept}</strong></td>
         <td><strong>${reader.rdQQ}</strong></td>
         <td style="text-align:left"><strong>0本</strong></td>
                 <td>
                     <button type="button" class="btn btn-info" id="watch_pwd">查看密码</button>
                 </td>
     <script>
        $("#watch_pwd").click(function (){
            console.log($(this).val());
             $(this).text("默认密码:123456");
         })
     </script>
     <tr>
     </c:forEach>
     </c:if>
     </tbody>
</table>
</body>
</html>
