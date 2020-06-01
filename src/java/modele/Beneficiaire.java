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
public class Beneficiaire {

    private String nomBeneficiaire;
    private String telephone;
    private String idAdresse;

    public String getNomBeneficiaire() {
        return nomBeneficiaire;
    }

    public void setNomBeneficiaire(String nomBeneficiaire) {
        this.nomBeneficiaire = nomBeneficiaire;
    }

    public String getTelephone() {
        return telephone;
    }

    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    public String getIdAdresse() {
        return idAdresse;
    }

    public void setIdAdresse(String idAdresse) {
        this.idAdresse = idAdresse;
    }

    public Beneficiaire(String nomBenificiaire, String telephone, String idAdresse) {
        this.nomBeneficiaire = nomBenificiaire;
        this.telephone = telephone;
        this.idAdresse = idAdresse;
    }

    public Beneficiaire() {
    }

}
