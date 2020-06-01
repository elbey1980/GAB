/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modele;

import java.sql.Date;

/**
 *
 * @author RAM
 */
public class Operation {
    
private int numOperation;
private Date dateOperation;
private Float montantOperation;
private String typeOperation;
private String numCompte;
private String nomBeneficiaire;

    public Operation(int numOperation, Date dateOperation, Float montantOperation, String typeOperation, String numCompte, String nomBeneficiaire) {
        this.numOperation = numOperation;
        this.dateOperation = dateOperation;
        this.montantOperation = montantOperation;
        this.typeOperation = typeOperation;
        this.numCompte = numCompte;
        this.nomBeneficiaire = nomBeneficiaire;
    }

    public int getNumOperation() {
        return numOperation;
    }

    public void setNumOperation(int numOperation) {
        this.numOperation = numOperation;
    }

    public Date getDateOperation() {
        return dateOperation;
    }

    public void setDateOperation(Date dateOperation) {
        this.dateOperation = dateOperation;
    }

    public Float getMontantOperation() {
        return montantOperation;
    }

    public void setMontantOperation(Float montantOperation) {
        this.montantOperation = montantOperation;
    }

    public String getTypeOperation() {
        return typeOperation;
    }

    public void setTypeOperation(String typeOperation) {
        this.typeOperation = typeOperation;
    }

    public String getNumCompte() {
        return numCompte;
    }

    public void setNumCompte(String numCompte) {
        this.numCompte = numCompte;
    }

    public String getNomBeneficiaire() {
        return nomBeneficiaire;
    }

    public void setNomBeneficiaire(String nomBeneficiaire) {
        this.nomBeneficiaire = nomBeneficiaire;
    }
    

    
}
