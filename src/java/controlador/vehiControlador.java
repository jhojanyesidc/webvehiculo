/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador;

import dao.vehiDAO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.vehi;

/**
 *
 * @author wcastro
 */
public class vehiControlador extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
           /* out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet vehiControlador</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet vehiControlador at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>"); */
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //processRequest(request, response);
        String Placa = request.getParameter("txtplaca");
        String Marca = request.getParameter("txtmarca");
        String RefMatricula = request.getParameter("txtmatricula");
        String Modelo = request.getParameter("txtmodelo");
        int IdTv = Integer.parseInt(request.getParameter("txtidtv"));
        
        //Tomar el parametro que va a tener accion (registrar, actualizar o eliminar)
        String accion = request.getParameter("accion").toLowerCase();   //para que la accion sea en minuscula independiente de como este'
                
        vehi Vehi = new vehi();        
        //Asignar al objeto los valores que se recogieron en las variables y que vienen del formulario
        Vehi.setPlacavehi(Placa);
        Vehi.setMarcavehi(Marca);
        Vehi.setRefvehi(RefMatricula);
        Vehi.setModelovehi(Modelo);
        Vehi.setId_tv(IdTv);
        
        //Validar cual de las acciones se va a gestionar (controlar) registrar, actualizar o eliminar
        if (accion.equals("registrar")){
            if (vehiDAO.insertarvehi(Vehi)){
                request.setAttribute("mensaje", "Vehiculo registrado");
            }else{
                request.setAttribute("mensaje", "Vehiculo no registrado");
            }
        }else if (accion.equals("actualizar")){
            if (vehiDAO.actualizarvehi(Vehi)){
                request.setAttribute("mensaje", "Vehiculo actualizado");
            }else{
                request.setAttribute("mensaje", "Vehiculo no actualizado");
            }
        }else if (accion.equals("eliminar")){
            if (vehiDAO.eliminarvehi(Vehi)){
                request.setAttribute("mensaje", "Vehiculo eliminado");
            }else{
                request.setAttribute("mensaje", "Vehiculo no eliminado");
            }
        } else if (accion.equals("eliminarUno")){
//            if (vehiDAO.eliminarvehiuno(id)){
//                request.setAttribute("mensaje", "Vehiculo eliminado");
//            }else{
//                request.setAttribute("mensaje", "Vehiculo no eliminado");
//            }
              //int IdVuno = Integer.parseInt(request.getParameter("txtvUno"));
              String PlacaVuno = request.getParameter("txtvUno");
              Vehi.setPlacavehi(PlacaVuno);
              vehiDAO.eliminarvehiuno(PlacaVuno);
            request.getRequestDispatcher("listarVehi.jsp").forward(request, response);
        } else{
            request.setAttribute("mensaje", "Acción no valida");
        }
        request.getRequestDispatcher("registrarVehi.jsp").forward(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
