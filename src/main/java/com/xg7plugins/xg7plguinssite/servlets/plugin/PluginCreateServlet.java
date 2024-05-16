package com.xg7plugins.xg7plguinssite.servlets.plugin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.IOException;

@WebServlet(name = "criarplugin", value = "/criarplugin")
public class PluginCreateServlet extends HttpServlet {

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        Part plugin = request.getPart("plugin");
        Part configs = request.getPart("configs");

        String name = request.getParameter("name");
        String categoria = request.getParameter("categoria");
        String url = request.getParameter("urlVideo");
        String github = request.getParameter("github");
        String versions = request.getParameter("versions");
        String depedencies = request.getParameter("dependencies");

        String[] commandValues = request.getParameterValues("commandValue");
        String[] commandDescriptions = request.getParameterValues("commandDescription");

        String[] permValues = request.getParameterValues("permValue");
        String[] permDescriptions = request.getParameterValues("permDescription");

        String[] resources = request.getParameterValues("resourceValue");

        float preco = Float.parseFloat(request.getParameter("preco").replace(",", ""));

        if (plugin == null || name == null || name.isEmpty()
        || categoria == null || versions == null || versions.isEmpty() || depedencies == null
        || depedencies.isEmpty() || commandValues == null || commandDescriptions == null
        || permValues == null || permDescriptions == null || resources == null) throw new RuntimeException();

        if (categoria.equals("0")) throw new RuntimeException();



    }




}
