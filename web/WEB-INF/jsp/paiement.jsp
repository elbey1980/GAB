<%-- 
    Document   : paiement
    Created on : 2019-09-25, 14:26:44
    Author     : RAM
Beneficiaire.selectedIndex
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <fmt:setLocale  value="${sessionScope.langue}"  />
    <fmt:bundle basename="/i18n/app">
        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <title><fmt:message key="msg8"/></title>
            <link rel="stylesheet" type="text/css" href="css/css1">
            <script>
                function initRequest() {
                    if (window.XMLHttpRequest) {
                        if (navigator.userAgent.indexOf('MSIE') != -1) {
                            isIE = true;
                        }
                        return new XMLHttpRequest();
                    } else if (window.ActiveXobject) {
                        isIE = true;
                        return new ActiveXObject("Microsoft.XMLHTTP");
                    }
                }
                var requete;
                function changeLanguage()
                {
                    requete = new XMLHttpRequest();
                    url = "changeLaguage";
                    requete.open("POST", url, true);
                    requete.onreadystatechange = afficher;
                    requete.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
                    requete.send(null);
                }
                function afficher() {
                    if ((requete.readyState == 4) && (requete.status == 200))
                        document.location.reload(false);
                }
            </script>
        </head>
        <body>
            <a href="javascript:changeLanguage()" class="text-block2"><b><fmt:message key="msg36"/></b></a> 
            <div class="main1">
                <div id="3">
                    <form action="Controleur?action=paiement" method="post" >
                        <div>
                            <h1 class="l1" align="center" ><fmt:message key="msg8"/></h1>
                        </div>
                        <div>
                            <label for="mail"><fmt:message key="msg5"/> ${sessionScope.solde}$ </label> 
                        </div>
                        <div class="text-block4">
                            <table>
                                <tr>    
                                    <td><fmt:message key="msg12"/>  ${sessionScope.prenom}  ${sessionScope.nom}
                                </tr>
                                <tr>
                                    <td><fmt:message key="msg4"/>  ${sessionScope.typecompte}  :  ${sessionScope.numcompte}
                                </tr>		
                            </table>	
                        </div>
                        <div>
                            <label for="mail"><fmt:message key="msg26"/></label>
                            <select class="a1"  name="Beneficiaire"  required>
                                <option></option>
                                <c:forEach var="benef" items="${sessionScope.liste}">
                                    <option value="${benef.nomBeneficiaire}">${benef.nomBeneficiaire}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div>
                            <label for="msg"><fmt:message key="msg28"/></label>   
                            <input type="text" placeholder="<fmt:message key="msg23"/>" id="txtPayer" name="Montant" maxlength="6" required>
                        </div>
                        <div class="button">
                            <button type="submit"><fmt:message key="msg37"/> </button><button onclick="location.href = 'Controleur?action=retour'" > <fmt:message key="msg35"/> </button>
                            <font color="red"><c:if test="${sessionScope.solde < sessionScope.ErreurPaiement}"> <fmt:message key="msg16"/> </c:if>
                            <c:if test="${sessionScope.limiteFacture < sessionScope.ErreurPaiement}"> <fmt:message key="msg27"/> ${sessionScope.limiteFacture} $ </c:if>
                            <c:if test="${sessionScope.ErreurPaiement <= 0}"> <fmt:message key="msg18"/> </c:if> 
                            <c:if test="${sessionScope.NumberFormatException != null }"> <fmt:message key="msg34"/>  </c:if>
                                </font>
                            </div>
                        </form>
                        <img src="images/bill.jpg" alt="virer" style="width:40%;">
                    </div>
                </div>
            </body>
    </fmt:bundle>
</html>
