<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="es">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta charset="utf-8" />
    <title>SoWil Company - Eliminar Vehículo</title>
    <meta name="description" content="Barner Acosta Ramirez" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />
    <%@include file="cssplantilla.jsp" %>
</head>

<body class="no-skin">
    <!-- NAVBAR -->
    <div id="navbar" class="navbar navbar-default ace-save-state">
        <div class="navbar-container ace-save-state" id="navbar-container">
            <div class="navbar-header pull-left">
                <a href="${ctx}/index.jsp" class="navbar-brand">
                    <small>
                        <i class="fa fa-book"></i>
                        Gestión de Vehículos - Eliminar
                    </small>
                </a>
            </div>
        </div>
    </div>

    <div class="main-container ace-save-state" id="main-container">
        <div class="main-content">
            <div class="main-content-inner">
                <div class="page-content">
                    <div class="page-header">
                        <h1>
                            Eliminar Vehículo
                            <small>
                                <i class="ace-icon fa fa-angle-double-right"></i>
                                Confirmación de eliminación
                            </small>
                        </h1>
                    </div>

                    <div class="row">
                        <div class="col-xs-12">
                            <%
                            String placa = request.getParameter("placa");
                            String confirmar = request.getParameter("confirmar");

                            // Procesar eliminación si se confirmó
                            if ("si".equals(confirmar) && placa != null) {
                                Connection conn = null;
                                PreparedStatement pstmt = null;

                                try {
                                    String url = "jdbc:mysql://localhost:3306/concesionario";
                                    String usuario = "root";
                                    String password = "";

                                    Class.forName("com.mysql.jdbc.Driver");
                                    conn = DriverManager.getConnection(url, usuario, password);

                                    String sql = "DELETE FROM vehiculo WHERE placa = ?";
                                    pstmt = conn.prepareStatement(sql);
                                    pstmt.setString(1, placa);

                                    int filasAfectadas = pstmt.executeUpdate();

                                    if (filasAfectadas > 0) {
                            %>
                                        <div class="alert alert-success">
                                            <h4><i class="ace-icon fa fa-check"></i> ¡Eliminado!</h4>
                                            El vehículo con placa <strong><%= placa %></strong> se eliminó correctamente.
                                        </div>

                                        <div class="center">
                                            <a href="${ctx}/listarVehi.jsp" class="btn btn-primary">
                                                <i class="ace-icon fa fa-arrow-left"></i>
                                                Volver a la lista
                                            </a>
                                        </div>
                            <%
                                    } else {
                            %>
                                        <div class="alert alert-warning">
                                            <h4><i class="ace-icon fa fa-exclamation-triangle"></i> No eliminado</h4>
                                            No se pudo eliminar el vehículo. Es posible que ya no exista.
                                        </div>

                                        <div class="center">
                                            <a href="${ctx}/listarVehi.jsp" class="btn btn-primary">
                                                <i class="ace-icon fa fa-arrow-left"></i>
                                                Volver a la lista
                                            </a>
                                        </div>
                            <%
                                    }
                                } catch (Exception e) {
                            %>
                                    <div class="alert alert-danger">
                                        <h4><i class="ace-icon fa fa-times"></i> Error</h4>
                                        No se pudo eliminar el vehículo: <%= e.getMessage() %>
                                    </div>

                                    <div class="center">
                                        <a href="${ctx}/listarVehi.jsp" class="btn btn-primary">
                                            <i class="ace-icon fa fa-arrow-left"></i>
                                            Volver a la lista
                                        </a>
                                    </div>
                            <%
                                } finally {
                                    try {
                                        if (pstmt != null) pstmt.close();
                                        if (conn != null) conn.close();
                                    } catch (SQLException e) {
                                        e.printStackTrace();
                                    }
                                }
                            } else if (placa == null || placa.trim().isEmpty()) {
                            %>
                                <div class="alert alert-danger">
                                    <h4><i class="ace-icon fa fa-times"></i> Error</h4>
                                    No se especificó la placa del vehículo.
                                </div>
                                <div class="center">
                                    <a href="${ctx}/listarVehi.jsp" class="btn btn-primary">
                                        <i class="ace-icon fa fa-arrow-left"></i>
                                        Volver a la lista
                                    </a>
                                </div>
                            <%
                            } else {
                                // Mostrar confirmación de eliminación
                                Connection conn = null;
                                PreparedStatement pstmt = null;
                                ResultSet rs = null;

                                try {
                                    String url = "jdbc:mysql://localhost:3306/concesionario";
                                    String usuario = "root";
                                    String password = "";

                                    Class.forName("com.mysql.jdbc.Driver");
                                    conn = DriverManager.getConnection(url, usuario, password);

                                    String sql = "SELECT v.placa, v.marca, v.referencia, v.modelo, v.id_tv, t.nomTv " +
                                               "FROM vehiculo v INNER JOIN tipovehi t ON v.id_tv = t.IdTv " +
                                               "WHERE v.placa = ?";

                                    pstmt = conn.prepareStatement(sql);
                                    pstmt.setString(1, placa);
                                    rs = pstmt.executeQuery();

                                    if (rs.next()) {
                            %>
                                        <div class="alert alert-warning">
                                            <h4><i class="ace-icon fa fa-exclamation-triangle"></i> ¡Atención!</h4>
                                            <p><strong>¿Está seguro que desea eliminar este vehículo?</strong></p>
                                            <p>Esta acción no se puede deshacer.</p>
                                        </div>

                                        <div class="widget-box">
                                            <div class="widget-header widget-header-red">
                                                <h4 class="widget-title">
                                                    <i class="ace-icon fa fa-car"></i>
                                                    Vehículo a eliminar: <%= rs.getString("placa") %>
                                                </h4>
                                            </div>

                                            <div class="widget-body">
                                                <div class="widget-main">
                                                    <div class="row">
                                                        <div class="col-sm-6">
                                                            <div class="form-group">
                                                                <label class="control-label"><strong>Placa:</strong></label>
                                                                <p class="form-control-static"><%= rs.getString("placa") %></p>
                                                            </div>

                                                            <div class="form-group">
                                                                <label class="control-label"><strong>Marca:</strong></label>
                                                                <p class="form-control-static"><%= rs.getString("marca") %></p>
                                                            </div>

                                                            <div class="form-group">
                                                                <label class="control-label"><strong>Referencia:</strong></label>
                                                                <p class="form-control-static"><%= rs.getString("referencia") %></p>
                                                            </div>
                                                        </div>

                                                        <div class="col-sm-6">
                                                            <div class="form-group">
                                                                <label class="control-label"><strong>Modelo:</strong></label>
                                                                <p class="form-control-static"><%= rs.getString("modelo") %></p>
                                                            </div>

                                                            <div class="form-group">
                                                                <label class="control-label"><strong>Tipo de Vehículo:</strong></label>
                                                                <p class="form-control-static"><%= rs.getString("nomTv") %></p>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="center">
                                            <a href="${ctx}/eliminar_vehiculo.jsp?placa=<%= rs.getString("placa") %>&confirmar=si"
                                               class="btn btn-danger"
                                               onclick="return confirm('¿Está absolutamente seguro que desea eliminar este vehículo? Esta acción no se puede deshacer.');">
                                                <i class="ace-icon fa fa-trash-o"></i>
                                                SÍ, ELIMINAR VEHÍCULO
                                            </a>

                                            <a href="${ctx}/listarVehi.jsp" class="btn btn-success">
                                                <i class="ace-icon fa fa-arrow-left"></i>
                                                NO, CANCELAR
                                            </a>

                                            <a href="${ctx}/ver_vehiculo.jsp?placa=<%= rs.getString("placa") %>" class="btn btn-info">
                                                <i class="ace-icon fa fa-eye"></i>
                                                Ver Detalles
                                            </a>
                                        </div>
                            <%
                                    } else {
                            %>
                                        <div class="alert alert-warning">
                                            <h4><i class="ace-icon fa fa-exclamation-triangle"></i> No encontrado</h4>
                                            No se encontró ningún vehículo con la placa: <strong><%= placa %></strong>
                                        </div>

                                        <div class="center">
                                            <a href="${ctx}/listarVehi.jsp" class="btn btn-primary">
                                                <i class="ace-icon fa fa-arrow-left"></i>
                                                Volver a la lista
                                            </a>
                                        </div>
                            <%
                                    }
                                } catch (Exception e) {
                            %>
                                    <div class="alert alert-danger">
                                        <h4><i class="ace-icon fa fa-times"></i> Error de Base de Datos</h4>
                                        <%= e.getMessage() %>
                                    </div>

                                    <div class="center">
                                        <a href="${ctx}/listarVehi.jsp" class="btn btn-primary">
                                            <i class="ace-icon fa fa-arrow-left"></i>
                                            Volver a la lista
                                        </a>
                                    </div>
                            <%
                                } finally {
                                    try {
                                        if (rs != null) rs.close();
                                        if (pstmt != null) pstmt.close();
                                        if (conn != null) conn.close();
                                    } catch (SQLException e) {
                                        e.printStackTrace();
                                    }
                                }
                            }
                            %>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script src="assets/js/jquery-2.1.4.min.js"></script>
    <script src="assets/js/bootstrap.min.js"></script>
    <script src="assets/js/ace-elements.min.js"></script>
    <script src="assets/js/ace.min.js"></script>
</body>
</html>
