<%--
  Created by IntelliJ IDEA.
  User: x'h'y
  Date: 2022/4/12
  Time: 20:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <link rel="stylesheet" href="https://cdn.bootcdn.net/ajax/libs/twitter-bootstrap/4.6.1/css/bootstrap.min.css" >
    <link rel="stylesheet" href="to-top.css">
    <title>查询读者</title>
</head>
<body>
<script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.6.0/jquery.js"></script>
<script src="https://cdn.bootcdn.net/ajax/libs/popper.js/1.16.1/umd/popper.min.js"></script>
<script src="https://cdn.bootcdn.net/ajax/libs/twitter-bootstrap/4.6.1/js/bootstrap.min.js"></script>
<div>
<%--   <form action="${pageContext.request.contextPath}/Find_bookServlet" method="post">--%>
    <form id="search_book_form" >
        <table class="table-hover" style="margin-bottom: auto">
            <tr>
                <td class="h5">请输入要查询的书号ID:</td>
<%--                暂时没做模糊查询--%>
                <td><input type="text" class="form-control  row-sm-3 " id="bkID" name="bkID" ></td>
                <td class="h5">书名:</td>
                <td><input type="text" class="form-control" name="bkName" value="${sessionScope.PageBean_book.vague_query.bkName}"></td>
                <td class="h5">作者:</td>
                <td> <input type="text" class="form-control" name="bkAuthor" value="${sessionScope.PageBean_book.vague_query.bkAuthor}"></td>
                <td class="h5">状态</td>
                <td>
                    <select name="bkStatus" class="form-control">
                        <option></option>
                        <option value="在馆">在馆</option>
                        <option value="借出">借出</option>
                    </select>
                </td>
                <%--                设置选中项--%>
                <script>
                    <%--                  特殊对待  --%>
                    <c:if test="${not empty PageBean_book.vague_query.bkStatus}">
                    $("select:first").find("option[value=${sessionScope.PageBean_book.vague_query.bkStatus}]").attr("selected",true);
                    </c:if>
                </script>

            </tr>
            <tr>
                <td colspan="2"><input type="button" id="proverb_book" class="form-control btn-outline-info" value="查询"></td>
                <td colspan="2"><input type="reset"  class="form-control btn-outline-danger" value="重置"></td>
            </tr>
        </table>
    </form>
</div>
<%--查询到的读者记录展示--%>
<table class="table table-hover " id="book_table">
    <thead class="thead-light" >
    <tr>
        <th>编号</th>
        <th class="text-center">封面</th>
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
    <c:if test="${not empty sessionScope.PageBean_book.list}">
        <c:forEach items="${sessionScope.PageBean_book.list}" var="Book" varStatus="S">
            <tr>
                <td>
                    <label style="margin-bottom:0rem">
                        ${S.count}
                    </label>
                </td>
                <td><img src="${Book.bkURL}" style="width:120px;height: 150px " alt=""></td>
                <td style="vertical-align: middle"><strong>${Book.bkID}</strong></td>
                <td style="color: darkorange;vertical-align: middle">${Book.bkName}</td>
                <td style="vertical-align: middle"><strong>${Book.bkAuthor}</strong></td>
                <td style="vertical-align: middle"><strong>${Book.bkPress}</strong></td>
                <td style="vertical-align: middle"><strong>${Book.bkPrice}</strong></td>
                <td  style="color:dodgerblue;vertical-align: middle">${Book.bkStatus}</td>
                <td style="vertical-align: middle"><button class="btn btn-info">查看简介</button></td>
            </tr>
        </c:forEach>
    </c:if>
    </tbody>
</table>
<div class="row">
    <div class="col-lg-6">
        <table class="table-borderless">
            <tr>
                <td style="vertical-align: bottom;">
                    <p class="h6 text-lg-left"><strong>当前第&nbsp;${sessionScope.PageBean_book.currentPage}&nbsp;页,</strong></p>
                </td>
                <td style="vertical-align: bottom;">
                    <p class="h6 text-lg-right"><strong>每页记录数</strong></p>
                </td>
                <td style="vertical-align: bottom;">
                <select class="form-control"   id="pageSize" name="pageSize">
