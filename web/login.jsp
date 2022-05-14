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
<%-- 访问的是out目录下的book.ico文件--%>
    <link href="images/book.ico" rel="icon" type="image/x-icon" >
</head>
<body >
<div id="demo" class="carousel slide " data-ride="carousel" data-interval="2000">
    <!-- 指示符 -->
    <ul class="carousel-indicators">
        <li data-target="#demo" data-slide-to="0" class="active"></li>
        <li data-target="#demo" data-slide-to="1"></li>
        <li data-target="#demo" data-slide-to="2"></li>
        <li data-target="#demo" data-slide-to="3"></li>
    </ul>
<%--    轮播图片--%>
    <div class="carousel-inner">
        <div class="carousel-item active">
            <img  class="img-fluid" src="test.jpg" style="width: 100%;height:500px" alt="">
            <div class="carousel-caption">
                <h3>最好的友谊，是各自忙碌又彼此惦念</h3>
                <p>与光同行</p>
            </div>
        </div>
        <div class="carousel-item ">
            <img  class="img-fluid" src="1.jpg"  style="width: 100%;height: 500px" alt="">
            <div class="carousel-caption">
                <h3>少年不惧岁月长,彼方尚有荣光在</h3>
                <p>Less interests. More interest</p>
            </div>
        </div>
        <div class="carousel-item ">
            <img  class="img-fluid" style="width:100%;height: 500px" src="http://prev.yangtzeu.edu.cn/images/topbannercj.jpg" alt="">
            <div class="carousel-caption">
                <h3>与子同袍 岂曰无衣</h3>
                <p>一切都会好的</p>
            </div>
        </div>
        <div class="carousel-item " >
            <img class="img-fluid " style="width: 100%;height: 500px" src="https://www.ujs.edu.cn/fengmian/20220415-415.jpg" alt="">
            <div class="carousel-caption">
                <h3>4.15 国家安全 人人有责</h3>
                <p></p>
            </div>
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
<div class="container-fluid">
    <%--form必须添加renturn 要不然虽然提示不对,但还是会提交表单--%>
    <div class="row" >
        <div class="col-lg-6" style="padding-left: 0;padding-right: 0">
            <img src="test.jpg" alt="" style="width: 100%;height: 400px" title="生活原本沉闷,但跑起来就有风">
        </div>
   <div class="col-lg-6" style="background-image: url(8.jpg)">
   <form  onsubmit="return verify_form()" action="Login"  method="post" enctype="application/x-www-form-urlencoded">
       <table class="table table-sm table-borderless" >
           <tr>
               <th class="text-center h5 " style="size:20px" colspan="2"><strong>用户信息</strong></th>
           </tr>
           <tr >
               <td class="text-right h5" style="color: white" >学号:</td>
               <td><input type="text" class="form-control col-md-6 offset-2" placeholder="字母rd开头且数字长度为7"  id="rdID" name="rdID"></td>
           </tr>
           <tr>
               <td class="text-right h5" style="color:white ">密码:</td>
               <td><input type="password" class="form-control col-md-6 offset-2" placeholder="请输入密码嘿嘿嘿" id="rdpassword" name="rdpassword"></td>
           </tr>
           <tr>
               <td><input  type="reset"   class="col-sm-5 offset-10 btn btn-outline-danger"   value="重置"></td>
               <%--            可以不写onclick事件--%>
               <td><input type="submit" class="col-sm-2 offset-3 btn btn-outline-success "  value="登录"></td>
           </tr>
       </table>
   </form>
       <c:if test="${not empty errormsg}">
           <div id="info_is_succeed" class="alert-danger text-center" style="color: red;font-size:20px " >
               <div> ${errormsg}</div>
               <script>
                   //2秒后自动消失
                   setTimeout(function (){
                       $("#info_is_succeed").attr('style','display:none');
                   },2000)
               </script>
           </div>
       </c:if>
   </div>
    <%--    后端传回的提示错误信息显示--%>

</div>
</div>
<div class="container-fluid" style="padding-right: 0;padding-left: 0">
        <div  style="width:100%;padding-left: 0;padding-right: 0" class="container-fluid">
            <img  style="width:100%;display: block" src="images/img_2.png" alt="">
        </div>

        <br>
        <p class="h6 text-center">联系我们:&nbsp;&nbsp;&nbsp;&nbsp;湖北省荆州市南环路1号 邮编:434023 电话:0716-8060454（办公室）   Copyright© Yangtze University Library All Rights   Reserved</p>
    </div>

<%--可以考虑用js写一个表单验证--%>
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
<script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.6.0/jquery.js"></script>
<script src="https://cdn.bootcdn.net/ajax/libs/popper.js/1.16.1/umd/popper.min.js" ></script>
<script src="https://cdn.bootcdn.net/ajax/libs/twitter-bootstrap/4.6.1/js/bootstrap.min.js"></script>



</body>
</html>
