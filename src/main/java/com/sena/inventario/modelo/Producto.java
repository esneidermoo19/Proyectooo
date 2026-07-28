package com.sena.inventario.modelo;

import java.math.BigDecimal;
import java.time.LocalDateTime;

public record Producto(
    int id,
    String codigo,
    String nombre,
    String descripcion,
    BigDecimal precio,
    int stock,
    String categoria,
    boolean estado,
    LocalDateTime fechaRegistro
) {
    public Producto(String codigo, String nombre, BigDecimal precio, int stock, String categoria) {
        this(0, codigo, nombre, null, precio, stock, categoria, true, LocalDateTime.now());
    }
}