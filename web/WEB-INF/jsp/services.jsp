<%-- 
    Document   : index
    Created on : 2019-09-23, 12:08:03
    Author     : RAM
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <fmt:setLocale  value="${sessionScope.langue}"  />
    <fmt:bundle basename="/i18n/app">
        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <title><fmt:message key="newTitle"/>  </title>
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
            <div class="main">
                <div id="0">
                    <h2><fmt:message key="newTitle"/>  </h2> 

                    <div class="container1">
                        <img src="images/epargne1.png" alt="epargne" style="width:50%;"> 
                        <div class="text-block">
                            <h4><fmt:message key="msg2"/></h4>
                            <table>
                                <tr>
                                    <td><fmt:message key="msg3"/>   ${sessionScope.prenom}  ${sessionScope.nom}
                                </tr>
                                <tr>
                                    <td><fmt:message key="msg4"/>  ${sessionScope.typecompte}  :  ${sessionScope.numcompte}
                                </tr>
                                <tr>
                                    <td><fmt:message key="msg5"/>  ${sessionScope.solde}
                                </tr>
                            </table>	
                        </div>
                    </div>
                </div>
            </div>                                        
            <div class="sidenav">  
                <a href="#compte" ><fmt:message key="msg4"/></a>
                <a href="Controleur?action=retrait"><fmt:message key="msg6"/></a>
                <a href="Controleur?action=depot" ><fmt:message key="msg7"/></a>
                <a href="Controleur?action=paiement"><fmt:message key="msg8"/></a>
                 <a href="Controleur?action=selection" ><fmt:message key="msg39"/></a>
                <a href="Controleur?action=Parametres" ><fmt:message key="msg11"/></a>
                <a href="Controleur?action=identification"><fmt:message key="msg10"/></a>
            </div>
        </body>
    </fmt:bundle>
</html>
