/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package listner;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

/**
 * Web application lifecycle listener.
 *
 * @author RAM
 */
public class connexionBD implements HttpSessionListener {

    private Connection con = null;
    static PreparedStatement stm = null;
    static ResultSet rs = null;
    ServletContext ctx = null;

    @Override
    public void sessionCreated(HttpSessionEvent se) {
        ctx = se.getSession().getServletContext();
        try {
            Class.forName("oracle.jdbc.OracleDriver");
            con = DriverManager.getConnection("jdbc:oracle:thin:@144.217.163.57:1521:XE", "mohamed", "anypw");
            ctx.setAttribute("Connection", con);
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(connexionBD.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent se) {
        if (rs != null) {
            try {
                rs.close();
            } catch (SQLException ex) {
            }
        }
        if (stm != null) {
            try {
                stm.close();
            } catch (SQLException ex) {
            }
        }
        if (con != null) {
            try {
                stm.close();
            } catch (SQLException ex) {
            }
        }
    }
}
