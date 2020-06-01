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
public class LimitesOperations {

    private static LimitesOperations uniqueInstance = null;
    // Regles de gestion RBC Banque Royale
    private final Float limiteDepot;
    private final Float limiteFacture;

    public synchronized static LimitesOperations Instance() {
        if (uniqueInstance == null) {
            uniqueInstance = new LimitesOperations();
        }
        return uniqueInstance;
    }

    private LimitesOperations() {
        limiteDepot = 500000f;
        limiteFacture = 99999f;
    }

    public Float getLimiteDepot() {
        return limiteDepot;
    }

    public Float getLimiteFacture() {
        return limiteFacture;
    }

}
