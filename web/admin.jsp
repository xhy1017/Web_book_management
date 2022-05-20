<%--
  Created by IntelliJ IDEA.
  User: x'h'y
  Date: 2022/4/21
  Time: 17:45
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8"  %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta http-equiv="content-type" content="text/html; charset=utf-8">
  <meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1,user-scalable=no">
  <title >图书管理后台</title>
  <!-- 引入网页图标 -->
    <link href="images/book.ico" rel="icon" type="image/x-icon" >
    <link rel="stylesheet" href="https://cdn.bootcdn.net/ajax/libs/twitter-bootstrap/4.6.1/css/bootstrap.min.css" >
</head>
<body >
<script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.6.0/jquery.js"></script>
<script src="https://cdn.bootcdn.net/ajax/libs/popper.js/1.16.1/umd/popper.min.js" ></script>
<%--貌似换了个CDN加载速度会更快--%>
<script src="https://cdn.bootcdn.net/ajax/libs/twitter-bootstrap/4.6.1/js/bootstrap.min.js"></script>
<%--添加图书jquery代码 有更好的写法了不需要单独写了--%>
<%--<script>--%>
<%--  // $(function()x相当于document.ready(function) DOM树生成完毕之后就会触发事件执行后面的js函数*页面解析的顺序是从上往下解析再进行渲染的--%>
<%--   // 当将js文件在head引入的时候，DOM节点的设置就会出错因为此时DOM还没有加载DOM树还没有形成--%>
<%--    $(function (){--%>
<%--        $("#addbook").click(function (){--%>
<%--            $("#test1").load("add_book.jsp");--%>
<%--        })--%>
<%--    })--%>
<%--</script>--%>
<script>
<%--    纯原生js,e接收事件对象，attr拿到id值--%>
       $(document).click(function (e){
           //拿到ID
           const ID=$(e.target).attr('id');
           //定义一个变量去保存id选择器，避免重复调用id选择器，因为jquery不会缓存元素
           let option=$("#test1");
           switch (ID){
               case "modifybook":
                   option.load("modify_book.jsp");
                   break;
               case "deletebook":
                   option.load("delete_book.jsp");
                   break;
               case "findbook":
                   option.load("search_book.jsp");
                   break;
               case "addbook":
                   option.load("add_book.jsp");
                   break;
               case "modifyreader":
                   option.load("modify_reader.jsp");
                   break;
               case "deletereader":
                   option.load("delete_reader.jsp");
                   break;
               case "findreader":
                   option.load("search_reader.jsp");
                   break;
               case "addreader":
                   option.load("add_reader.jsp");
                   break;
               default:
                   break;
           }
       });
</script>

<%--把txt文件中id为P1的元素值给div1--%>
<%--$("#div1").load("demo_test.txt #p1");--%>

