<%--
  Created by IntelliJ IDEA.
  User: x'h'y
  Date: 2022/4/11
  Time: 21:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%--引入核心标签库--%>
<%--导入standard.jar包才是关键--%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <link rel="stylesheet" href="to-top.css">
    <link rel="stylesheet" href="https://cdn.bootcdn.net/ajax/libs/twitter-bootstrap/4.6.1/css/bootstrap.min.css" >
    <title>查找读者</title>
</head>
<body>
<%--搜索框--%>
<div>
    <form id="search_reader_form">
        <table class="table-hover">
            <tr>
                <td class="h5">请输入要查询的读者ID:</td>
                <td><input type="text" class="form-control  row-cols-sm-3 " name="rdID"></td>
                <td class="h5">读者类型:</td>
                <td>
                    <select name="rdType" class="form-control ">
                    <option></option>
                        <option value="1">教师</option>
                    <option value="2">本科生</option>
                    <option value="3">硕士研究生</option>
                    <option value="4">博士研究生</option>
                    <option value="5">高中生</option>
                    </select>
                </td>
<%--                设置选中项--%>
                <script>
<%--                  特殊对待  --%>
                    <c:if test="${not empty PageBean_reader.vague_query.rdType}">
                    $("select:first").find("option[value=${sessionScope.PageBean_reader.vague_query.rdType}]").attr("selected",true);
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
<table class="table table-hover table-borderless ">
    <thead class="thead-light" >
    <tr>
        <th>编号</th>
        <th>用户头像</th>
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
    <%--@elvariable id="PageBean_reader" type="entity.PageBean"--%>
    <c:if test="${not empty PageBean_reader.list}">
        <%--            循环拿到list集合对象--%>
        <%--     从请求域中拿到list属性--%>
    <c:forEach items="${sessionScope.PageBean_reader.list}" var="Reader" varStatus="S">
    <tr>
        <td>
            <label style="margin-bottom:0rem">
                    ${S.count}
            </label>
        </td>
        <style>
            img{
                transition: all 0.5s; /*transition:过度属性*/
                cursor: pointer;  /*当鼠标进入图片的时候，鼠标的样式变为手型 */
            }
            img:hover{
                transform: scale(1.2); /*transform:变形属性，scale：缩放1.1倍 */
            }
        </style>
        <td><img src="${Reader.user_Image_URL}" style="width:100px;height: 100px;border-radius: 50% " alt=""></td>
            <%-- .rdID实际上是getrdiD方法--%>
        <td style="vertical-align: middle"><strong>${Reader.rdID}</strong></td>
        <td style="vertical-align: middle"><strong>${Reader.rdTypeName}</strong></td>
        <td style="vertical-align: middle;color: dodgerblue"><strong>${Reader.rdName}</strong></td>
        <td style="vertical-align: middle"><strong>${Reader.rdDept}</strong></td>
        <td style="vertical-align: middle"><strong>${Reader.rdQQ}</strong></td>
        <td style="vertical-align: middle" class="text-center"><strong>${Reader.rdBorrowQty}</strong></td>
        <td style="vertical-align: middle"><button type="button" id="show_pwd" class="btn btn-info">查看密码</button></td>
    <tr>
        </c:forEach>
        </c:if>
    </tbody>
</table>
<%--分页组件--%>
<div class="row">
    <div class="col-lg-6">
        <table class="table-borderless">
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
                        <option value="5">5/页
<%--                           原来老方法判断     <c:if test="${'5' eq sessionScope.PageBean_reader.pageSize}">--%>
<%--                                    selected</c:if> --%>

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
<%--                    有了更好的方法保持分页大小不变--%>
                    <script>
                        <c:if test="${not empty PageBean_reader.vague_query.rdType}">
                        $("select:last").find("option[value=${sessionScope.PageBean_reader.pageSize}]").attr("selected",true);
                        </c:if>
                    </script>
                </td>
                <td style="vertical-align: bottom;">
                    <p class="h6 text-lg-right"><strong>总${sessionScope.PageBean_reader.totalPages} 页,总${sessionScope.PageBean_reader.totalRecord}条记录</strong></p>
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
  $(document).click(function (e){
      if($(e.target).attr('id')==='show_pwd'){
          console.log($(e.target).text());
          $(e.target).text("默认密码:123456")
      }
  })
</script>
<%--返回顶部--%>
<script src="to-top.js"></script>
<%--查询.js--%>
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
                $("#test1").load("search_reader.jsp");
            },"html");
        });
    })
</script>
<%--下一页上一页--%>
<script>
    $(function (){
        <c:if test="${not empty sessionScope.PageBean_reader}">
        let curpage =${sessionScope.PageBean_reader.currentPage};
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
                $("#test1").load("search_reader.jsp");
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
                    $("#test1").load("search_reader.jsp");
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
                $("#test1").load("search_reader.jsp");
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
                $("#test1").load("search_reader.jsp");
            },"html")
        })
        </c:if>
    })
</script>
<script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.6.0/jquery.js"></script>
<script src="https://cdn.bootcdn.net/ajax/libs/popper.js/1.16.1/umd/popper.min.js" ></script>
<script src="https://cdn.bootcdn.net/ajax/libs/twitter-bootstrap/4.6.1/js/bootstrap.min.js" ></script>



</body>
</html>
