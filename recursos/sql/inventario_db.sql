-- ============================================
-- Base de datos: inventario_db
-- Guía de Aprendizaje JSP + MVC - SENA ADSO
-- ============================================

-- Crear base de datos (si no existe)
-- CREATE DATABASE inventario_db;

-- ============================================
-- TABLA: roles
-- ============================================
CREATE TABLE IF NOT EXISTS roles (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) UNIQUE NOT NULL,
    descripcion TEXT,
    estado BOOLEAN DEFAULT TRUE,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================================
-- TABLA: usuarios
-- ============================================
CREATE TABLE IF NOT EXISTS usuarios (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    rol_id INTEGER REFERENCES roles(id),
    estado BOOLEAN DEFAULT TRUE,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================================
-- TABLA: productos
-- ============================================
CREATE TABLE IF NOT EXISTS productos (
    id SERIAL PRIMARY KEY,
    codigo VARCHAR(50) UNIQUE NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    precio DECIMAL(10,2) CHECK (precio >= 0),
    stock INTEGER DEFAULT 0 CHECK (stock >= 0),
    categoria VARCHAR(50),
    estado BOOLEAN DEFAULT TRUE,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================================
-- DATOS INICIALES: roles
-- ============================================
INSERT INTO roles (nombre, descripcion) VALUES
    ('Administrador', 'Acceso total al sistema'),
    ('Vendedor', 'Gestión de ventas y productos'),
    ('Almacenero', 'Gestión de inventario')
ON CONFLICT (nombre) DO NOTHING;

-- ============================================
-- DATOS INICIALES: usuario admin
-- ============================================
INSERT INTO usuarios (username, password, nombre, email, rol_id) VALUES
    ('admin', 'admin123', 'Administrador General', 'admin@sena.edu.co', 1)
ON CONFLICT (username) DO NOTHING;

-- ============================================
-- DATOS INICIALES: productos de ejemplo
-- ============================================
INSERT INTO productos (codigo, nombre, precio, stock, categoria) VALUES
    ('PROD-001', 'Laptop HP Pavilion', 2500000.00, 15, 'Tecnología'),
    ('PROD-002', 'Mouse Logitech', 45000.00, 50, 'Accesorios'),
    ('PROD-003', 'Teclado Mecánico', 180000.00, 30, 'Accesorios'),
    ('PROD-004', 'Monitor Samsung 24"', 850000.00, 20, 'Tecnología'),
    ('PROD-005', 'Audífonos Bluetooth', 120000.00, 40, 'Accesorios')
ON CONFLICT (codigo) DO NOTHING;

-- ============================================
-- ÍNDICES para mejor rendimiento
-- ============================================
CREATE INDEX IF NOT EXISTS idx_productos_categoria ON productos(categoria);
CREATE INDEX IF NOT EXISTS idx_productos_estado_categoria ON productos(estado, categoria);
CREATE INDEX IF NOT EXISTS idx_usuarios_rol ON usuarios(rol_id);
CREATE INDEX IF NOT EXISTS idx_usuarios_estado ON usuarios(estado);