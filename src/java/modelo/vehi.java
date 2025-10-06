/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;

import java.io.Serializable;

/**
 *
 * @author wcastro
 */
public class vehi implements Serializable{
    String placavehi;
    String marcavehi;
    String refvehi;
    String modelovehi;    
    int id_tv;
    
     public vehi() {
        this.placavehi = "";
        this.marcavehi = "";
        this.refvehi = "";
        this.modelovehi = "";        
        this.id_tv = 0;
    }

    public vehi(String placavehi, String marcavehi, String refvehi, String modelovehi, int id_tv) {
        this.placavehi = placavehi;
        this.marcavehi = marcavehi;
        this.refvehi = refvehi;
        this.modelovehi = modelovehi;        
        this.id_tv = id_tv;
    }

    public String getPlacavehi() {
        return placavehi;
    }

    public void setPlacavehi(String placavehi) {
        this.placavehi = placavehi;
    }

    public String getMarcavehi() {
        return marcavehi;
    }

    public void setMarcavehi(String marcavehi) {
        this.marcavehi = marcavehi;
    }

    public String getRefvehi() {
        return refvehi;
    }

    public void setRefvehi(String refvehi) {
        this.refvehi = refvehi;
    }

    public String getModelovehi() {
        return modelovehi;
    }

    public void setModelovehi(String modelovehi) {
        this.modelovehi = modelovehi;
    }

    public int getId_tv() {
        return id_tv;
    }

    public void setId_tv(int id_tv) {
        this.id_tv = id_tv;
    }
}
