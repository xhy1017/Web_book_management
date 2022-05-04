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
    <link rel="stylesheet" href="to-top.css">
    <link rel="stylesheet" href="https://cdn.bootcdn.net/ajax/libs/twitter-bootstrap/4.6.1/css/bootstrap.min.css" >
    <title>修改书籍信息</title>
</head>
<body>
<div>
    <form id="search_book_form" >
        <table class="table-hover" style="margin-bottom: auto">
            <tr>
                <td class="h5">请输入要修改的书号ID:</td>
                <td><input type="text" class="form-control  row-sm-3 " name="bkID" value="${sessionScope.PageBean_book.vague_query.bkID}"></td>
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
            </tr>
            <tr>
                <td colspan="2"><input type="button" id="proverb_book" class="form-control btn-outline-info" value="查询"></td>
                <td colspan="2"><input type="reset"  class="form-control btn-outline-danger" value="重置"></td>
            </tr>
        </table>
    </form>
</div>
<form>
    <table class="table table-hover " id="book_table">
        <thead class="thead-light" >
        <tr>
            <th>编号</th>
            <th>封面</th>
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
                    <td>${S.count}</td>
                    <td><img src="${Book.bkURL}" style="width:120px;height: 150px" alt=""></td>
                    <td style="vertical-align: middle"><strong>${Book.bkID}</strong></td>
                    <td style="color: darkorange;vertical-align:middle"><strong>${Book.bkName}</strong></td>
                    <td style="vertical-align: middle"><strong>${Book.bkAuthor}</strong></td>
                    <td style="vertical-align: middle"><strong>${Book.bkPress}</strong></td>
                    <td style="vertical-align: middle"><strong>${Book.bkPrice}</strong></td>
                    <td style="vertical-align: middle;color:dodgerblue">${Book.bkStatus}</td>
                    <td style="vertical-align: middle"><button id="modify_book_info" type="button" data-toggle="modal" data-target="#myModal"  class="btn btn-info">修改信息</button></td>
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
                    <p class="h6 text-lg-right"><strong>当前第&nbsp;${sessionScope.PageBean_book.currentPage}&nbsp;页,</strong></p>
                </td>
                <td style="vertical-align: bottom;">
                    <p class="h6 text-lg-left"><strong>每页记录数</strong></p>
                </td>
                <td style="vertical-align: bottom;">
                    <select class="form-control"  id="pageSize" name="pageSize">
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
                    <p class="h6 text-lg-left"><strong>总${sessionScope.PageBean_book.totalPages} 页,总${sessionScope.PageBean_book.totalRecord}条记录</strong></p>
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
                    <strong>修改书籍成功!</strong>
                </div>
            </div>
            <!-- 模态框底部 -->
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>
<%--模态框背景不变黑去除遮罩层--%>
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
                    <form id="modify_book_form" enctype="multipart/form-data">
                        <table class="table table-hover " >
                            <tr>
                                <td class="h5">书号id:<br><span class="btn-sm btn-outline-primary">不可修改</span></td>
                                <td><input class="form-control" readonly name="bkID" id="bkID" value=""></td>
                            </tr>
                            <tr>
                                <td class="h5">书名:<br><span class="btn-sm btn-outline-danger">必填项</span></td>
                                <td><input type="text" class="form-control" name="bkName" id="bkName" value=""><span id="info1"  style="color: red;display: none">值已修改</span></td>
                            </tr>
                            <tr>
                                <td class="h5">作者:<br><span class="btn-sm btn-outline-danger">必填项</span></td>
                                <td><input type="text" class="form-control" name="bkAuthor" id="bkAuthor" value=""><span id="info2"  style="color: red;display: none">值已修改</span></td>
                            </tr>
                            <tr>
                                <td class="h5">出版社:<br><span class="btn-sm btn-outline-danger">必填项</span></td>
                                <td><input type="text" class="form-control" name="bkPress" id="bkPress" value=""><span id="info3"  style="color: red;display: none">值已修改</span></td>
                            </tr>
                            <tr>
                                <td class="h5">价格:<br><span class="btn-sm btn-outline-danger">必填项</span></td>
                                <td><input type="text"  class="form-control" name="bkPrice" id="bkPrice" value=""><span id="info4"  style="color: red;display: none">值已修改</span></td>
                            </tr>
                            <tr>
                                <td class="h5">状态<br><span class="btn-sm btn-outline-danger">必填项</span></td>
                                <td>
                                    <select name="bkStatus" id="bkStatus"  class="form-control">
                                        <option style="display: none">请选择</option>
                                        <option value="在馆">在馆</option>
                                        <option value="借出">借出</option>
                                    </select>
                                    <span id="info5"  style="color: red;display: none">值已修改</span>
                                </td>
                            </tr>
                            <tr>
                                <td class="h5">上传封面:<br><span class="btn-sm btn-outline-danger">必选项</span></td>
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
                <button type="button" id="confirm_modify_book"  data-dismiss="modal" class="btn btn-outline-primary">确认修改</button>
            </div>
        </div>
    </div>
