<%--
  Created by IntelliJ IDEA.
  User: x'h'y
  Date: 2022/4/21
  Time: 17:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <link rel="stylesheet" href="to-top.css">
    <link rel="stylesheet" href="https://cdn.bootcdn.net/ajax/libs/twitter-bootstrap/4.6.1/css/bootstrap.min.css" >
    <title>删除读者</title>
</head>
<body>
<%--查询主体--%>
<div>
    <form id="search_reader_form">
        <table class="table-hover">
            <tr>
                <td class="h5">请输入要删除的读者ID:</td>
                <td><input type="text" class="form-control  row-cols-sm-3 " name="rdID"></td>
                <td class="h5">读者类型:</td>
                <td>
                    <select name="rdType" class="form-control ">
                        <option ></option>
                        <option value="1">教师</option>
                        <option value="2">本科生</option>
                        <option value="3">硕士研究生</option>
                        <option value="4">博士研究生</option>
                        <option value="5">高中生</option>
                    </select>
                </td>
                <%--                设置选中项--%>
                <script>
                    <c:if test="${not empty PageBean_reader.vague_query.rdType}">
                    $("select").find("option[value=${sessionScope.PageBean_reader.vague_query.rdType}]").attr("selected",true);
                    </c:if>
                </script>
                <td class="h5">姓名:</td>
                <td><input type="text" class="form-control row-cols-3"  value="${sessionScope.PageBean_reader.vague_query.rdName}" name="rdName"></td>

                <td class="h5">院系:</td>
                <td><input type="text" class="form-control" value="${sessionScope.PageBean_reader.vague_query.rdDept}" name="rdDept"></td>
            </tr>
            <tr>
                <td class="h5">已借书数量:</td>
                <td><input type="text" class="form-control" value="${sessionScope.PageBean_reader.vague_query.rdBorrowQty}" name="rdBorrowQty"></td>
            </tr>
            <tr>
                <td colspan="2"><input id="proverb_reader" type="button" class="form-control btn-outline-info" value="查询"></td>
                <td colspan="3"><input  type="reset" class="form-control btn-outline-danger" value="重置"></td>
            </tr>
        </table>
    </form>
</div>
<%--展示数据--%>
<table class="table table-hover ">
    <thead class="thead-light" >
    <tr>
        <th>
            <label style="margin-bottom:0rem">
                <input type="checkbox" id="select_all" style="width:50px;height:20px">全选
            </label>
        </th>
        <th>读者ID</th>
        <th>读者类型</th>
        <th>姓名</th>
        <th>所属院系</th>
        <th>QQ</th>
        <th class="text-center">已借书数量</th>
        <th>操作</th>
    </tr>
    </thead>
    <tbody>
    <%--查询的结果集list在servlet中被保存到域中--%>
    <c:if test="${not empty PageBean_reader.list}">
        <%--            循环拿到list集合对象--%>
        <%--     从请求域中拿到list属性--%>
    <c:forEach items="${sessionScope.PageBean_reader.list}" var="Reader" varStatus="s">
    <tr>
        <td id="delete">
                <%--平行--%>
            <label style="margin-bottom:0rem">
                <input type="checkbox" style="width:50px;height:20px" name="checked" value="${Reader.rdID}">${S.count}
            </label>
        </td>
            <%-- .rdID实际上是getrdiD方法--%>
        <td><strong>${Reader.rdID}</strong></td>
        <td>${Reader.rdTypeName}</td>
        <td><strong>${Reader.rdName}</strong></td>
        <td>${Reader.rdDept}</td>
        <td>${Reader.rdQQ}</td>
        <td class="text-center">${Reader.rdBorrowQty}</td>
        <td><button id="single_delete" type="button" class=" btn btn-outline-danger">删除选中</button></td>
    <tr>
        </c:forEach>
        </c:if>
    </tbody>
</table>
<%--分页按钮组--%>
<div class="row">
    <div class="col-lg-6">
        <table class="table table-borderless">
            <tr>
                <td style="vertical-align: bottom;">
                    <p class="h6 text-lg-left"><strong>当前第&nbsp;${sessionScope.PageBean_reader.currentPage}&nbsp;页,</strong></p>
                </td>
                <td style="vertical-align: bottom;">
                    <p class="h6 text-lg-right"><strong>每页记录数</strong></p>
                </td>
                <td style="vertical-align: bottom;">
                    <select class="form-control"   id="pageSize" name="pageSize">
                        <%--   数据回显 记录用户选择的每页记录数--%>
                        <option value="5"
                        <%--                                <c:if test="${'5' eq sessionScope.PageBean_reader.pageSize}">--%>
                        <%--                                    selected</c:if> --%>
                        >5/页
                        </option>
                        <option value="10">10/页
                            <%--                                <c:if test="${'10' eq sessionScope.PageBean_reader.pageSize}">selected</c:if> >--%>
                            <%--                            10/页--%>
                        </option>
                        <option value="15">15/页
                            <%--                                <c:if test="${'15' eq sessionScope.PageBean_reader.pageSize}">selected</c:if> >--%>
                            <%--                            15/页--%>
                        </option>
                    </select>
                    <script>
                        <c:if test="${not empty sessionScope.PageBean_reader.pageSize}">
                        $("select:last").find("option[value=${sessionScope.PageBean_reader.pageSize}]").attr("selected",true);
                        </c:if>
                    </script>
                </td>
                <td style="vertical-align: bottom;">
                    <p class="h6 text-lg-right"><strong>总${sessionScope.PageBean_reader.totalPages} 页,总${sessionScope.PageBean_reader.totalRecord}条记录</strong></p>
                </td>
                <td><button class="btn btn-outline-danger" id="multiple_delete">批量删除</button></td>
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
<%--回到顶部js文件--%>
<script src="to-top.js"></script>
<%--查询按钮--%>
<script>
    $(function (){
        $("#proverb_reader").click(function (){
            //获取pageSize值
            let pagesize=$("#pageSize").val();
            //拼接一下
            $.post("Find_readerServlet",$("#search_reader_form").serialize()+"&pageSize="+pagesize,function (data,status){
                console.log(status);
                console.log($("#search_reader_form").serialize()+"&pageSize="+pagesize)
                alert(data);
                $("#test1").load("delete_reader.jsp");
            },"html");
        });
    })
