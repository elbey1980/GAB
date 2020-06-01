CREATE SEQUENCE seq_client;
CREATE SEQUENCE seq_operation;
CREATE SEQUENCE seq_adresse;

CREATE TABLE adresse
(
idAdresse VARCHAR2(8) CONSTRAINT pk_adresse PRIMARY KEY, 
porte  VARCHAR2(5) CONSTRAINT nn_adresse_porte NOT NULL,
rue VARCHAR2(50) CONSTRAINT nn_adresse_rue NOT NULL,
appartement VARCHAR2(3),
codePostal VARCHAR2(6) CONSTRAINT nn_adresse_codePostal NOT NULL,
localite VARCHAR2(50) CONSTRAINT nn_adresse_localite NOT NULL,
province VARCHAR2(50) CONSTRAINT nn_adresse_province NOT NULL,
pays VARCHAR2(50) CONSTRAINT nn_adresse_pays NOT NULL
);

CREATE TABLE client
  (
    idClient VARCHAR2(6) CONSTRAINT pk_client_idClient PRIMARY KEY,
    nom VARCHAR2(20) CONSTRAINT nn_client_nom NOT NULL,
	prenom VARCHAR2(20) CONSTRAINT nn_client_prenom NOT NULL,
	dateNaissance date CONSTRAINT nn_client_dateNaissance NOT NULL,
    idAdresse VARCHAR2(8) CONSTRAINT nn_client_idAdresse NOT NULL,
    courriel VARCHAR2(30) CONSTRAINT u_client_Courriel UNIQUE,
	telephone VARCHAR2(10),
	CONSTRAINT fk_client_idAdresse FOREIGN KEY (idAdresse) REFERENCES adresse(idAdresse)
  );
  
 CREATE INDEX ind_client_idClient
ON client(idClient); 

CREATE TABLE beneficiaire
(
nomBeneficiaire  VARCHAR2(50) CONSTRAINT pk_beneficiaire PRIMARY KEY,   
telephone VARCHAR2(70) CONSTRAINT u_beneficiaire_telephone UNIQUE,
idAdresse VARCHAR2(8) CONSTRAINT nn_beneficiaire_idAdresse NOT NULL,
CONSTRAINT fk_benef_idAdresse FOREIGN KEY (idAdresse) REFERENCES adresse(idAdresse)
);


CREATE TABLE compte 
(
numCompte VARCHAR2(16) CONSTRAINT pk_compte_numCompte PRIMARY KEY,
nip VARCHAR2(4) CONSTRAINT nn_compte_nip NOT NULL,
solde NUMBER(8,2)DEFAULT 0 CONSTRAINT nn_compte_solde NOT NULL,
typeCompte VARCHAR2(7) CONSTRAINT ck_compte_typeCompte CHECK (UPPER(typeCompte) IN ('CHEQUE','EPARGNE'))
                       CONSTRAINT nn_compte_typeCompte NOT NULL,
idClient VARCHAR2(6) CONSTRAINT nn_compte_idClient NOT NULL,
CONSTRAINT fk_client_idClient FOREIGN KEY (idClient) REFERENCES client(idClient)
);

CREATE TABLE typeOperation
(
codeOperation VARCHAR2(2) CONSTRAINT pk_typeOperation PRIMARY KEY, 
designation VARCHAR2(20) CONSTRAINT nn_typeOperation_designation NOT NULL
);

CREATE TABLE operation 
(
numOperation NUMBER(10),  
dateOperation DATE DEFAULT SYSDATE  CONSTRAINT nn_operation_dateOperation NOT NULL,
montantOperation NUMBER(8,2) CONSTRAINT ck_operation_montantOperation CHECK (montantOperation > 0)
							 CONSTRAINT nn_operation_montantOperation NOT NULL, 
typeOperation VARCHAR2(2) CONSTRAINT ck_operation_typeOperation CHECK (UPPER(typeOperation) IN ('R','D','P','V'))
                          CONSTRAINT nn_compte_typeOperation NOT NULL,
numCompte VARCHAR2(16),
nomBeneficiaire  VARCHAR2(50),  /* this FOREIGN KEY may be null   */
CONSTRAINT fk_operation_numCompte FOREIGN KEY (numCompte) REFERENCES compte(numCompte),
CONSTRAINT fk_operation_typeOperation FOREIGN KEY (typeOperation) REFERENCES typeOperation(codeOperation),
CONSTRAINT pk_operation_numOperation PRIMARY KEY (numOperation,numCompte),
CONSTRAINT fk_operation_nomBeneficiaire FOREIGN KEY (nomBeneficiaire) REFERENCES beneficiaire(nomBeneficiaire)

);

ALTER TABLE compte 
ADD (limiteOperation NUMBER(8,2) DEFAULT 500 CONSTRAINT nn_compte_limiteOperation NOT NULL
                                           CONSTRAINT ck_compte_limiteOperation CHECK (limiteOperation BETWEEN 500 AND 2000));