</div>
<script src="to-top.js" ></script>
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
                $("#test1").load("modify_book.jsp");
            },"html");
        });
    })
</script>
<script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.6.0/jquery.js"></script>
<script src="https://cdn.bootcdn.net/ajax/libs/popper.js/1.16.1/umd/popper.min.js"></script>
<script src="https://cdn.bootcdn.net/ajax/libs/twitter-bootstrap/4.6.1/js/bootstrap.min.js"></script>
<script>
    //
    var formdata=new FormData();
    //后来更新的值 用let会被重新声明导致出错 用var声明全局变量
    var author,name, press,price,status;
    //全局变量，获取table里的值
   var bkID, bkName,bkAuthor,bkPress,bkPrice,bkStatus;
    $("#close_modal").click(function (){
       //关闭时清空模态框数据 表单数据与图片显示数据
    document.getElementById("modify_book_form").reset();
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
   // #modify_book_info解决了点击别的位置值会消失问题
   $(document).click(function (e){
       if($(e.target).attr('id')==='modify_book_info'){
           //找当前行的父元素tr标签的子节点td标签
           //获取table文本内容
           const data = $(e.target).parents('tr').children('td');
           bkID = data.eq(2).text();
           bkName = data.eq(3).text();
           bkAuthor = data.eq(4).text();
           bkPress = data.eq(5).text();
           bkPrice = data.eq(6).text();
           bkStatus = data.eq(7).text();
           //赋值给模态框里表单
          $("#bkID").val(bkID);
          $("#bkName").val(bkName);
          $("#bkAuthor").val(bkAuthor);
          $("#bkPress").val(bkPress);
          $("#bkPrice").val(bkPrice);
          $("#bkStatus").val(bkStatus);
       }
   })
    //添加input元素监听事件，值发生改变覆盖原来的值
   $("#bkName").on("input propertychange",function (){
       name = $(this).val();
       //转为原生dom对象
       if(name!==bkName){
           //显示span标签
           $("#info1")[0].style.display='block';
           //set是覆盖value值不能用append，那个是追加
           formdata.set('bkName',name);
       }
       else {
           $("#info1")[0].style.display='none';
       }
   })
   $("#bkAuthor").on("input propertychange",function (){
       author= $(this).val();
       //转为原生dom对象
       if(author!==bkAuthor){
           //显示span标签
           $("#info2")[0].style.display='block';
           formdata.set('bkAuthor',author);
       }
       else {
           $("#info2")[0].style.display='none';
       }
   })
   $("#bkPress").on("input propertychange",function (){
       press= $(this).val();
       //转为原生dom对象
       if(press!==bkPress){
           //显示span标签
           $("#info3")[0].style.display='block';
           formdata.set('bkPress',press);
       }
       else {
           $("#info3")[0].style.display='none';
       }
   })
   $("#bkPrice").on("input propertychange",function (){
       price = $(this).val();
       //转为原生dom对象
       if(price!==bkPrice){
           //显示span标签
           $("#info4")[0].style.display='block';
           formdata.set('bkPrice',price);
       }
       else {
           $("#info4")[0].style.display='none';
       }
   })
   $("#bkStatus").on("input propertychange",function (){
       status = $(this).val();
       //转为原生dom对象
       if(status!==bkStatus){
           //显示span标签
           $("#info5")[0].style.display='block';
           formdata.set('bkStatus',status);
       }
       else {
           $("#info5")[0].style.display='none';
       }
   })
   $("#confirm_modify_book").click(function (){
       //有选择性的改，不变的东西不去改它
       // const formdata = new FormData($("#modify_book_form")[0]);
       //[0]原生dorm对象
       //这句可以不需要，无选择性的改，就需要了，其实 formdata 已经封装好了，
       formdata.set("bkID",bkID);
       formdata.set('bkImage',$("#input_img")[0].files[0]);//有则覆盖，无则创建
       //拿到文件名字
       console.log(formdata.get('bkName'))
       console.log(formdata.get('bkStatus'))
       console.log(formdata.get('bkPress'))
       console.log(formdata.get('bkID'));
       console.log(formdata.get('bkAuthor'));
       console.log(formdata.get('bkPrice'));
       console.log(formdata.get('bkImage'));
       $.ajax(
           {
               url:"Modify_Book_Servlet",
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
           document.getElementById("modify_book_form").reset();
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
                $("#test1").load("modify_book.jsp");
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
                    $("#test1").load("modify_book.jsp");
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
                $("#test1").load("modify_book.jsp");
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
                $("#test1").load("modify_book.jsp");
            },"html")
        })
        </c:if>
    })
</script>
</body>
</html>
