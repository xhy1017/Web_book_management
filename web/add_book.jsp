<%--
  Created by IntelliJ IDEA.
  User: x'h'y
  Date: 2022/4/11
  Time: 0:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%--引入jstl核心标签库--%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <link rel="stylesheet" href="to-top.css">
    <link rel="stylesheet" href="https://cdn.bootcdn.net/ajax/libs/twitter-bootstrap/4.6.1/css/bootstrap.min.css" >
    <title >添加图书</title>
</head>
<body>
<form  onsubmit="return verify_form()" id="bookform" enctype="multipart/form-data" >
    <table class="table table-hover table-borderless">
        <tr><td class="text-center" style="font-size: large" colspan="2"><strong>请输入书籍信息</strong></td></tr>
        <tr>
            <td>书号:</td>
            <td><input type="text" class="form-control col-md-3" placeholder="bk开头且数字长度位7位" id="bkID" name="bkID" style="display: inline"><span style="color: red;display: none">书号输入不合法,请重新输入</span></td>
        </tr>
        <tr>
            <td>书名:</td>
            <td><input type="text" class="form-control col-md-3" placeholder="不能不填哦" id="bkName" name="bkName" style="display: inline"><span style="color: red;display: none">书名都不填的吗?</span></td>
        </tr>
        <tr>
            <td>作者:</td>
            <td><input type="text" class="form-control col-md-3" placeholder="同上"  id="bkAuthor" name="bkAuthor" style="display: inline"><span style="color: red;display: none">作者也不填吗?</span></td>
        </tr>
        <tr>
            <td>出版社:</td>
            <td><input type="text" class="form-control col-md-3" placeholder="只能是中文呢" id="bkPress" name="bkPress" style="display: inline"><span style="color: red;display: none">为什么不填啊?</span></td>
        </tr>
        <tr>
            <td>价格:</td>
            <td><input type="number" placeholder="不可为负数" class="form-control col-md-3" id="bkPrice" name="bkPrice" style="display: inline"><span style="color: red;display: none">价格不能有负号</span></td>
        </tr>
        <tr>
            <td>是否借出:</td>
            <td>
                <select name="bkStatus" id="bkStatus" class="form-control col-md-3" >
                    <option value="在馆" >在馆</option>
                    <option value="借出" >借出</option>
                </select>
            </td>
        </tr>
        <tr>
            <td>上传封面:</td>
            <td><input type="file" name="bkImage" accept="image/jpeg,image/jpg,image/png" id="add_image">
                <img id="show_img"  style="display: none;width: 200px;height: 200px" alt="暂无" src=""></td>
        </tr>
        <tr>
            <td>
                添加简介:
            </td>
            <td>
                <div style="position:relative;padding-bottom:20px">
                    <textarea  onkeyup="rest_words(this,300,'input_words')" placeholder="请输入书籍简介信息" style="resize: none" maxlength="300" rows="5" cols="10" class="form-control col-md-5" id="bkResume" name="bkResume"></textarea>
                    <span  id="input_words" style="color:#cc24e6;text-align: end ;font-size:14px;position:absolute;height:20px;left:300px;bottom:0;"></span>
                </div>
            </td>
            <script>
                function rest_words(obj,maxlength,id)
                {
                    var num=maxlength-obj.value.length;
                    var leng=id;
                    if(num<0){
                        num=0;
                    }
                    document.getElementById(leng).innerHTML="剩余"+num+"/300"+"字符";
                }
            </script>
        </tr>
        <tr>
            <td><input  type="reset" class="col-sm-5 btn btn-outline-danger"  value="重置"></td>
            <%--    type改为button完美解决问题--%>
            <td><input id="upbook" type="button" class="col-sm-2 btn btn-outline-info"  value="添加书籍"></td>
        </tr>
    </table>
    <script>
        var getUserPhoto = document.getElementById("add_image");
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
</form>
<div id="back_to_top">回到顶部</div>
<script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.6.0/jquery.js"></script>
<script src="https://cdn.bootcdn.net/ajax/libs/popper.js/1.16.1/umd/popper.min.js"></script>
<script src="https://cdn.bootcdn.net/ajax/libs/twitter-bootstrap/4.6.1/js/bootstrap.min.js"></script>
<%--回到顶部--%>
<script src="to-top.js"></script>
<%--js正则表达式验证--%>
<script>
    function verify_form()
    {
        const bkID=document.getElementById("bkID").value;
        const bkPrice=document.getElementById("bkPrice").value;
        const bkPress=document.getElementById("bkPress").value;
        const bkName=document.getElementById("bkName").value;
        const bkAuthor=document.getElementById("bkAuthor").value;
        // //书号验证
        var patterns=/^bk\d{7}?$/;
        // //出版社中文验证
        var reg=/^[\u4e00-\u9fa5]+$/;
        // //非负的浮点数验证
        var reg2=/^\d+(\.\d+)?$/;
        if(patterns.test(bkID)===false){
            // alert("书号输入不合法\n请重新输入");
            document.getElementById("bkID").style.borderColor="#ea0404";
            document.getElementsByTagName("span")[1].style.display='inline-block';
            setTimeout(function (){
                document.getElementsByTagName("span")[1].style.display='none';
                document.getElementById("bkID").style.borderColor="#beb4b4";
            },1500)
            return false;
        }
        if(""===bkName){
            // alert("书名都不填的吗?");
            document.getElementById("bkName").style.borderColor="#ea0404";
            document.getElementsByTagName("span")[2].style.display='inline-block';
            setTimeout(function (){
                document.getElementsByTagName("span")[2].style.display='none';
                document.getElementById("bkName").style.borderColor="#beb4b4";
            },1000)
            return false;
        }
        if(""===bkAuthor){
            // alert("作者也不填吗?");
            document.getElementById("bkAuthor").style.borderColor="#ea0404";
            document.getElementsByTagName("span")[3].style.display='inline-block';
            setTimeout(function (){
                document.getElementsByTagName("span")[3].style.display='none';
                document.getElementById("bkAuthor").style.borderColor="#beb4b4";
            },1500)
            return false;
        }
        if(""===bkPress){
            document.getElementById("bkPress").style.borderColor="#ea0404";
            document.getElementsByTagName("span")[4].style.display='inline-block';
            setTimeout(function (){
                document.getElementsByTagName("span")[4].style.display='none';
                document.getElementById("bkPress").style.borderColor="#beb4b4";
            },1000)
            return false;
        }
        if(reg.test(bkPress)===false){
            // alert("出版社输入必须是中文");
            document.getElementById("bkPress").style.borderColor="#ea0404";
            document.getElementsByTagName("span")[4].innerHTML="出版社必须是中文";
            document.getElementsByTagName("span")[4].style.display='inline-block';
            setTimeout(function (){
                document.getElementsByTagName("span")[4].style.display='none';
                document.getElementById("bkPress").style.borderColor="#beb4b4";
            },1500)
            return false;
        }
        //匹配的是不包含-9的
        if (reg2.test(bkPrice)===false){
            // alert("价格不能有负号");
            document.getElementById("bkPrice").style.borderColor="#ea0404";
            document.getElementsByTagName("span")[5].style.display='inline-block';
            setTimeout(function (){
                document.getElementsByTagName("span")[5].style.display='none';
                document.getElementById("bkPrice").style.borderColor="#beb4b4";
            },1500)
            return false;
        }
        return true;
    }
