<%--
  Created by IntelliJ IDEA.
  User: x'h'y
  Date: 2022/4/21
  Time: 17:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <link rel="stylesheet" href="https://cdn.bootcdn.net/ajax/libs/twitter-bootstrap/4.6.1/css/bootstrap.min.css" >
    <link rel="stylesheet" href="to-top.css">
    <title>修改读者信息</title>
</head>
<body>
<div>
    <form id="search_reader_form">
        <table class="table-hover">
            <tr>
                <td class="h5">请输入要修改的读者ID:</td>
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
                <%-- 设置选中项--%>
                <script>
                    <c:if test="${not empty PageBean_reader.vague_query.rdType}">
             <%--对所有select标签生效--%>
                    $("select:first").find("option[value=${sessionScope.PageBean_reader.vague_query.rdType}]").attr("selected",true);
                    </c:if>
                </script>
                <td class="h5">姓名:</td>
                <td><input type="text" class="form-control row-cols-3" name="rdName" value="${sessionScope.PageBean_reader.vague_query.rdName}"></td>

                <td class="h5">院系:</td>
                <td><input type="text" class="form-control" name="rdDept" value="${sessionScope.PageBean_reader.vague_query.rdDept}"></td>
            </tr>
            <tr>
                <td class="h5">已借书数量:</td>
                <td><input type="text" class="form-control" name="rdBorrowQty" value="${sessionScope.PageBean_reader.vague_query.rdBorrowQty}"></td>
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
    <c:if test="${not empty PageBean_reader.list}">
        <%--            循环拿到list集合对象--%>
        <%--     从请求域中拿到list属性--%>
    <c:forEach items="${sessionScope.PageBean_reader.list}" var="Reader" varStatus="s">
    <tr>
            <%-- .rdID实际上是getrdiD方法--%>
        <td><strong>${Reader.rdID}</strong></td>
        <td>${Reader.rdTypeName}</td>
        <td><strong>${Reader.rdName}</strong></td>
        <td>${Reader.rdDept}</td>
        <td>${Reader.rdQQ}</td>
        <td>${Reader.rdBorrowQty}</td>
        <td><button id="modify_reader_info" type="button" data-toggle="modal" data-target="#myModal"  class="btn btn-info">修改信息</button></td>
    </tr>
        </c:forEach>
        </c:if>
    </tbody>
