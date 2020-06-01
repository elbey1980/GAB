/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modele;

/**
 *
 * @author RAM
 */
public class Adresse {
    private String idAdresse;
    private String porte;
    private String rue;
    private String appartement;
    private String codePostal;
    private String localite;
    private String province;
    private String pays;

    public Adresse(String idAdresse, String porte, String rue, String appartement, String codePostal, String localite, String province, String pays) {
        this.idAdresse = idAdresse;
        this.porte = porte;
        this.rue = rue;
        this.appartement = appartement;
        this.codePostal = codePostal;
        this.localite = localite;
        this.province = province;
        this.pays = pays;
    }

    public Adresse() {
    }

    
    public String getIdAdresse() {
        return idAdresse;
    }

    public void setIdAdresse(String idAdresse) {
        this.idAdresse = idAdresse;
    }

    public String getPorte() {
        return porte;
    }

    public void setPorte(String porte) {
        this.porte = porte;
    }

    public String getRue() {
        return rue;
    }

    public void setRue(String rue) {
        this.rue = rue;
    }

    public String getAppartement() {
        return appartement;
    }

    public void setAppartement(String appartement) {
        this.appartement = appartement;
    }

    public String getCodePostal() {
        return codePostal;
    }

    public void setCodePostal(String codePostal) {
        this.codePostal = codePostal;
    }

    public String getLocalite() {
        return localite;
    }

    public void setLocalite(String localite) {
        this.localite = localite;
    }

    public String getProvince() {
        return province;
    }

    public void setProvince(String province) {
        this.province = province;
    }

    public String getPays() {
        return pays;
    }

    public void setPays(String pays) {
        this.pays = pays;
    }
    
    

    
}
