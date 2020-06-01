/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controle;

import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import dao.DAO;
import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.text.ParseException;
import javax.servlet.ServletContext;
import modele.LimitesOperations;
import java.text.SimpleDateFormat;
//import java.util.Date;  

/**
 *
 * @author RAM
 */
public class Controleur extends HttpServlet {

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
            throws ServletException, IOException, ClassNotFoundException, SQLException, ParseException {

        response.setContentType("text/html;charset=UTF-8");
        String action = request.getParameter("action");
        String destination = "WEB-INF/jsp/" + action + ".jsp";
        HttpSession session = request.getSession();
        session.setAttribute("NumberFormatException", null);
        ServletContext ctx = getServletContext();
        Connection con = (Connection) ctx.getAttribute("Connection");
        try {
            DAO dao = new DAO();
            LimitesOperations limitesOperations = LimitesOperations.Instance();
            if ((action == null) || (action.length() < 1)) {
                action = "default";
            }
            if ("retour".equals(action)) {
                destination = "WEB-INF/jsp/services.jsp";
                session.setAttribute("ErreurRetrait", "1");
                session.setAttribute("ErreurDepot", "1");
                session.setAttribute("ErreurPaiement", "1");
            } else if ("retrait".equals(action)) {
                if ((Float.parseFloat(request.getParameter("Montant")) > 0) && ((Float) (session.getAttribute("solde")) - Float.parseFloat(request.getParameter("Montant")) >= 0)
                        && (Float) (session.getAttribute("limiteOperation")) >= Float.parseFloat(request.getParameter("Montant"))) {
                    session.setAttribute("solde", dao.insertOperation(Float.parseFloat(request.getParameter("Montant")), "R", (String) session.getAttribute("numcompte"), null, con));
                    destination = "WEB-INF/jsp/services.jsp";
                }
                session.setAttribute("ErreurRetrait", request.getParameter("Montant"));
            } else if ("depot".equals(action)) {
                if ((Float.parseFloat(request.getParameter("Montant")) > 0)
                        && (Float.parseFloat(request.getParameter("Montant")) <= limitesOperations.getLimiteDepot())) {
                    session.setAttribute("solde", dao.insertOperation(Float.parseFloat(request.getParameter("Montant")), "D", (String) session.getAttribute("numcompte"), null, con));
                    destination = "WEB-INF/jsp/services.jsp";
                }
                session.setAttribute("ErreurDepot", request.getParameter("Montant"));
            } else if ("paiement".equals(action)) {
                if ((Float.parseFloat(request.getParameter("Montant")) > 0)
                        && (Float.parseFloat(request.getParameter("Montant")) <= limitesOperations.getLimiteFacture())
                        && ((Float) (session.getAttribute("solde")) - Float.parseFloat(request.getParameter("Montant")) >= 0)) {
                    session.setAttribute("solde", dao.insertOperation(Float.parseFloat(request.getParameter("Montant")), "P", (String) session.getAttribute("numcompte"), request.getParameter("Beneficiaire"), con));
                    destination = "WEB-INF/jsp/services.jsp";
                }
                session.setAttribute("ErreurPaiement", request.getParameter("Montant"));
            } else if ("Parametres".equals(action)) {
                if ((request.getParameter("ANIP").equals((session.getAttribute("nip"))))
                        && (request.getParameter("NNIP").equals((request.getParameter("CNIP"))))
                        && (dao.chnagerPassword((String) session.getAttribute("numcompte"), request.getParameter("NNIP"), con))) {
                    session.setAttribute("nip", request.getParameter("NNIP"));
                    request.setAttribute("anip", request.getParameter("NNIP"));
                    request.setAttribute("nnip", request.getParameter("NNIP"));
                    request.setAttribute("cnip", request.getParameter("NNIP"));
                } else {
                    request.setAttribute("anip", request.getParameter("ANIP"));
                    request.setAttribute("nnip", request.getParameter("NNIP"));
                    request.setAttribute("cnip", request.getParameter("CNIP"));
                }// request.getParameter("debut") request.getParameter("fin")
            } else if ("releve".equals(action)) {
                request.setAttribute("resultat", dao.listOperations((String) session.getAttribute("numcompte"),request.getParameter("debut") ,request.getParameter("fin"), con));
                destination = "WEB-INF/jsp/releve.jsp";

            }
        } catch (NumberFormatException e) {
            session.setAttribute("NumberFormatException", "Digital format error");
        } finally {
            dispatch(destination, request, response);
        }
    }

    protected void dispatch(String destination, HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {
        if (destination != null) {
            RequestDispatcher rd = request.getRequestDispatcher(destination);
            rd.forward(request, response);
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
        try {
            processRequest(request, response);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(Controleur.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(Controleur.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ParseException ex) {
            Logger.getLogger(Controleur.class.getName()).log(Level.SEVERE, null, ex);
        }
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
        try {
            processRequest(request, response);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(Controleur.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(Controleur.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ParseException ex) {
            Logger.getLogger(Controleur.class.getName()).log(Level.SEVERE, null, ex);
        }
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