</table>
<%--下一页组件--%>
<div class="row">
    <div class="col-lg-6">
        <table class="table table-borderless">
            <tr>
                <td style="vertical-align: bottom;">
                    <p class="h6 text-lg-right"><strong>当前第&nbsp;${sessionScope.PageBean_reader.currentPage}&nbsp;页,</strong></p>
                </td>
                <td style="vertical-align: bottom;">
                    <p class="h6 text-lg-left"><strong>每页记录数</strong></p>
                </td>
                <td style="vertical-align: bottom;">
                    <select class="form-control"  id="pageSize" name="pageSize">
                        <%--   数据回显 记录用户选择的每页记录数--%>
                        <option value="5"
                                <c:if test="${'5' eq sessionScope.PageBean_reader.pageSize}">
                                    selected
                                </c:if> >5/页
                        </option>
                        <option value="10"
                                <c:if test="${'10' eq sessionScope.PageBean_reader.pageSize}">selected</c:if> >
                            10/页
                        </option>
                        <option value="15" <c:if test="${'15' eq sessionScope.PageBean_reader.pageSize}">selected</c:if> >
                            15/页
                        </option>
                    </select>
                </td>
                <td style="vertical-align: bottom;">
                    <p class="h6 text-lg-left"><strong>总${sessionScope.PageBean_reader.totalPages} 页,总${sessionScope.PageBean_reader.totalRecord}条记录</strong></p>
                </td>
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
<div class="modal fade " id="Succeed_Modal">
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
                    <strong>修改读者信息成功!</strong>
                </div>
            </div>
            <!-- 模态框底部 -->
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>
<div class="modal  fade " id="myModal" data-backdrop=false>
    <%--    在这里写大一点的模态框--%>
    <div class="modal-dialog modal-lg ">
        <div class="modal-content ">
            <!-- 模态框头部 -->
            <div class="modal-header">
                <h5 class="modal-title btn-outline-info">请填写需修改的的信息</h5>
                <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>
            <!-- 模态框主体 -->
            <div class="modal-body">
                <div>
                    <form id="modify_reader_form" enctype="multipart/form-data">
                        <table class="table table-hover " >
                            <tr>
                                <td class="h5">读者id:<br><span class="btn-sm btn-outline-primary">不可修改</span></td>
                                <td><input class="form-control" readonly name="rdID" id="rdID" value=""></td>
                            </tr>
                            <tr>
                                <td class="h5">读者姓名:<br><span class="btn-sm btn-outline-danger">必填项</span></td>
                                <td><input type="text" class="form-control" name="rdName" id="rdName" value=""><span id="info1"  style="color: red;display: none">值已修改</span></td>
                            </tr>
                            <tr>
                                <td class="h5">已借书数量:<br><span class="btn-sm btn-outline-danger">必填项</span></td>
                                <td><input type="text" class="form-control" name="rdBorrowQty" id="rdBorrowQty" value=""><span id="info2"  style="color: red;display: none">值已修改</span></td>
                            </tr>
                            <tr>
                                <td class="h5">所属院系:<br><span class="btn-sm btn-outline-danger">必填项</span></td>
                                <td><input type="text" class="form-control" name="rdDept" id="rdDept" value=""><span id="info3"  style="color: red;display: none">值已修改</span></td>
                            </tr>
                            <tr>
                                <td class="h5">QQ:<br><span class="btn-sm btn-outline-danger">必填项</span></td>
                                <td><input type="text"  class="form-control" name="rdQQ" id="rdQQ" value=""><span id="info4"  style="color: red;display: none">值已修改</span></td>
                            </tr>
                            <tr>
                                <td class="h5">读者类型:<br><span class="btn-sm btn-outline-danger">必填项</span></td>
                                <td>
                                    <select name="rdType" id="rdType"  class="form-control">
                                        <option style="display: none">请选择</option>
                                        <option value="1">教师</option>
                                        <option value="2">本科生</option>
                                        <option value="3">硕士研究生</option>
                                        <option value="4">博士研究生</option>
                                        <option value="5">高中生</option>
                                    </select>
                                    <span id="info5"  style="color: red;display: none">值已修改</span>
                                </td>
                            </tr>
                            <tr>
                                <td class="h5">上传头像:<br><span class="btn-sm btn-outline-danger">必选项</span></td>
                                <td>
                                    <script>
                                        var getUserPhoto = document.getElementById("input_img");
                                        getUserPhoto.onchange = function ()
                                        {
                                            var file = this.files;
                                            console.log(file);
                                            var reader = new FileReader();
                                            reader.readAsDataURL(file[0]);
                                            reader.onload = function ()
                                            {
                                                var image = document.getElementById("show_img");
                                                image.style.display='block'
                                                image.src = reader.result;
                                            };
                                        };
                                    </script>
                                    <input type="file"  name="bkImage" accept="image/jpeg,image/jpeg,image/png" id="input_img" />
                                    <img id="show_img"  style="display: none;width: 200px;height: 200px" alt="暂无" src="">
                                </td>
                            </tr>
                        </table>
                    </form>
                </div>
            </div>
            <!-- 模态框底部 -->
            <div class="modal-footer">
                <button type="button" id="close_modal" class="btn btn-danger" data-dismiss="modal">关闭</button>
                <button type="button" id="confirm_modify_reader"  data-dismiss="modal" class="btn btn-outline-primary">确认修改</button>
            </div>
        </div>
    </div>
</div>
<%--查询读者--%>
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
                $("#test1").load("modify_reader.jsp");
            },"html");
        });
    })
