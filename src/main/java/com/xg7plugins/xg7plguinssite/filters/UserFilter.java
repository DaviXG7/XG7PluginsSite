package com.xg7plugins.xg7plguinssite.filters;

import com.xg7plugins.xg7plguinssite.db.DBManager;
import com.xg7plugins.xg7plguinssite.emails.EmailManager;
import com.xg7plugins.xg7plguinssite.models.UserModel;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;

@WebFilter(urlPatterns = {"/*"})
public class UserFilter implements Filter {


    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        Filter.super.init(filterConfig);
        try {
            DBManager.init();
            EmailManager.loadSession();
        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;

        HttpSession session = request.getSession();

        if (session.getAttribute("user") == null) {

            if (request.getServletPath().contains("home")) response.sendRedirect("/login.jsp");

            filterChain.doFilter(request, response);
            return;
        }
        if (request.getServletPath().contains("user")) {
            try {
                request.getSession().setAttribute("user", DBManager.getUserById(((UserModel) request.getSession().getAttribute("user")).getId().toString()));
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
            filterChain.doFilter(request, response);
            return;
        }
        if (request.getServletPath().contains("admin")) {
            if (((UserModel) request.getSession().getAttribute("user")).getPermission() < 2) {
                response.sendRedirect("home/dashboard.jsp");
                filterChain.doFilter(request, response);
                return;
            }
        }
        if (request.getServletPath().contains("plugin")) {
            if (((UserModel) request.getSession().getAttribute("user")).getPermission() != 4 && ((UserModel) request.getSession().getAttribute("user")).getPermission() < 2) {
                response.sendRedirect("home/dashboard.jsp");
                filterChain.doFilter(request, response);
                return;
            }
        }
        if (request.getServletPath().contains("login") || request.getServletPath().contains("cadastro")) {
            response.sendRedirect("home/dashboard.jsp");
                filterChain.doFilter(request, response);
                return;
        }



        filterChain.doFilter(request, response);






    }

    @Override
    public void destroy() {
        try {
            DBManager.discconect();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        Filter.super.destroy();
    }
}
