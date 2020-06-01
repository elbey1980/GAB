package dao;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import modele.Beneficiaire;
import modele.*;

/**
 *
 * @author RAM
 */
public class DAO {

    public Compte checkPassword(String numcompte, String nip, Connection con) {
        String idClient = "", typeCompte = "";
        Float solde = 0f, limiteOperation = 0f;
        Compte ompte = new Compte();
        try {
            String sql = "select * from compte "
                    + "where numcompte=? and nip=? ";
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setString(1, numcompte);
            stm.setString(2, nip);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                numcompte = rs.getString("numCompte");
                nip = rs.getString("nip");
                solde = rs.getFloat("solde");
                typeCompte = rs.getString("typeCompte");
                idClient = rs.getString("idClient");
                limiteOperation = rs.getFloat("limiteOperation");
            }
            if (!rs.wasNull()) {
                ompte = new Compte(numcompte, idClient, nip, solde, typeCompte, limiteOperation);
            }
            return ompte;
        } catch (SQLException ex) {
            Logger.getLogger(DAO.class.getName()).log(Level.SEVERE,
                    null, ex);
        }
        return ompte;
    }

    public Client singleClient(String idClient, Connection con) {
        String nom = "", prenom = "", idAdresse = "", courriel = "", telephone = "";
        Date dateNaissance = Date.valueOf("2019-09-23");
        Client client = new Client();
        try {
            String sql = "select * from client "
                    + "where idClient=? ";
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setString(1, idClient);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                idClient = rs.getString("idClient");
                nom = rs.getString("nom");
                prenom = rs.getString("prenom");
                dateNaissance = rs.getDate("dateNaissance");
                idAdresse = rs.getString("idAdresse");
                courriel = rs.getString("courriel");
                telephone = rs.getString("telephone");
            }
            if (!rs.wasNull()) {
                client = new Client(idClient, nom, prenom, dateNaissance, idAdresse, courriel, telephone);
            }
            return client;
        } catch (SQLException ex) {
            Logger.getLogger(DAO.class.getName()).log(Level.SEVERE,
                    null, ex);
        }
        return client;
    }

    public Float insertOperation(Float montant,
            String type, String compte, String beneficiaire, Connection con) throws SQLException, ClassNotFoundException {
        try {
            String sql = "insert into operation values (seq_operation.nextval,sysdate,?,?,?,?)";
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setFloat(1, montant);
            stm.setString(2, type);
            stm.setString(3, compte);
            stm.setString(4, beneficiaire);
            stm.executeUpdate();
            if (type == "D") {
                return updateSolde(compte, montant, con);
            } else {
                return updateSolde(compte, -montant, con);
            }
        } finally {
        }
    }

    public Float updateSolde(String compte, Float montant, Connection con) {
        Float solde = 0f;
        try {
            String sql = "update compte "
                    + "set solde=solde+? "
                    + "where numcompte=? ";
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setString(2, compte);
            stm.setFloat(1, montant);
            stm.executeUpdate();
            sql = "select * from compte "
                    + "where numcompte=? ";
            stm = con.prepareStatement(sql);
            stm.setString(1, compte);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                solde = rs.getFloat("solde");
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAO.class.getName()).log(Level.SEVERE,
                    null, ex);
        }
        return solde;
    }

    public boolean chnagerPassword(String compte, String nip, Connection con) {
        boolean confirm = false;
        try {
            String sql = "update compte "
                    + "set nip=? "
                    + "where numcompte=? ";
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setString(2, compte);
            stm.setString(1, nip);
            stm.executeUpdate();
            confirm = true;
        } catch (SQLException ex) {
            Logger.getLogger(DAO.class.getName()).log(Level.SEVERE,
                    null, ex);
        }
        return confirm;
    }

    public List listBeneficiaire(Connection con) {
        List<Beneficiaire> liste = new ArrayList<>();
        try {
            String sql = "select nomBeneficiaire from beneficiaire ";
            PreparedStatement stm = con.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                liste.add(new Beneficiaire(rs.getString("nomBeneficiaire"), null, null));
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAO.class.getName()).log(Level.SEVERE,
                    null, ex);
        }
        return liste;
    }

    public Compte singleAccount(String numcompte, Connection con) {
        String idClient = "", typeCompte = "";
        String nip = "";
        Float solde = 0f, limiteOperation = 0f;
        Compte ompte = new Compte();
        try {
            String sql = "select * from compte "
                    + "where numcompte=? ";
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setString(1, numcompte);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                numcompte = rs.getString("numCompte");
                nip = rs.getString("nip");
                solde = rs.getFloat("solde");
                typeCompte = rs.getString("typeCompte");
                idClient = rs.getString("idClient");
                limiteOperation = rs.getFloat("limiteOperation");
            }
            if (!rs.wasNull()) {
                ompte = new Compte(numcompte, idClient, nip, solde, typeCompte, limiteOperation);
            }
            return ompte;
        } catch (SQLException ex) {
            Logger.getLogger(DAO.class.getName()).log(Level.SEVERE,
                    null, ex);
        }
        return ompte;
    }

    public List listOperations(String numcompte, String debut, String fin, Connection con) throws ParseException {

        List liste = new ArrayList();
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        java.util.Date startDate = formatter.parse(debut);
        java.util.Date endDate = formatter.parse(fin);
        try {
            String sql = "select * from operation "
                    + "where dateOperation between  ? and ? ";
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setDate(1, new java.sql.Date(startDate.getTime()));
            stm.setDate(2, new java.sql.Date(endDate.getTime()));
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                int numOperation = rs.getInt("numOperation");
                if (!rs.wasNull()) {
                    liste.add(new Operation(rs.getInt("numOperation"), rs.getDate("dateOperation"),
                            rs.getFloat("montantOperation"), rs.getString("typeOperation"),
                            rs.getString("numCompte"), rs.getString("nomBeneficiaire")));
                }
            }
            return liste;
        } catch (SQLException ex) {
            Logger.getLogger(DAO.class.getName()).log(Level.SEVERE,
                    null, ex);
        }
        return liste;
    }

    public Adresse getAdresse(String idAdresse, Connection con) throws ParseException {
        Adresse adresse = new Adresse();
        try {
            String sql = "select * from adresse "
                    + "where idAdresse=? ";
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setString(1, idAdresse);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                adresse = new Adresse(rs.getString("idAdresse"), rs.getString("porte"), rs.getString("rue"),
                        rs.getString("appartement"), rs.getString("codePostal"), rs.getString("localite"),
                        rs.getString("province"), rs.getString("pays"));
            }
            return adresse;
        } catch (SQLException ex) {
            Logger.getLogger(DAO.class.getName()).log(Level.SEVERE,
                    null, ex);
        }
        return adresse;
    }
}
