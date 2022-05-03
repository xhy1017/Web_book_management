<%--
  Created by IntelliJ IDEA.
  User: x'h'y
  Date: 2022/4/12
  Time: 20:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8"  %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
    <link rel="stylesheet" href="https://cdn.bootcdn.net/ajax/libs/twitter-bootstrap/4.6.1/css/bootstrap.min.css" >
    <title>添加读者</title>
<%--    也可以不用每次写一个jsp直接jsp嵌套表单--%>
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
        { if(valid_reader_form()===true){
            //   #一定别忘了要不然序列化不成功
            $.post("AddReaderServlet",$("#readerform").serialize(),function (data,status){
                console.log(data);
                alert(data);//弹框提示
                console.log(status);//成功是200
                //添加成功之后重新异步加载一下div元素内容，就可以拿到session中用户添加的值
                $("#test1").load("add_reader.jsp");
            },"html");
        }
    });
    })
</script>
<form onsubmit="return valid_reader_form()" id="readerform" enctype="application/x-www-form-urlencoded">
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
            <td><input type="text"class="form-control col-md-3"placeholder="必须是中文" id="rdName" name="rdName"></td>
        </tr>
        <tr>
            <td>所属院系:</td>
            <td><input type="text" class="form-control col-md-3" placeholder="同上" id="rdDept" name="rdDept"></td>
        </tr>
        <tr>
        <td>QQ:</td>
        <td><input type="number"class="form-control col-md-3" placeholder="不要不填哦"  name="rdQQ"></td>
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
     <c:if test="${not empty reader_list}">
         <%--            循环拿到list集合对象--%>
<%--     从session域中拿到reader_list属性--%>
     <c:forEach items="${sessionScope.reader_list}" var="reader" varStatus="s">
     <tr>
             <%-- .rdID实际上是getrdiD方法--%>
         <td>${reader.rdID}</td>
         <td>${reader.rdType}</td>
         <td>${reader.rdName}</td>
         <td>${reader.rdDept}</td>
         <td>${reader.rdQQ}</td>
         <td>${reader.rdBorrowQty}</td>
         <td><a href="#">删除选中</a></td>
     <tr>
     </c:forEach>

     </c:if>

     </tbody>
</table>
</body>
</html>
