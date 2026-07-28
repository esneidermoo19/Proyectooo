package com.sena.inventario.modelo;

import java.time.LocalDateTime;

public record Usuario(
    int id,
    String username,
    String password,
    String nombre,
    String email,
    int rolId,
    boolean estado,
    LocalDateTime fechaRegistro
) {
    public Usuario(String username, String password, String nombre, String email, int rolId) {
        this(0, username, password, nombre, email, rolId, true, LocalDateTime.now());
    }
}