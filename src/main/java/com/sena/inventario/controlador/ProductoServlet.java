package com.sena.inventario.controlador;

import com.sena.inventario.dao.ProductoDAO;
import com.sena.inventario.modelo.Producto;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

@WebServlet("/productos")
public class ProductoServlet extends HttpServlet {

    private final ProductoDAO dao = new ProductoDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String accion = req.getParameter("accion");

        switch (accion != null ? accion : "listar") {
            case "nuevo" -> mostrarFormulario(req, resp);
            case "editar" -> mostrarEditar(req, resp);
            case "eliminar" -> eliminar(req, resp);
            default -> listar(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        String accion = req.getParameter("accion");

        switch (accion != null ? accion : "listar") {
            case "insertar" -> insertar(req, resp);
            case "actualizar" -> actualizar(req, resp);
            default -> listar(req, resp);
        }
    }

    private void listar(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        List<Producto> productos = dao.listarTodos();
        req.setAttribute("productos", productos);
        req.getRequestDispatcher("/WEB-INF/vistas/productos/lista.jsp").forward(req, resp);
    }

    private void mostrarFormulario(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/vistas/productos/formulario.jsp").forward(req, resp);
    }

    private void mostrarEditar(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        Producto producto = dao.buscarPorId(id);
        req.setAttribute("producto", producto);
        req.getRequestDispatcher("/WEB-INF/vistas/productos/formulario.jsp").forward(req, resp);
    }

    private void insertar(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
        Producto producto = new Producto(
            req.getParameter("codigo"),
            req.getParameter("nombre"),
            new BigDecimal(req.getParameter("precio")),
            Integer.parseInt(req.getParameter("stock")),
            req.getParameter("categoria")
        );
        dao.insertar(producto);
        resp.sendRedirect(req.getContextPath() + "/productos?accion=listar");
    }

    private void actualizar(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
        Producto producto = new Producto(
            Integer.parseInt(req.getParameter("id")),
            req.getParameter("codigo"),
            req.getParameter("nombre"),
            req.getParameter("descripcion"),
            new BigDecimal(req.getParameter("precio")),
            Integer.parseInt(req.getParameter("stock")),
            req.getParameter("categoria"),
            true,
            null
        );
        dao.actualizar(producto);
        resp.sendRedirect(req.getContextPath() + "/productos?accion=listar");
    }

    private void eliminar(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        dao.eliminar(id);
        resp.sendRedirect(req.getContextPath() + "/productos?accion=listar");
    }
}