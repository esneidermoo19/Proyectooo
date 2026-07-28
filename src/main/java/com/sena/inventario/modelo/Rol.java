package com.sena.inventario.modelo;

import java.time.LocalDateTime;

public record Rol(
    int id,
    String nombre,
    String descripcion,
    boolean estado,
    LocalDateTime fechaRegistro
) {
    public Rol(String nombre, String descripcion) {
        this(0, nombre, descripcion, true, LocalDateTime.now());
    }
}