package controlador;

import dao.tipoVehiDAO;
import dao.vehiDAO;
import modelo.tipovehi;
import modelo.vehi;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/api/*")
public class RestAPIController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json;charset=UTF-8");
        response.setHeader("Access-Control-Allow-Origin", "*");
        response.setHeader("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS");
        response.setHeader("Access-Control-Allow-Headers", "Content-Type");

        String pathInfo = request.getPathInfo();
        PrintWriter out = response.getWriter();

        try {
            if (pathInfo == null || pathInfo.equals("/")) {
                out.print("{\"message\":\"API FlotaVehiculo v1.0\",\"endpoints\":[\"/vehiculos\",\"/tipos\"]}");
            } else if (pathInfo.equals("/vehiculos")) {
                List<vehi> vehiculos = vehiDAO.listarV();
                out.print(vehiculosToJson(vehiculos));
            } else if (pathInfo.equals("/tipos")) {
                List<tipovehi> tipos = tipoVehiDAO.listarTv();
                out.print(tiposToJson(tipos));
            } else {
                response.setStatus(404);
                out.print("{\"error\":\"Endpoint no encontrado\"}");
            }
        } catch (Exception e) {
            response.setStatus(500);
            out.print("{\"error\":\"Error interno del servidor: " + e.getMessage() + "\"}");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json;charset=UTF-8");
        response.setHeader("Access-Control-Allow-Origin", "*");

        String pathInfo = request.getPathInfo();
        PrintWriter out = response.getWriter();

        try {
            if (pathInfo.equals("/vehiculos")) {
                // Crear nuevo vehículo
                String placa = request.getParameter("placa");
                String marca = request.getParameter("marca");
                String referencia = request.getParameter("referencia");
                String modelo = request.getParameter("modelo");
                int idTv = Integer.parseInt(request.getParameter("id_tv"));

                vehi nuevoVehi = new vehi(placa, marca, referencia, modelo, idTv);

                if (vehiDAO.insertarvehi(nuevoVehi)) {
                    response.setStatus(201);
                    out.print("{\"message\":\"Vehículo creado exitosamente\",\"placa\":\"" + placa + "\"}");
                } else {
                    response.setStatus(400);
                    out.print("{\"error\":\"No se pudo crear el vehículo\"}");
                }
            } else if (pathInfo.equals("/tipos")) {
                // Crear nuevo tipo de vehículo
                int idTv = Integer.parseInt(request.getParameter("idTv"));
                String nomTv = request.getParameter("nomTv");

                tipovehi nuevoTipo = new tipovehi(idTv, nomTv);

                if (tipoVehiDAO.insertartv(nuevoTipo)) {
                    response.setStatus(201);
                    out.print("{\"message\":\"Tipo de vehículo creado exitosamente\",\"id\":\"" + idTv + "\"}");
                } else {
                    response.setStatus(400);
                    out.print("{\"error\":\"No se pudo crear el tipo de vehículo\"}");
                }
            } else {
                response.setStatus(404);
                out.print("{\"error\":\"Endpoint no encontrado\"}");
            }
        } catch (Exception e) {
            response.setStatus(500);
            out.print("{\"error\":\"Error interno del servidor: " + e.getMessage() + "\"}");
        }
    }

    @Override
    protected void doOptions(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setHeader("Access-Control-Allow-Origin", "*");
        response.setHeader("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS");
        response.setHeader("Access-Control-Allow-Headers", "Content-Type");
        response.setStatus(200);
    }

    // Método para convertir lista de vehículos a JSON manualmente
    private String vehiculosToJson(List<vehi> vehiculos) {
        StringBuilder json = new StringBuilder("[");
        for (int i = 0; i < vehiculos.size(); i++) {
            vehi v = vehiculos.get(i);
            if (i > 0) json.append(",");
            json.append("{")
                .append("\"placa\":\"").append(v.getPlacavehi()).append("\",")
                .append("\"marca\":\"").append(v.getMarcavehi()).append("\",")
                .append("\"referencia\":\"").append(v.getRefvehi()).append("\",")
                .append("\"modelo\":\"").append(v.getModelovehi()).append("\",")
                .append("\"id_tv\":").append(v.getId_tv()).append(",")
                .append("\"tipo\":\"").append(tipoVehiDAO.getTipoVehi(v.getId_tv())).append("\"")
                .append("}");
        }
        json.append("]");
        return json.toString();
    }

    // Método para convertir lista de tipos a JSON manualmente
    private String tiposToJson(List<tipovehi> tipos) {
        StringBuilder json = new StringBuilder("[");
        for (int i = 0; i < tipos.size(); i++) {
            tipovehi t = tipos.get(i);
            if (i > 0) json.append(",");
            json.append("{")
                .append("\"idTv\":").append(t.getIdtv()).append(",")
                .append("\"nomTv\":\"").append(t.getNomtv()).append("\"")
                .append("}");
        }
        json.append("]");
        return json.toString();
    }
}