<div class="container-fluid" >
    <div class="row">
        <div class="col-lg-2" style="height:auto;background-color:mediumpurple;" >
            <div class="text-center">
                <a href="javascript:void(0)"  style="font-size:larger;text-decoration:none;color: white;height: 110px;line-height: 60px">欢迎使用后台管理系统</a>
            </div>
            <div id="accordion">
                <div class="card">
                    <div class="card-header">
                        <a class="card-link" data-toggle="collapse" href="#collapseOne">
                            图书管理
                        </a>
                    </div>
                    <div id="collapseOne" class="collapse show" data-parent="#accordion">
                        <div class="card-body ">
                             <a  id="addbook" href="javascript:void(0)" class="text-right" style="text-decoration: none;line-height: 30px; height:40px;font-size: large ">新书入库</a>
                            <br>
                            <a   id="deletebook" href="javascript:void(0)" style="text-decoration: none; height:100px;line-height: 30px;font-size: large">删除图书</a>
                            <br>
                            <a   id="findbook" href="javascript:void(0)" style="text-decoration: none; height:100px;line-height: 30px;font-size: large ">查询图书</a>
                            <br>
                            <a  id="modifybook" href="javascript:void(0)" style="text-decoration: none; height:100px;line-height: 30px;font-size: large">修改图书</a>
                            <br>
                            <a  id="occupied_book" href="javascript:void(0)" style="text-decoration: none; height:100px;line-height: 30px;font-size: large">使用信息</a>
                        </div>
                    </div>
                </div>
                <div class="card">
                    <div class="card-header">
                        <a class="collapsed card-link" data-toggle="collapse" href="#collapseTwo">
                            读者管理
                        </a>
                    </div>
                    <div id="collapseTwo" class="collapse show" data-parent="#accordion">
                        <div class="card-body">
                            <a id="addreader"  class="text-right" href="javascript:void(0)" style="text-decoration: none; height:50px;font-size: large">注册读者</a>
                            <br>
                            <a id="modifyreader" href="javascript:void(0)" style="text-decoration: none; height:100px;font-size: large ">修改读者</a>
                            <br>
                            <a id="deletereader" href="javascript:void(0)" style="text-decoration: none; height:100px;font-size: large ">删除读者</a>
                            <br>
                            <a id="findreader" href="javascript:void(0)" style="text-decoration: none; height:100px;font-size: large ">查询读者</a>
                            <br>
                            <a id="reader_borrow" href="javascript:void(0)" style="text-decoration: none; height:100px;font-size: large ">借阅信息</a>
                        </div>
                    </div>
                </div>
                <div class="card">
                    <div class="card-header">
                        <a class="collapsed card-link" data-toggle="collapse" href="#collapseThree">
                         联系我们
                        </a>
                    </div>
                    <div id="collapseThree" class="collapse show" data-parent="#accordion">
                        <div class="card-body">
                            联系邮箱:<br><a href="javascript:void(0)">1181661076@qq.com</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

<%-- 3存放右侧要展示的页面--%>
        <div class="col-lg-10" style="background-image: url(16.jpeg);height: auto">
            <div class="container-fluid">
                <h4 style="color: mediumpurple">管理员:&nbsp;${sessionScope.msg.rdName}欢迎登录&nbsp;&nbsp;&nbsp;读者类型:${sessionScope.msg.rdTypeName}&nbsp;</h4>
                <span class="h5" style="color: mediumpurple" id="show_time"> </span>
<%--设计成一个button  弹出一个模态框提示用户是否确认提交--%>
    <a href="#">退出登录</a>
            </div>
            <div id="test1" style="display: block">
                <!-- 模态框 淡入淡出 -->
                <div class="modal fade " id="myModal">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <!-- 模态框头部 -->
                            <div class="modal-header">
                                <h5 class="modal-title btn-outline-info">提示信息</h5>
                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                            </div>
                            <!-- 模态框主体 -->
                            <div class="modal-body">
                                <div class="alert alert-success">
                                    <strong>登录成功!&nbsp;&nbsp;欢迎管理员:&nbsp;${sessionScope.msg.rdName}</strong>
                                </div>
<%--                                <h3 class="text-center" style="color: black">登录成功!欢迎使用</h3>--%>
                            </div>

                            <!-- 模态框底部 -->
                            <div class="modal-footer">
                                <button type="button" class="btn btn-danger" data-dismiss="modal">关闭</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    </div>
<script>
    function time() {
        var weeks=["星期天", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"];
        var now = new Date()
        $("#show_time")[0].innerHTML = now.getFullYear() + "/" + (now.getMonth() + 1) + "/" + now.getDate() + "/" + now.getHours() + ":" + now.getMinutes() + ":" + now.getSeconds() + ""+weeks[now.getDay()];
    }
    setInterval(time,1000);
</script>
<script>
    $(function(){
        //自动弹出模态框 登录成功提示
        $("#myModal").modal();
        //1秒后自动消失
        setTimeout(function (){
            $("#myModal").modal('hide');
        },1000)
    })
</script>
</body>
</html>