package com.tkheat.filter;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebFilter("/*") // 전체 요청에 대해 필터 적용
public class LoginCheckFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response,
                         FilterChain chain) throws IOException, ServletException {
      // System.out.println("필터 도착");

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        String uri = req.getRequestURI();
        HttpSession session = req.getSession(false);

        if (session != null) {
         //   System.out.println("loginUser: " + session.getAttribute("loginUser"));
        } else {
           // System.out.println("세션이 존재하지 않음");
        }
        
        boolean isLoggedIn = session != null && session.getAttribute("loginUser") != null;
       // System.out.println("요청 uri: " + uri);

        // 로그인 없이 접근 가능한 경로 예외 처리
        if (uri.contains("/css") || uri.contains("/include") || uri.startsWith("/ezPublic/css/") || uri.equals("/ezPublic/") 
        		|| uri.contains("/user/login") || uri.equals("/") || uri.contains("/user/android/login")) {
            chain.doFilter(request, response); // 통과
            return;
        }

        // 로그인 안 됐으면 로그인 페이지로 리다이렉트
        if (!isLoggedIn) {
            res.setContentType("text/html; charset=UTF-8");
            PrintWriter out = res.getWriter();
            out.println("<script>");
            out.println("alert('세션 만료. 다시 로그인 해주세요.');");
            out.println("window.top.location.href='" + req.getContextPath() + "/';");
            out.println("</script>");
            out.close();
            return;
        }

        chain.doFilter(request, response); // 로그인 되어 있으면 통과
    }

   @Override
   public void init(FilterConfig filterConfig) throws ServletException {
      // TODO Auto-generated method stub
      
   }

   @Override
   public void destroy() {
      // TODO Auto-generated method stub
      
   }
}