</script>
<%--发送数据--%>
<script>
    $("#upbook").click(function (){
        // console.log($("#add_image")[0].files[0]);使用经典 DOM 选择器访问第一个选定的文件
        //HTML <form> 元素 — 指定后，FormData 对象将使用每个元素的 name 属性及其提交的值值填充窗体的当前键/值。它还将对文件输入内容进行编码。
        if(verify_form()===true){
            if($("#add_image")[0].files.length===0)
            {
                alert("请添加图片!")
                return;
            }
            //必须加个[0]转换为原生dom对象
            var formdata=new FormData($("#bookform")[0]);
            document.getElementById("bookform").reset();
            $("#show_img")[0].src="";
            document.getElementById("show_img").style.display='none';
            $.ajax(
                {
                    url:"AddBookServlet",
                    type:'POST',
                    data:formdata,
                    cache:false,
                    contentType:false,
                    processData:false,
                    success:function (data){
                        console.log(data);
                        alert(data);
                        $("#bookform")[0].reset();
                        $("#show_img")[0].src="";
                        document.getElementById("show_img").style.display='none';
                        $("#test1").load("add_book.jsp");
                    }
                }
            )
        }
    })
</script>
<%--查询到的读者记录展示--%>
<table class="table table-hover ">
        <thead class="thead-light" >
        <tr>
            <th>书号ID</th>
            <th>书名</th>
            <th>作者</th>
            <th>出版社</th>
            <th>价格</th>
            <th>状态</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
<%--查询的结果集list在servlet中被保存到域中--%>
        <c:if test="${not empty sessionScope.add_book}">
<%--            循环拿到list集合对象--%>
            <c:forEach items="${sessionScope.add_book}" var="Book" varStatus="s">
                <tr>
<%-- .rdID实际上是getrdiD方法--%>
                    <td><strong>${Book.bkID}</strong></td>
                    <td><strong>${Book.bkName}</strong></td>
                    <td><strong>${Book.bkAuthor}</strong></td>
                    <td><strong>${Book.bkPress}</strong></td>
                    <td><strong>${Book.bkPrice}</strong></td>
                    <td><strong>${Book.bkStatus}</strong></td>
                    <td><a href="#">删除选中</a></td>
                </tr>
                </c:forEach>
</c:if>
        </tbody>
    </table>
</body>
</html>
