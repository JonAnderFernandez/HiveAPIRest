/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.bigdata.dao;

/**
 *
 * @author jafernandez
 */
import com.bigdata.model.IpGeolocation;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.springframework.stereotype.Component;

@Component
public class IpGeolocationDAO {

    private static final String JDBC_DRIVER_NAME = "org.apache.hive.jdbc.HiveDriver";
    private static final String hiveURL = "jdbc:hive2://lug040.zylk.net:10000/;ssl=false";

    public ArrayList<IpGeolocation> get(String q) {
        ArrayList<IpGeolocation> ipGeos = new ArrayList<IpGeolocation>();
        ResultSet rst;
        try {
            Class.forName(JDBC_DRIVER_NAME);
            Connection cnn = DriverManager.getConnection(hiveURL, "hive", "");
            Statement stmt = cnn.createStatement();
            rst = stmt.executeQuery(q);
            while (rst.next()) {
                IpGeolocation ig = new IpGeolocation(
                        rst.getString(1), rst.getString(2), rst.getString(3),
                        rst.getString(4), rst.getString(5), rst.getString(6),
                        rst.getString(7), rst.getFloat(8), rst.getFloat(9),
                        rst.getInt(10), rst.getFloat(11), rst.getString(12),
                        rst.getString(13), rst.getString(14), rst.getString(15));
                ipGeos.add(ig);
            }
            cnn.close();
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(IpGeolocationDAO.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(IpGeolocationDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return ipGeos;
    }

    public int executeCRUD(String q) {
        int i = 0;
        try {
            Class.forName(JDBC_DRIVER_NAME);
            Connection cnn = DriverManager.getConnection(hiveURL, "hive", "");
            Statement stmt = cnn.createStatement();
            i = stmt.executeUpdate(q);
            cnn.close();
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(IpGeolocationDAO.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(IpGeolocationDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return i;
    }
}