/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.bilbomatica.controller;

/**
 *
 * @author jafernandez
 */
import com.bilbomatica.dao.IpGeolocationDAO;
import com.bilbomatica.model.IpGeolocation;
import java.sql.SQLException;
import java.util.ArrayList;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestBody;

@RestController
public class ControllerREST {
    @Autowired
    private IpGeolocationDAO ipGeoDAO;
         
    @GetMapping("/tables/{query:.+}")
    public ArrayList<String> getTables(@PathVariable("query") String query) throws SQLException{
        return ipGeoDAO.getTables(query);
    }
    
    @GetMapping("/ips/{query:.+}")
    public ArrayList<IpGeolocation> getIps(@PathVariable("query") String query) throws SQLException{
        return ipGeoDAO.get(query);
    }    
    
    @PostMapping(value = "/ips/{query:.+}")
    public int createIp(@PathVariable("query") String query){
        return ipGeoDAO.executeCRUD(query);        
    }
       
    @DeleteMapping("/ips/{query:.+}")
    public int deleteIp(@PathVariable("query") String query){
        return ipGeoDAO.executeCRUD(query);
    }
    
    @PutMapping("/ips/{query:.+}")
    public int updateIp(@PathVariable String query){
        return ipGeoDAO.executeCRUD(query);
    }
    
    /*    
    @DeleteMapping("/ips/{query:.+}")
    public ResponseEntity deleteIp(@PathVariable String ip){
        if(null == ipGeoDAO.delete(ip)){
            return new ResponseEntity("No Ips found for ip " + ip, HttpStatus.NOT_FOUND);
        }
        return new ResponseEntity(ip, HttpStatus.OK);
    }    
    */
}