</script>
<%--上一页下一页按钮组--%>
<script>
    $(function (){
        <c:if test="${not empty sessionScope.PageBean_reader}">
        let curpage =${sessionScope.PageBean_reader.currentPage};
        </c:if>
        $("#FirstPage").click(function (){
            //考虑到有没有记录，0代表没有结果
            if(curpage===1||curpage===0){
                alert("已经是首页了呢，哥哥");
                return;//函数不继续执行了，不会继续异步请求，下面同理
            }
            curpage=1;
            $.post("Find_readerServlet",$("#search_reader_form").serialize()+"&currentPage="+curpage,function (data,status){
                console.log("点了首页");
                console.log(status);
                $("#test1").load("delete_reader.jsp");
            },"html")
        })
        $("#LastPage").click(function (){
            if(curpage===${sessionScope.PageBean_reader.totalPages}){
                alert("已经是最后一页了呢，姐姐");
                return;
            }
            curpage=${sessionScope.PageBean_reader.totalPages}
                $.post("Find_readerServlet",$("#search_reader_form").serialize()+"&currentPage="+curpage,function (data,status){
                    console.log("点了尾页");
                    console.log(status);
                    $("#test1").load("delete_reader.jsp");
                },"html")
        })
        $("#PreviousPage").click(function (){
            if(curpage===1||curpage===0){
                alert("已经是第一页了");
                return;
            }else {
                curpage-=1;
            }
            $.post("Find_readerServlet",$("#search_reader_form").serialize()+"&currentPage="+curpage,function (data,status){
                console.log("点了上一页");
                console.log(status);
                $("#test1").load("delete_reader.jsp");
            },"html")
        })

        $("#SubsequentPage").click(function (){
            if(curpage===${sessionScope.PageBean_reader.totalPages}){
                alert("已经是尾页了");
                return;
            }
            else {
                curpage+=1;
            }
            // {"currentPage":curpage};
            $.post("Find_readerServlet",$("#search_reader_form").serialize()+"&currentPage="+curpage,function (data,status){
                console.log("点了下一页");
                console.log(status);
                $("#test1").load("delete_reader.jsp");
            },"html")
        })
    })
</script>
<%--判断是否满足删除条件--%>
<script>
    $(document).click(function (e){
        if($(e.target).attr('id')==='single_delete'){
            var str=""
            let option=$("#delete input:checked");
            if(option.length===0){
                alert("请先勾选再进行操作!")
                return false;
            }
            if(option.length>1){
                alert("哥哥，只能选中一项删除哦!");
                return false;
            }
            if ($(e.target).parents('tr').children('td').eq(6).text()!=='0'){
                alert("该读者不可删除哦,他借了书还未归还");
                return false;
            }
            else {
                if(confirm("确认删除吗?")){
                    str+="checked="+option.value+"&";
                    str=str.substring(0,str.length-1);
                    console.log(str)
                    $.post("Remove_reader_Servlet",str,function (data,status){
                        alert("删除成功");
                        console.log(data);
                        console.log(status);
                        $.post("Find_readerServlet",function (data,status){
                            console.log(data)
                            console.log(status)
                            $("#test1").load("delete_reader.jsp");
                        },'html')
                    },'html')
                }
                return false;
            }
        }
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
<script>
    $("#multiple_delete").click(function (){
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
                $.post("Remove_reader_Servlet",str,function (data,status){
                    alert("删除成功");
                    console.log(data);
                    console.log(status);
                    $.post("Find_readerServlet",function (data,status){
                        console.log(data)
                        console.log(status)
                        $("#test1").load("delete_reader.jsp");
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
                $.post("Remove_reader_Servlet",str,function (data,status){
                    alert("删除成功");
                    console.log(data);
                    console.log(status);
                    $.post("Find_readerServlet",function (data,status){
                        console.log(data)
                        console.log(status)
                        $("#test1").load("delete_reader.jsp");
                    },'html')
                },'html')
            }
            return false;
        }else {
            alert("请至少选择2项进行操作")
            return false;
        }
    })
</script>
<%--引入jquery.js bootstrap.js/css popper.js--%>
<script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.6.0/jquery.js"></script>
<script src="https://cdn.bootcdn.net/ajax/libs/popper.js/1.16.1/umd/popper.min.js"></script>
<script src="https://cdn.bootcdn.net/ajax/libs/twitter-bootstrap/4.6.1/js/bootstrap.min.js"></script>

</body>
</html>
