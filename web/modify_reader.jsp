<%--
  Created by IntelliJ IDEA.
  User: x'h'y
  Date: 2022/4/21
  Time: 17:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <link rel="stylesheet" href="https://cdn.bootcdn.net/ajax/libs/twitter-bootstrap/4.6.1/css/bootstrap.min.css" >
    <link rel="stylesheet" href="to-top.css">
    <title>修改读者信息</title>
</head>
<body>
<script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.6.0/jquery.js"></script>
<script src="https://cdn.bootcdn.net/ajax/libs/popper.js/1.16.1/umd/popper.min.js"></script>
<script src="https://cdn.bootcdn.net/ajax/libs/twitter-bootstrap/4.6.1/js/bootstrap.min.js"></script>
<div>
    <form id="search_reader_form">
        <table class="table-hover">
            <tr>
                <td class="h5">请输入要查询的读者ID:</td>
                <td><input type="text" class="form-control  row-cols-sm-3 " name="rdID"></td>
                <td class="h5">读者类型:</td>
                <td>
                    <select name="rdType" class="form-control ">
                        <option value="1">教师</option>
                        <option value="2">本科生</option>
                        <option value="3">硕士研究生</option>
                        <option value="4">博士研究生</option>
                        <option value="5">高中生</option>
                    </select>
                </td>
                <td class="h5">姓名:</td>
                <td><input type="text" class="form-control row-cols-3" name="rdName"></td>

                <td class="h5">院系:</td>
                <td><input type="text"class="form-control"name="rdDept"></td>
            </tr>
            <tr>
                <td class="h5">已借书数量:</td>
                <td><input type="text"class="form-control" name="rdBorrowQty"></td>
            </tr>
            <tr>
                <td colspan="2"><input id="proverb_reader" type="button"class="form-control btn-outline-info" value="查询"></td>
                <td colspan="3"><input  type="reset"class="form-control btn-outline-danger" value="重置"></td>
            </tr>
        </table>
    </form>
</div>
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
    <c:if test="${not empty list}">
        <%--            循环拿到list集合对象--%>
        <%--     从请求域中拿到list属性--%>
    <c:forEach items="${sessionScope.list}" var="Reader" varStatus="s">
    <tr>
            <%-- .rdID实际上是getrdiD方法--%>
        <td><strong>${Reader.rdID}</strong></td>
        <td>${Reader.rdTypeName}</td>
        <td><strong>${Reader.rdName}</strong></td>
        <td>${Reader.rdDept}</td>
        <td>${Reader.rdQQ}</td>
        <td>${Reader.rdBorrowQty}</td>
        <td><a href="#">删除选中</a></td>
    <tr>
        </c:forEach>
        </c:if>
    </tbody>
</table>


</body>
</html>
