<%--
  Created by IntelliJ IDEA.
  User: x'h'y
  Date: 2022/3/8
  Time: 17:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
  <head>
    <title>图书管理系统</title>
  </head>
  <body>
<%-- servlet设置yu保存登录信息--%>
<p class="h5">还有bug没解决呢</p>
   亲爱的<%=session.getAttribute("msg").toString()%>欢迎登录
  </body>
</html>
