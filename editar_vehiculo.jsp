<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="es">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta charset="utf-8" />
    <title>SoWil Company - Editar Vehículo</title>
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
                        Gestión de Vehículos - Editar
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
                            Editar Vehículo
                            <small>
                                <i class="ace-icon fa fa-angle-double-right"></i>
                                Modificar información del vehículo
                            </small>
                        </h1>
                    </div>

                    <div class="row">
                        <div class="col-xs-12">
                            <%
                            String placa = request.getParameter("placa");
                            String accion = request.getParameter("accion");

                            // Procesar formulario si se envió
                            if ("actualizar".equals(accion)) {
                                String nuevaPlaca = request.getParameter("nuevaPlaca");
                                String marca = request.getParameter("marca");
                                String referencia = request.getParameter("referencia");
                                String modelo = request.getParameter("modelo");
                                String idTv = request.getParameter("idTv");

                                Connection conn = null;
                                PreparedStatement pstmt = null;

                                try {
                                    String url = "jdbc:mysql://localhost:3306/concesionario";
                                    String usuario = "root";
                                    String password = "";

                                    Class.forName("com.mysql.jdbc.Driver");
                                    conn = DriverManager.getConnection(url, usuario, password);

                                    String sql = "UPDATE vehiculo SET placa=?, marca=?, referencia=?, modelo=?, id_tv=? WHERE placa=?";
                                    pstmt = conn.prepareStatement(sql);
                                    pstmt.setString(1, nuevaPlaca);
                                    pstmt.setString(2, marca);
                                    pstmt.setString(3, referencia);
                                    pstmt.setString(4, modelo);
                                    pstmt.setString(5, idTv);
                                    pstmt.setString(6, placa);

                                    int filasAfectadas = pstmt.executeUpdate();

                                    if (filasAfectadas > 0) {
                            %>
                                        <div class="alert alert-success">
                                            <h4><i class="ace-icon fa fa-check"></i> ¡Éxito!</h4>
                                            El vehículo se actualizó correctamente.
                                        </div>

                                        <div class="center">
                                            <a href="${ctx}/listarVehi.jsp" class="btn btn-primary">
                                                <i class="ace-icon fa fa-arrow-left"></i>
                                                Volver a la lista
                                            </a>
                                            <a href="${ctx}/ver_vehiculo.jsp?placa=<%= nuevaPlaca %>" class="btn btn-info">
                                                <i class="ace-icon fa fa-eye"></i>
                                                Ver vehículo actualizado
                                            </a>
                                        </div>
                            <%
                                    } else {
                            %>
                                        <div class="alert alert-warning">
                                            <h4><i class="ace-icon fa fa-exclamation-triangle"></i> Advertencia</h4>
                                            No se pudo actualizar el vehículo. Verifique los datos.
                                        </div>
                            <%
                                    }
                                } catch (Exception e) {
                            %>
                                    <div class="alert alert-danger">
                                        <h4><i class="ace-icon fa fa-times"></i> Error</h4>
                                        <%= e.getMessage() %>
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
                            }

                            // Mostrar formulario de edición
                            if (placa == null || placa.trim().isEmpty()) {
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
                            } else if (!"actualizar".equals(accion)) {
                                Connection conn = null;
                                PreparedStatement pstmt = null;
                                ResultSet rs = null;

                                try {
                                    String url = "jdbc:mysql://localhost:3306/concesionario";
                                    String usuario = "root";
                                    String password = "";

                                    Class.forName("com.mysql.jdbc.Driver");
                                    conn = DriverManager.getConnection(url, usuario, password);

                                    // Obtener datos del vehículo
                                    String sql = "SELECT * FROM vehiculo WHERE placa = ?";
                                    pstmt = conn.prepareStatement(sql);
                                    pstmt.setString(1, placa);
                                    rs = pstmt.executeQuery();

                                    if (rs.next()) {
                            %>
                                        <div class="widget-box">
                                            <div class="widget-header">
                                                <h4 class="widget-title">
                                                    <i class="ace-icon fa fa-edit"></i>
                                                    Formulario de Edición
                                                </h4>
                                            </div>

                                            <div class="widget-body">
                                                <div class="widget-main">
                                                    <form class="form-horizontal" method="post" action="editar_vehiculo.jsp">
                                                        <input type="hidden" name="placa" value="<%= rs.getString("placa") %>">
                                                        <input type="hidden" name="accion" value="actualizar">

                                                        <div class="form-group">
                                                            <label class="col-sm-3 control-label no-padding-right" for="nuevaPlaca">
                                                                <strong>Placa:</strong>
                                                            </label>
                                                            <div class="col-sm-9">
                                                                <input type="text" id="nuevaPlaca" name="nuevaPlaca"
                                                                       class="form-control"
                                                                       value="<%= rs.getString("placa") %>"
                                                                       placeholder="Ingrese la placa" required maxlength="10">
                                                            </div>
                                                        </div>

                                                        <div class="form-group">
                                                            <label class="col-sm-3 control-label no-padding-right" for="marca">
                                                                <strong>Marca:</strong>
                                                            </label>
                                                            <div class="col-sm-9">
                                                                <input type="text" id="marca" name="marca"
                                                                       class="form-control"
                                                                       value="<%= rs.getString("marca") %>"
                                                                       placeholder="Ingrese la marca" required maxlength="50">
                                                            </div>
                                                        </div>

                                                        <div class="form-group">
                                                            <label class="col-sm-3 control-label no-padding-right" for="referencia">
                                                                <strong>Referencia:</strong>
                                                            </label>
                                                            <div class="col-sm-9">
                                                                <input type="text" id="referencia" name="referencia"
                                                                       class="form-control"
                                                                       value="<%= rs.getString("referencia") %>"
                                                                       placeholder="Ingrese la referencia" required maxlength="50">
                                                            </div>
                                                        </div>

                                                        <div class="form-group">
                                                            <label class="col-sm-3 control-label no-padding-right" for="modelo">
                                                                <strong>Modelo:</strong>
                                                            </label>
                                                            <div class="col-sm-9">
                                                                <input type="number" id="modelo" name="modelo"
                                                                       class="form-control"
                                                                       value="<%= rs.getString("modelo") %>"
                                                                       placeholder="Ingrese el año del modelo" required
                                                                       min="1900" max="2030">
                                                            </div>
                                                        </div>

                                                        <div class="form-group">
                                                            <label class="col-sm-3 control-label no-padding-right" for="idTv">
                                                                <strong>Tipo de Vehículo:</strong>
                                                            </label>
                                                            <div class="col-sm-9">
                                                                <select id="idTv" name="idTv" class="form-control" required>
                                                                    <option value="">Seleccione un tipo</option>
                                                                    <%
                                                                    PreparedStatement pstmtTipos = null;
                                                                    ResultSet rsTipos = null;

                                                                    try {
                                                                        String sqlTipos = "SELECT IdTv, nomTv FROM tipovehi ORDER BY nomTv";
                                                                        pstmtTipos = conn.prepareStatement(sqlTipos);
                                                                        rsTipos = pstmtTipos.executeQuery();

                                                                        String idTvActual = rs.getString("id_tv");

                                                                        while (rsTipos.next()) {
                                                                            String selected = idTvActual.equals(rsTipos.getString("IdTv")) ? "selected" : "";
                                                                    %>
                                                                            <option value="<%= rsTipos.getString("IdTv") %>" <%= selected %>>
                                                                                <%= rsTipos.getString("nomTv") %>
                                                                            </option>
                                                                    <%
                                                                        }
                                                                    } catch (Exception ex) {
                                                                        out.println("<option value=''>Error al cargar tipos</option>");
                                                                    } finally {
                                                                        if (rsTipos != null) rsTipos.close();
                                                                        if (pstmtTipos != null) pstmtTipos.close();
                                                                    }
                                                                    %>
                                                                </select>
                                                            </div>
                                                        </div>

                                                        <div class="clearfix form-actions">
                                                            <div class="col-md-offset-3 col-md-9">
                                                                <button class="btn btn-success" type="submit">
                                                                    <i class="ace-icon fa fa-check bigger-110"></i>
                                                                    Actualizar Vehículo
                                                                </button>

                                                                <a href="${ctx}/listarVehi.jsp" class="btn btn-grey">
                                                                    <i class="ace-icon fa fa-times bigger-110"></i>
                                                                    Cancelar
                                                                </a>

                                                                <a href="${ctx}/ver_vehiculo.jsp?placa=<%= rs.getString("placa") %>" class="btn btn-info">
                                                                    <i class="ace-icon fa fa-eye bigger-110"></i>
                                                                    Ver Detalles
                                                                </a>
                                                            </div>
                                                        </div>
                                                    </form>
                                                </div>
                                            </div>
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
