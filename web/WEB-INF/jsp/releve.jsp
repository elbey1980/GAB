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
                    <form action="Controleur?action=services" method="post" >
                        <div>
                            <h1 class="l1" align="center" ><fmt:message key="msg41"/></h1>
                        </div>
                        <div class="text-block5">
                            <table>
                                <tr>    
                                    <td><fmt:message key="msg12"/>  ${sessionScope.prenom}  ${sessionScope.nom}                                  
                                </tr>
                                <tr>
                                    <td><fmt:message key="msg4"/>  ${sessionScope.typecompte}  :  ${sessionScope.numcompte}                      
                                </tr>		
                            </table>	
                        </div>
                        <div class="text-block4">
                            <table>
                                <tr>    
                                    <td><fmt:message key="msg48"/>  ${sessionScope.adresse.porte}      ${sessionScope.adresse.rue}    ${sessionScope.adresse.appartement}   
                                </tr>
                                <tr>
                                    ${sessionScope.adresse.localite}    ${sessionScope.adresse.province}      ${sessionScope.adresse.pays}
                                </tr>		
                            </table>	
                        </div>
                        <table cellspacing="3" cellpadding="3" border="1" width="70%" align="center">
                            <tr align="center">
                                <td><fmt:message key="msg44"/></td>
                                <td><fmt:message key="msg45"/></td>
                                <td><fmt:message key="msg46"/></td>
                                <td><fmt:message key="msg45"/></td>
                                <td><fmt:message key="msg23"/></td>
                            </tr>
                            <c:forEach var="operation" items="${requestScope.resultat}" >
                                <tr align="center">
                                    <td>${operation.numOperation}</td>
                                    <td>${operation.dateOperation}</td>
                                    <td><c:choose>
                                            <c:when test="${operation.typeOperation == 'R' }"><fmt:message key="msg6"/></c:when>
                                            <c:when test="${operation.typeOperation == 'D' }"><fmt:message key="msg7"/></c:when>
                                            <c:when test="${operation.typeOperation == 'P' }"><fmt:message key="msg8"/></c:when>
                                            <c:otherwise></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>${operation.nomBeneficiaire}</td>
                                    <td>${operation.montantOperation}</td>
                                </tr>
                            </c:forEach>
                            <tfoot>
                                <tr>
                                    <th id="total" colspan="4"><fmt:message key="msg5"/></th>
                                    <td>${sessionScope.solde}$</td>
                                </tr>
                            </tfoot>
                        </table>
                        <div class="button" align="center">
                            <button type="submit" > <fmt:message key="msg40"/> </button>
                        </div>
                    </form>
                </div>
            </div>
        </body>
    </fmt:bundle>
</html>
