<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lista de Productos - Inventario</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', sans-serif; background: #f0f2f5; color: #333; }
        .container { max-width: 1100px; margin: 0 auto; padding: 20px; }
        header { background: #1a73e8; color: white; padding: 20px 0; margin-bottom: 30px; }
        header h1 { text-align: center; font-size: 1.8rem; }
        .btn { display: inline-block; padding: 10px 20px; border-radius: 6px; text-decoration: none; font-weight: 600; border: none; cursor: pointer; font-size: 0.9rem; }
        .btn-primary { background: #1a73e8; color: white; }
        .btn-primary:hover { background: #1557b0; }
        .btn-success { background: #34a853; color: white; }
        .btn-success:hover { background: #2d8e47; }
        .btn-warning { background: #fbbc04; color: #333; }
        .btn-warning:hover { background: #e0a800; }
        .btn-danger { background: #ea4335; color: white; }
        .btn-danger:hover { background: #c5221f; }
        .actions { margin-bottom: 20px; }
        table { width: 100%; border-collapse: collapse; background: white; border-radius: 8px; overflow: hidden; box-shadow: 0 2px 8px rgba(0,0,0,0.1); }
        th { background: #1a73e8; color: white; padding: 14px 12px; text-align: left; font-size: 0.85rem; text-transform: uppercase; }
        td { padding: 12px; border-bottom: 1px solid #eee; }
        tr:hover { background: #f8f9fa; }
        .badge { padding: 4px 10px; border-radius: 12px; font-size: 0.75rem; font-weight: 600; }
        .badge-success { background: #e6f4ea; color: #1e7e34; }
        .acciones-btns { display: flex; gap: 6px; }
        .acciones-btns a { padding: 6px 12px; font-size: 0.8rem; border-radius: 4px; }
        .empty { text-align: center; padding: 40px; color: #666; }
    </style>
</head>
<body>
    <header>
        <h1>Sistema de Inventario</h1>
    </header>
    <div class="container">
        <div class="actions">
            <a href="${pageContext.request.contextPath}/productos?accion=nuevo" class="btn btn-success">+ Nuevo Producto</a>
        </div>

        <c:choose>
            <c:when test="${not empty productos}">
                <table>
                    <thead>
                        <tr>
                            <th>Código</th>
                            <th>Nombre</th>
                            <th>Categoría</th>
                            <th>Precio</th>
                            <th>Stock</th>
                            <th>Estado</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="p" items="${productos}">
                            <tr>
                                <td>${p.codigo()}</td>
                                <td>${p.nombre()}</td>
                                <td>${p.categoria()}</td>
                                <td>$${p.precio()}</td>
                                <td>${p.stock()}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${p.estado()}">
                                            <span class="badge badge-success">Activo</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge">Inactivo</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <div class="acciones-btns">
                                        <a href="${pageContext.request.contextPath}/productos?accion=editar&id=${p.id()}" class="btn btn-warning">Editar</a>
                                        <a href="${pageContext.request.contextPath}/productos?accion=eliminar&id=${p.id()}" class="btn btn-danger" onclick="return confirm('¿Estás seguro de eliminar este producto?')">Eliminar</a>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:when>
            <c:otherwise>
                <div class="empty">
                    <h2>No hay productos registrados</h2>
                    <p>Haz clic en "Nuevo Producto" para agregar el primero.</p>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>