/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author wcastro
 */
public class conexionLib {

    // Configuración para XAMPP (usuario root sin contraseña)
    private static final String URL =
            "jdbc:mysql://localhost:3306/concesionario"
                    + "?useSSL=false&allowPublicKeyRetrieval=true"
                    + "&serverTimezone=UTC&characterEncoding=UTF-8";
    private static final String USER = "root";        // Usuario por defecto de XAMPP
    private static final String PASS = "";            // Sin contraseña en XAMPP

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver"); // Driver moderno
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("MySQL/MariaDB JDBC driver no encontrado", e);
        }
    }

    public static Connection conectarnosBD() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASS);
    }
    
    /*Connection con = null;
    public conexionLib(){
        try {
            //Por medio del driver conectarse al server y bd que se le indique
            Class.forName("com.mysql.jdbc.Driver");
            //Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/concesionario", "root", "");
            //con = DriverManager.getConnection("jdbc:mysql://localhost:3306/flotavehiculo?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", "root", "");
            //con = DriverManager.getConnection("jdbc:mysql://localhost:3306/concesionario?zeroDateTimeBehavior=convertToNull", "root", "");
            boolean ok = con.isValid(5000);
            System.out.println(ok ? "Conexión bien" : "Conexión Fallo");
            //if (con != null){
                //System.out.println("Conexion Ok");
            //}
        } catch (SQLException ex) {
            System.out.println("Mensaje " + ex.getMessage());
        } catch (ClassNotFoundException e){
            System.out.println("Mensaje " + e.getMessage());
        }  
    }
    
    public Connection getConnection(){
        return con;
    } */
}