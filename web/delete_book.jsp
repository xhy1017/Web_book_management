<%--
  Created by IntelliJ IDEA.
  User: x'h'y
  Date: 2022/4/21
  Time: 17:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="en">
<head>
    <link rel="stylesheet" href="to-top.css">
    <link rel="stylesheet" href="https://cdn.bootcdn.net/ajax/libs/twitter-bootstrap/4.6.1/css/bootstrap.min.css" >
    <title>删除图书</title>
</head>
<body>
<script src="to-top.js"></script>
<script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.6.0/jquery.js"></script>
<script src="https://cdn.bootcdn.net/ajax/libs/popper.js/1.16.1/umd/popper.min.js"></script>
<script src="https://cdn.bootcdn.net/ajax/libs/twitter-bootstrap/4.6.1/js/bootstrap.min.js"></script>
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
                $("#test1").load("delete_book.jsp");
            },"html");
        });
    })
</script>
<div>
    <form id="search_book_form" >
        <table class="table-hover" style="margin-bottom: auto">
            <tr>
                <td class="h5">请输入要删除的书号ID:</td>
                <td><input type="text" class="form-control  row-sm-3 " name="bkID" value="${sessionScope.PageBean_book.vague_query.bkID}"></td>
                <td class="h5">书名:</td>
                <td><input type="text" class="form-control" name="bkName" value="${sessionScope.PageBean_book.vague_query.bkName}"></td>
                <td class="h5">作者:</td>
                <td> <input type="text" class="form-control" name="bkAuthor" value="${sessionScope.PageBean_book.vague_query.bkAuthor}"></td>
                <td class="h5">状态</td>
                <td>
                    <select name="bkStatus" class="form-control">
                        <option value="在馆">在馆</option>
                        <option value="借出">借出</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td colspan="2"><input type="button" id="proverb_book" class="form-control btn-outline-info" value="查询"></td>
                <td colspan="2"><input type="reset"  class="form-control btn-outline-danger" value="重置"></td>
            </tr>
        </table>
    </form>
</div>
<script>
    $(function (){
        <c:if test="${not empty sessionScope.PageBean_book}">
        let curpage =${sessionScope.PageBean_book.currentPage};
        </c:if>
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
                $("#test1").load("delete_book.jsp");
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
                    $("#test1").load("delete_book.jsp");
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
                $("#test1").load("delete_book.jsp");
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
                $("#test1").load("delete_book.jsp");
            },"html")
        })
    })
</script>
<script>
    $("").on('show.bs.modal',function (){

    })
</script>
<script>
    //判断全选
    $("#select_all").click(function (){
        var checkedStatus=$(this).prop('checked')
        //设置下面的复选框状态
        let option=$("#delete input")
        option.prop('checked',checkedStatus)
        option.click(function (){
            //复选框个数
            const all = option.length;
            //选中的个数
            const checked = $("#delete input:checked").length;
            $("#select_all").prop('checked',all===checked);
        })
    })
</script>
<form>
    <table class="table table-hover " id="book_table">
        <thead class="thead-light" >
        <tr>
            <th>
                <label style="margin-bottom:0rem">
                    <input type="checkbox" id="select_all" style="width:50px;height:20px">全选
                </label>
            </th>
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
                    <td id="delete">
<%--平行--%>
                        <label style="margin-bottom:0rem">
                            <input type="checkbox" style="width:50px;height:20px" name="checked" value="${Book.bkID}">${S.count}
                        </label>
                    </td>
                    <td><strong>${Book.bkID}</strong></td>
                    <td style="color: darkorange">${Book.bkName}</td>
                    <td><strong>${Book.bkAuthor}</strong></td>
                    <td><strong>${Book.bkPress}</strong></td>
                    <td><strong>${Book.bkPrice}</strong></td>
                    <td  style="color:dodgerblue">${Book.bkStatus}</td>
                    <td><button type="button" class=" btn btn-outline-danger">删除选中</button></td>
                </tr>
            </c:forEach>
        </c:if>
        </tbody>
    </table>
</form>
<div class="row">
    <div class="col-lg-6">
        <table class="table table-borderless">
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
                <td><button class="btn btn-outline-danger" id="mutiple_delete">批量删除</button></td>
            </tr>
        </table>

    </div>
    <div class="col-lg-6">
        <div id="back_to_top">返回顶部</div>
        <nav aria-label="Page navigation example">
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
    $("#mutiple_delete").click(function (){
        let option=$("#delete input");
        let option2=$("#delete input:checked");
        var str="";
        //判断是否全选
        if($("#select_all").prop("checked"))
        {
            if(confirm("你真的要删除吗?\n该数据不可恢复哦"))
            {
                for (let i = 0; i <option.length ; i++) {
                    str+="checked="+option[i].value+"&";
                }
                //去掉末尾的&
                str=str.substring(0, str.length-1);
                console.log(str);
                $.post("Remove_book_Servlet",str,function (data,status){
                    alert("删除成功");
                     console.log(data);
                     console.log(status);
                     $.post("Paged_Servlet",function (data,status){
                         console.log(data)
                         console.log(status)
                         $("#test1").load("delete_book.jsp");
                     },'html')
                },'html')
            }
            return false;
        }
        //不是全选状态
        if(option2.length>0){
            if(confirm("还是决定要删除了吗\n帅的人已经醒来~~~"))
            {
                for (let i = 0; i < option2.length; i++) {
                    str+="checked="+option2[i].value+"&";
                }
                str=str.substring(0,str.length-1);
                console.log(str);
                $.post("Remove_book_Servlet",str,function (data,status){
                    alert("删除成功");
                    console.log(data);
                    console.log(status);
                    $.post("Paged_Servlet",function (data,status){
                        console.log(data)
                        console.log(status)
                        $("#test1").load("delete_book.jsp");
                    },'html')
                },'html')
            }
            return false;
        }else {
            alert("请至少选择一项进行操作")
            return false;
        }

    })
</script>
</body>
</html>
