package Filter;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
@WebFilter(filterName = "LoginFilter",urlPatterns = "/*")
public class LoginFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        Filter.super.init(filterConfig);
    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
       //强制类型转换
        HttpServletRequest request=(HttpServletRequest) servletRequest;
        HttpServletResponse response=(HttpServletResponse)servletResponse;
        //拿到请求路径
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        String URI= request.getRequestURI();
        System.out.println(URI);
        //登录页面不拦截
        if(URI.contains("/login.jsp")){
           filterChain.doFilter(request,response);
           return;
        }
        //静态资源不拦截
        if(URI.contains("/images"))
        //设置响应内容类型，不然会一堆乱码 直接images访问不会走这个filter控制台打印无结果
        {   response.setContentType("image/png");
            filterChain.doFilter(request,response);
            return;
        }
        //一样的问题，引入外部css、js，设置响应类型，因为这玩意要经过过滤器的，
        if(URI.endsWith(".css")){
            response.setContentType("text/css");
            filterChain.doFilter(request,response);
            return;
        }
        if(URI.endsWith(".js")){
            response.setContentType("application/javascript");
            filterChain.doFilter(request,response);
            return;
        }
        //按了登录，此操作不拦截
        if(URI.endsWith("/Login")){
            filterChain.doFilter(request,response);
            return;
        }
        //登录成功不拦截在登录成功之后判断session不为空 ;所有当前链接都不会被拦截
        if(request.getSession().getAttribute("msg")!=null)
        {
            filterChain.doFilter(request,response);
            return;
        }
        //退出请求不会被拦截
        if(URI.contains("/Exit"))
        {
            filterChain.doFilter(request,response);
            return;
        }
        //其他情况一律拦截重定向回到登录页面
        response.sendRedirect(request.getContextPath()+"/login.jsp");
    }
    @Override
    public void destroy() {
        Filter.super.destroy();
    }
}
