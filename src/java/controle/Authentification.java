/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controle;

import dao.DAO;
import java.io.IOException;
import java.sql.Connection;
import java.text.ParseException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import modele.Beneficiaire;
import modele.Client;
import modele.Compte;
import modele.LimitesOperations;

/**
 *
 * @author RAM
 */
public class Authentification extends HttpServlet {

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
            throws ServletException, IOException, ParseException {
        response.setContentType("text/html;charset=UTF-8");
        ServletContext ctx = getServletContext();
        Connection con = (Connection) ctx.getAttribute("Connection");
        HttpSession session = request.getSession();
        DAO dao = new DAO();
        LimitesOperations limitesOperations = LimitesOperations.Instance();
        List<Beneficiaire> liste = dao.listBeneficiaire(con);
        session.setAttribute("liste", liste);
        String numcompte = request.getParameter("numcompte");
        Compte compte = dao.singleAccount(numcompte, con);
        session.setAttribute("langue", request.getParameter("langue"));
        Client client = dao.singleClient(compte.getIdClient(), con);
        session.setAttribute("nom", client.getNom());
        session.setAttribute("prenom", client.getPrenom());
        session.setAttribute("solde", compte.getSolde());
        session.setAttribute("compte", compte);
        session.setAttribute("nip", compte.getNip());
        session.setAttribute("limiteOperation", compte.getLimiteOperation());
        session.setAttribute("numcompte", request.getParameter("numcompte"));
        session.setAttribute("typecompte", compte.getTypecompte());
        session.setAttribute("limiteDepot", limitesOperations.getLimiteDepot());
        session.setAttribute("limiteFacture", limitesOperations.getLimiteFacture());
        session.setAttribute("adresse", dao.getAdresse(client.getIdAdresse(), con));
        RequestDispatcher rd = request.getRequestDispatcher("WEB-INF/jsp/services.jsp");
        rd.forward(request, response);
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
        } catch (ParseException ex) {
            Logger.getLogger(Authentification.class.getName()).log(Level.SEVERE, null, ex);
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
        } catch (ParseException ex) {
            Logger.getLogger(Authentification.class.getName()).log(Level.SEVERE, null, ex);
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
