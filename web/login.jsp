<%--
  Created by IntelliJ IDEA.
  User: x'h'y
  Date: 2022/4/9
  Time: 17:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <link rel="stylesheet" href="https://cdn.bootcdn.net/ajax/libs/twitter-bootstrap/4.6.1/css/bootstrap.min.css" >
    <title>用户登录</title>
<%--    访问的是out目录下是book.ico文件--%>
    <link href="images/book.ico" rel="icon" type="image/x-icon" >
</head>
<body>
<script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.6.0/jquery.js"></script>
<script src="https://cdn.bootcdn.net/ajax/libs/popper.js/1.16.1/umd/popper.min.js" ></script>
<script src="https://cdn.bootcdn.net/ajax/libs/twitter-bootstrap/4.6.1/js/bootstrap.min.js"></script>
<div id="demo" class="carousel slide" data-ride="carousel">
    <!-- 轮播图片 -->

    <div class="carousel-inner">
        <div class="carousel-item active" >
            <img  class="img-fluid"  width="100% " src="http://prev.yangtzeu.edu.cn/images/topbannercj.jpg" alt="">
        </div>
        <div class="carousel-item " >
            <img class="img-fluid " style="width: 100%" src="https://www.ujs.edu.cn/fengmian/20220415-415.jpg" alt="">

        </div>
    </div>

    <!-- 左右切换按钮 -->
    <a class="carousel-control-prev" href="#demo" data-slide="prev">
        <span  class="carousel-control-prev-icon" style="size:auto"></span>
    </a>
    <a class="carousel-control-next" href="#demo" data-slide="next">
        <span class="carousel-control-next-icon" style="size: auto"></span>
    </a>

</div>
<%--可以考虑用js写一个表单验证--%>
<div class="container-fluid">
    <script>
//js正则表达式对用户名不能有中文验证 --%>
        function verify_form() {
            //定义正则表达匹配rd开头7位数字，且仅匹配0或一次
            const pattern = /^rd\d{7}?$/;
            //定义正则表达式匹配是否有中文
            const reg = /[\u4e00-\u9fa5]/;
            const rdid = document.getElementById("rdID").value;
            const pwd = document.getElementById("rdpassword").value;
            if ("" === rdid) {
                alert("请输入用户名");
                return false;
            }
            //匹配是否有中文
            if (reg.test(rdid)===true) {
                alert("用户名不能有中文");
                return false;
            }
            //匹配是否开头rd7位数字，不是则弹出，这里是不匹配弹出,
            if (pattern.test(rdid)===false) {
                alert("用户名输入不合法");
                return false;
            }
            else if ("" === pwd) {
                alert("密码不能为空!");
                return false;
            }
            return true;
        }
    </script>
<%--form必须添加renturn 要不然虽然提示不对,但还是会提交表单--%>
<form  onsubmit="return verify_form()" action="${pageContext.request.contextPath}/Login"  method="post" enctype="application/x-www-form-urlencoded">
    <table class="table table-sm table-hover" >
        <tr>
            <th class="text-center h5 " style="size:20px" colspan="2"><strong>用户信息</strong></th>
        </tr>
        <tr >
            <td class="text-right h5" >学号:</td>
            <td><input type="text" class="form-control col-md-3 offset-2" placeholder="字母rd开头且数字长度为7"  id="rdID" name="rdID"></td>
        </tr>
            <tr>
            <td class="text-right h5">密码:</td>
            <td><input type="password" class="form-control col-md-3 offset-2" placeholder="请输入密码嘿嘿嘿" id="rdpassword" name="rdpassword"></td>
        </tr>
        <tr>
            <td><input  type="reset"   class="col-sm-5 offset-10 btn btn-outline-danger"   value="重置"></td>
<%--            可以不写onclick事件--%>
            <td><input type="submit" class="col-sm-2 offset-3 btn btn-outline-success "  value="登录"></td>
        </tr>
    </table>
</form>
<%--    后端传回的提示错误信息显示--%>
    <c:if test="${not empty errormsg}">
   <div id="info_is_succeed" class="alert-danger text-center" style="color: red;font-size:20px " >
           <div> ${errormsg}</div>
            <script>
                //2秒后自动消失
                setTimeout(function (){
                    $("#info_is_succeed").attr('style','display:none');
                },2000)
            </script>
        </c:if>
</div>

<div class="container-fluid">
<table class="text-right">
<tr>
    <td>
<%--     text-decoration:none   不显示下划线--%>
        <a style="text-decoration: none" class="text-right " href="#">每周推荐&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>
    </td>
    <td>
       <a style="text-decoration: none" class="text-right" href="#">到馆新书&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>
    </td>
    <td class="offset-lg-7">
       <a style="text-decoration: none" class="text-right" href="#">&nbsp;&nbsp;&nbsp;&nbsp;热门新书</a>
    </td>
</tr>
</table>
    <br>
    <div  style="width:100%" class="container-fluid">
        <img  style="width:100%;display: block" src="images/img_2.png" alt="">
    </div>

    <br>
    <p class="h6 text-center">联系我们:&nbsp;&nbsp;&nbsp;&nbsp;湖北省荆州市南环路1号 邮编:434023 电话:0716-8060454（办公室）   Copyright© Yangtze University Library All Rights   Reserved</p>
</div>

</body>
</html>