</script>
<%--拿到模态框数据--%>
<script>
    //
    var formdata=new FormData();
    //后来更新的值 用let会被重新声明导致出错 用var声明全局变量
    var borrowQty,name, faculty,qq,typeName;
    //全局变量，获取table里的值
    var rdID, rdName,rdDept,rdType,rdBorrowQty,rdQQ;
    $("#close_modal").click(function (){
        //关闭时清空模态框数据 表单数据与图片显示数据
        document.getElementById("modify_reader_form").reset();
        document.getElementById("show_img").src="";
        //关闭模态框后span重新设为不可见状态
        $("#info1")[0].style.display='none';
        $("#info2")[0].style.display='none';
        $("#info3")[0].style.display='none';
        $("#info4")[0].style.display='none';
        $("#info5")[0].style.display='none';
        //图片也不显示
        $("#show_img")[0].style.display='none';
    })
    // #modify_reader_info解决了点击别的位置值会消失问题
    $(document).click(function (e){
        if($(e.target).attr('id')==='modify_reader_info'){
            //找当前行的父元素tr标签的子节点td标签
            //获取table文本内容
            const data = $(e.target).parents('tr').children('td');
            rdID = data.eq(0).text();
            rdType = data.eq(1).text();
            rdName = data.eq(2).text();
            rdDept = data.eq(3).text();
            rdQQ= data.eq(4).text();
            rdBorrowQty = data.eq(5).text();
            //赋值给模态框里表单
            $("#rdID").val(rdID);
            $("#rdName").val(rdName);
            $("#rdDept").val(rdDept);
            $("#rdBorrowQty").val(rdBorrowQty);
            $("#rdQQ").val(rdQQ);
            // console.log($("#rdType") .val())这样写会只拿到第一次的值，第二次点会为空值
           //简洁有效方法应该这样写
           $('#rdType').find('option:contains('+rdType+')').attr('selected',true);
            console.log($("#rdType option:checked").val());
           // $("#rdType").text()拿到的是所有文本值
            // 另外一种写法:$('#rdType option:contains(' + rdType +')').each(function(){
            //     if ($(this).text()===rdType) {
            //         $(this).attr('selected', true);
            //     }
            // });
        }
    })
    //添加input元素监听事件，值发生改变覆盖原来的值
    $("#rdName").on("input propertychange",function (){
        name = $(this).val();
        //转为原生dom对象
        if(name!==rdName){
            //显示span标签
            $("#info1")[0].style.display='block';
            //set是覆盖value值不能用append，那个是追加
            formdata.set('rdName',name);
        }
        else {
            $("#info1")[0].style.display='none';
        }
    })
    $("#rdBorrowQty").on("input propertychange",function (){
        borrowQty= $(this).val();
        //转为原生dom对象
        if(borrowQty!==rdBorrowQty){
            //显示span标签
            $("#info2")[0].style.display='block';
            formdata.set('rdBorrowQty',borrowQty);
        }
        else {
            $("#info2")[0].style.display='none';
        }
    })
    $("#rdDept").on("input propertychange",function (){
        faculty= $(this).val();
        //转为原生dom对象
        if(faculty!==rdDept){
            //显示span标签
            $("#info3")[0].style.display='block';
            formdata.set('rdDept',faculty);
        }
        else {
            $("#info3")[0].style.display='none';
        }
    })
    $("#rdQQ").on("input propertychange",function (){
        qq = $(this).val();
        //转为原生dom对象
        if(qq!==rdQQ){
            //显示span标签
            $("#info4")[0].style.display='block';
            formdata.set('rdQQ',qq);
        }
        else {
            $("#info4")[0].style.display='none';
        }
    })
    $("#rdType").on("input propertychange",function (){
        typeName = $(this).val();
        //转为原生dom对象
        if(typeName!==rdType){
            //显示span标签
            $("#info5")[0].style.display='block';
            formdata.set('rdType',typeName);
        }
        else {
            $("#info5")[0].style.display='none';
        }
    })
    $("#confirm_modify_reader").click(function (){
        //有选择性的改，不变的东西不去改它
        // const formdata = new FormData($("#modify_reader_form")[0]);
        //[0]原生dorm对象
        //这句可以不需要，无选择性的改，就需要了，其实 formdata 已经封装好了，
        formdata.set("rdID",rdID);
        formdata.set('user_Image',$("#input_img")[0].files[0]);//有则覆盖，无则创建
        //拿到文件名字
        console.log(formdata.get('rdName'))
        console.log(formdata.get('rdDept'))
        console.log(formdata.get('rdType'))
        console.log(formdata.get('rdBorrowQty'));
        console.log(formdata.get('rdQQ'));
        console.log(formdata.get('user_Image'));
        $.ajax(
            {
                url:"Modify_Reader_Servlet",
                type:'POST',
                data:formdata,
                cache:false,
                contentType:false,
                processData:false,
                success:function (data){
                    console.log(data);
                    $("#Succeed_Modal").modal();
                    setTimeout(function (){
                        $("#Succeed_Modal").modal('hide');
                    },1000)
                }
            }
        )
        document.getElementById("modify_reader_form").reset();
        document.getElementById("show_img").src="";
        //关闭模态框后重新设为不可见状态
        $("#info1")[0].style.display='none';
        $("#info2")[0].style.display='none';
        $("#info3")[0].style.display='none';
        $("#info4")[0].style.display='none';
        $("#info5")[0].style.display='none';
        //图片也不显示
        $("#show_img")[0].style.display='none';
    })
</script>
<%--分页下一页js--%>
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
                $("#test1").load("modify_reader.jsp");
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
                    $("#test1").load("modify_reader.jsp");
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
                $("#test1").load("modify_reader.jsp");
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
                $("#test1").load("modify_reader.jsp");
            },"html")
        })
        </c:if>
    })
</script>
<%--回到顶部js文件--%>
<script src="to-top.js"></script>
<script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.6.0/jquery.js"></script>
<script src="https://cdn.bootcdn.net/ajax/libs/popper.js/1.16.1/umd/popper.min.js"></script>
<script src="https://cdn.bootcdn.net/ajax/libs/twitter-bootstrap/4.6.1/js/bootstrap.min.js"></script>



</body>
</html>
