<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${empty producto ? 'Nuevo' : 'Editar'} Producto - Inventario</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', sans-serif; background: #f0f2f5; color: #333; }
        .container { max-width: 600px; margin: 40px auto; padding: 20px; }
        header { background: #1a73e8; color: white; padding: 20px 0; margin-bottom: 30px; }
        header h1 { text-align: center; font-size: 1.8rem; }
        .card { background: white; border-radius: 8px; padding: 30px; box-shadow: 0 2px 8px rgba(0,0,0,0.1); }
        .form-group { margin-bottom: 20px; }
        label { display: block; margin-bottom: 6px; font-weight: 600; font-size: 0.9rem; color: #555; }
        input, select, textarea { width: 100%; padding: 10px 14px; border: 1px solid #ddd; border-radius: 6px; font-size: 1rem; transition: border 0.2s; }
        input:focus, select:focus, textarea:focus { border-color: #1a73e8; outline: none; }
        textarea { resize: vertical; min-height: 80px; }
        .form-actions { display: flex; gap: 12px; margin-top: 24px; }
        .btn { display: inline-block; padding: 10px 24px; border-radius: 6px; text-decoration: none; font-weight: 600; border: none; cursor: pointer; font-size: 0.9rem; }
        .btn-primary { background: #1a73e8; color: white; }
        .btn-primary:hover { background: #1557b0; }
        .btn-secondary { background: #666; color: white; }
        .btn-secondary:hover { background: #555; }
        .btn-back { display: inline-block; margin-bottom: 20px; color: #1a73e8; text-decoration: none; font-weight: 600; }
    </style>
</head>
<body>
    <header>
        <h1>${empty producto ? 'Nuevo' : 'Editar'} Producto</h1>
    </header>
    <div class="container">
        <a href="${pageContext.request.contextPath}/productos?accion=listar" class="btn-back">← Volver a la lista</a>

        <div class="card">
            <form action="${pageContext.request.contextPath}/productos" method="post">
                <c:if test="${not empty producto}">
                    <input type="hidden" name="accion" value="actualizar">
                    <input type="hidden" name="id" value="${producto.id()}">
                </c:if>
                <c:if test="${empty producto}">
                    <input type="hidden" name="accion" value="insertar">
                </c:if>

                <div class="form-group">
                    <label for="codigo">Código *</label>
                    <input type="text" id="codigo" name="codigo" required maxlength="50"
                           value="${producto.codigo()}" placeholder="Ej: PROD-001">
                </div>

                <div class="form-group">
                    <label for="nombre">Nombre *</label>
                    <input type="text" id="nombre" name="nombre" required maxlength="100"
                           value="${producto.nombre()}" placeholder="Nombre del producto">
                </div>

                <div class="form-group">
                    <label for="descripcion">Descripción</label>
                    <textarea id="descripcion" name="descripcion"
                              placeholder="Descripción del producto">${producto.descripcion()}</textarea>
                </div>

                <div class="form-group">
                    <label for="precio">Precio *</label>
                    <input type="number" id="precio" name="precio" required step="0.01" min="0"
                           value="${producto.precio()}" placeholder="0.00">
                </div>

                <div class="form-group">
                    <label for="stock">Stock *</label>
                    <input type="number" id="stock" name="stock" required min="0"
                           value="${producto.stock()}" placeholder="0">
                </div>

                <div class="form-group">
                    <label for="categoria">Categoría</label>
                    <select id="categoria" name="categoria">
                        <option value="">Seleccionar categoría</option>
                        <option value="Tecnología" ${producto.categoria() == 'Tecnología' ? 'selected' : ''}>Tecnología</option>
                        <option value="Accesorios" ${producto.categoria() == 'Accesorios' ? 'selected' : ''}>Accesorios</option>
                        <option value="Mobiliario" ${producto.categoria() == 'Mobiliario' ? 'selected' : ''}>Mobiliario</option>
                        <option value="Papelería" ${producto.categoria() == 'Papelería' ? 'selected' : ''}>Papelería</option>
                    </select>
                </div>

                <div class="form-actions">
                    <button type="submit" class="btn btn-primary">${empty producto ? 'Crear Producto' : 'Actualizar'}</button>
                    <a href="${pageContext.request.contextPath}/productos?accion=listar" class="btn btn-secondary">Cancelar</a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>