<%--   数据回显 记录用户选择的每页记录数--%>
                    <option value="5"
                            <c:if test="${'5' eq sessionScope.PageBean_book.pageSize}">
                        selected
                    </c:if> >5/页
                    </option>
                    <option value="10"
                    <c:if test="${'10' eq sessionScope.PageBean_book.pageSize}">selected</c:if> >
                        10/页
                    </option>
                    <option value="15" <c:if test="${'15' eq sessionScope.PageBean_book.pageSize}">selected</c:if> >
                        15/页
                    </option>
                </select>
                </td>
                <td style="vertical-align: bottom;">
                    <p class="h6 text-lg-right"><strong>总${sessionScope.PageBean_book.totalPages} 页,总${sessionScope.PageBean_book.totalRecord}条记录</strong></p>
                </td>
            </tr>
        </table>

    </div>
    <div class="col-lg-6">
        <div id="back_to_top">返回顶部</div>
        <nav aria-label="Page navigation example">
<%--  居中对齐--%>
            <ul class="pagination pagination-lg justify-content-center">
                <li class="page-item"><a id="FirstPage" class="page-link btn-outline-primary" href="javascript:void(0)">首页</a></li>
                <li class="page-item"><a  id="PreviousPage" class="page-link btn-outline-primary" href="javascript:void(0)">上一页</a></li>
                <li class="page-item"><a id="SubsequentPage" class="page-link btn-outline-primary" href="javascript:void(0)">下一页</a></li>
                <li class="page-item"><a  id="LastPage" class="page-link btn-outline-primary" href="javascript:void(0)">尾页</a></li>
            </ul>
        </nav>
    </div>
</div>
<script>
    $(function (){
        $("#proverb_book").click(function (){
            //获取pageSize值
            let pagesize=$("#pageSize").val();
            //拼接一下
            $.post("Paged_Servlet",$("#search_book_form").serialize()+"&pageSize="+pagesize,function (data,status){
                console.log(status);
                console.log($("#search_book_form").serialize()+"&pageSize="+pagesize)
                alert(data);
                $("#test1").load("search_book.jsp");
            },"html");
        });
    })
</script>
<%--上一页下一页--%>
<script>
    $(function (){
        <c:if test="${not empty sessionScope.PageBean_book}">
        let curpage =${sessionScope.PageBean_book.currentPage};
        $("#FirstPage").click(function (){
            //考虑到有没有记录，0代表没有结果
            if(curpage===1||curpage===0){
                alert("已经是首页了呢，哥哥");
                return;//函数不继续执行了，不会继续异步请求，下面同理
            }
            curpage=1;
            $.post("Paged_Servlet",$("#search_book_form").serialize()+"&currentPage="+curpage,function (data,status){
                console.log("点了首页");
                console.log(status);
                $("#test1").load("search_book.jsp");
            },"html")
        })
        $("#LastPage").click(function (){
            if(curpage===${sessionScope.PageBean_book.totalPages}){
                alert("已经是最后一页了呢，姐姐");
                return;
            }
            curpage=${sessionScope.PageBean_book.totalPages}
                $.post("Paged_Servlet",$("#search_book_form").serialize()+"&currentPage="+curpage,function (data,status){
                    console.log("点了尾页");
                    console.log(status);
                    $("#test1").load("search_book.jsp");
                },"html")
        })
        $("#PreviousPage").click(function (){
            if(curpage===1||curpage===0){
                alert("已经是第一页了");
                return;
            }else {
                curpage-=1;
            }
            $.post("Paged_Servlet",$("#search_book_form").serialize()+"&currentPage="+curpage,function (data,status){
                console.log("点了上一页");
                console.log(status);
                $("#test1").load("search_book.jsp");
            },"html")
        })
        $("#SubsequentPage").click(function (){
            if(curpage===${sessionScope.PageBean_book.totalPages}){
                alert("已经是尾页了");
                return;
            }
            else {
                curpage+=1;
            }
            // {"currentPage":curpage};
            $.post("Paged_Servlet",$("#search_book_form").serialize()+"&currentPage="+curpage,function (data,status){
                console.log("点了下一页");
                console.log(status);
                $("#test1").load("search_book.jsp");
            },"html")
        })
        </c:if>
    })
</script>
<%--以外部引入方式返回顶部--%>
<script src="to-top.js"></script>
</body>
</html>
