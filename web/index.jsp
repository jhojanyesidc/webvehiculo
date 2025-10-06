<%-- 
    Document   : index
    Created on : 30/03/2025, 07:50:40 PM
    Author     : wcastro
--%>

<!DOCTYPE html>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<%
  // Evitar que el navegador use caché al volver atrás
  response.setHeader("Cache-Control","no-cache, no-store, must-revalidate");
  response.setHeader("Pragma","no-cache");
  response.setDateHeader ("Expires", 0);
%>

<html lang="es">
  <head>
    <meta charset="UTF-8" />
    <title>SoWil</title>

    <!-- Ejemplo de recursos (usa siempre ${ctx}) -->
    <link rel="stylesheet" href="${ctx}/assets/css/bootstrap.min.css" />
    <link rel="stylesheet" href="${ctx}/assets/css/ace.min.css" />
    <script src="${ctx}/assets/js/app.js"></script>
  </head>

  <body>
    <!-- Forward inmediato al listado (ruta absoluta dentro del contexto) -->
    <jsp:forward page="/listarVehi.jsp" />

    <!-- Contenido de respaldo (solo se vería si el forward fallara) -->
    <header>
      <h1>Hello World! Welcome!!</h1>
      <p><a href="${ctx}/listarVehi.jsp">Ir al listado</a></p>

      <!-- Menú de ejemplo -->
      <!--
      <nav>
        <ul>
          <li>
            <a href="${ctx}/adminTipoVehi?action=nuevotv">Nuevo TV</a>
          </li>
          <li>
            <a href="${ctx}/adminTipoVehi?action=mostrartv">Mostrar TV</a>
          </li>
        </ul>
      </nav>
      -->
    </header>
  </body>
</html>