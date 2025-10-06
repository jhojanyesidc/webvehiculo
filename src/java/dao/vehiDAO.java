/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import modelo.vehi;

/**
 *
 * @author wcastro
 */
public class vehiDAO {
    //Metodo Insert
    public static boolean insertarvehi(vehi v){
        try {            
            Connection cone = conexionLib.conectarnosBD();             
            //String SQL = "INSERT INTO tbl_vehi (idvehi,marca,modelo,matricula,anio,id_tv) VALUES(?,?,?,?,?,?)";
            //String SQLUno = "INSERT INTO tbl_vehi VALUES(?,?,?,?,(select now()),?)";   //(select now()) es para llevar la fecha del sistema como value a un campo tipo datetime
            //Cuando se insertan todo los values en una tabla tambien se puede de la siguiente forma
            String SQL = "INSERT INTO vehiculo VALUES(?,?,?,?,?)";
            PreparedStatement ps = cone.prepareStatement(SQL);
                        
            ps.setString(1, v.getPlacavehi());
            ps.setString(2, v.getMarcavehi());
            ps.setString(3, v.getRefvehi());
            ps.setString(4, v.getModelovehi());
            ps.setInt(5, v.getId_tv());            
                        
            if (ps.executeUpdate() > 0){
                return true;
            } else{
                return false;
            }             
            
        } catch (SQLException ex) {
            //System.out.println(ex);
            return false;
        }
        //return false;
    }
    
    //Metodo listar
    public static List<vehi> listarV() {
        List<vehi> lista = new ArrayList<>();
        String sql = "SELECT placa, marca, referencia, modelo, id_tv FROM vehiculo ORDER BY placa";

        try (Connection con = conexionLib.conectarnosBD();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                vehi v = new vehi();
                v.setPlacavehi(rs.getString("placa"));
                v.setMarcavehi(rs.getString("marca"));
                v.setRefvehi(rs.getString("referencia"));
                v.setModelovehi(rs.getString("modelo"));
                v.setId_tv(rs.getInt("id_tv"));
                lista.add(v);
            }
        } catch (SQLException e) {
            e.printStackTrace(); // mira el log catalina.out si algo falla
        }
        return lista;
    }

    //Metodo Update
    public static boolean actualizarvehi(vehi v){
        try {            
            Connection cone = conexionLib.conectarnosBD();
            String SQL = "update vehiculo set " +
                "    marca=?," +
                "    referencia=?," +
                "    modelo=?," +
                "    id_tv=?" +
                "    where placa=?";
            PreparedStatement ps = cone.prepareStatement(SQL);
                        
            ps.setString(1, v.getMarcavehi());
            ps.setString(2, v.getRefvehi());
            ps.setString(3, v.getModelovehi());
            ps.setInt(4, v.getId_tv());
            ps.setString(5, v.getPlacavehi());

            if (ps.executeUpdate() > 0){
                return true;
            } else{
                return false;
            }             
            
        } catch (SQLException ex) {
            //System.out.println(ex);
            return false;
        }
        //return false;
    }
    
    //Metodo Eliminar
    public static boolean eliminarvehi(vehi v){
        try {            
            Connection cone = conexionLib.conectarnosBD();
            String SQL = "delete from vehiculo where placa=?";
            PreparedStatement ps = cone.prepareStatement(SQL);
            ps.setString(1, v.getPlacavehi());
                        
            if (ps.executeUpdate() > 0){
                return true;
            } else{
                return false;
            }             
            
        } catch (SQLException ex) {
            //System.out.println(ex);
            return false;
        }
        //return false;
    }
    
    //Metodo EliminarUno
    public static boolean eliminarvehiuno(String placavehi){
        try {
            Connection cone = conexionLib.conectarnosBD();
            String SQL = "delete from vehiculo where placa=?";
            PreparedStatement ps = cone.prepareStatement(SQL);
            ps.setString(1, placavehi);

            if (ps.executeUpdate() > 0){
                return true;
            } else{
                return false;
            }             
            
        } catch (SQLException ex) {            
            return false;
        }        
    }
}
