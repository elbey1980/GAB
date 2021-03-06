<%-- 
    Document   : retrait
    Created on : 2019-09-23, 19:10:15
    Author     : RAM
<input type="button" value="Convertir" class="text-block2" onclick="changeLanguage()"/>
 <script src="scriptAjax.js" type="text/javascript"></script>
location.assign(location.href);
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
            <title><fmt:message key="msg7"/></title>
            <link rel="stylesheet" type="text/css" href="css/css1">
            <script src="../../scripts/scriptAjax.js" type="text/javascript"></script>
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
                <div id="2">
                    <form name="maForm" action="Controleur?action=depot" method="post" >
                        <div>
                            <h1 class="l1" align="center" ><fmt:message key="msg7"/> </h1>
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
                            <label for="msg"><fmt:message key="msg5"/> ${sessionScope.solde}$     
                        </div>
                        <div>
                            <label for="msg"><fmt:message key="msg24"/></label>        
                            <input type="text" placeholder="<fmt:message key="msg23"/>" id="txtRetrait" name="Montant" maxlength="6" required>
                        </div>	
                        <div class="button">
                            <button type="submit" > <fmt:message key="msg37"/> </button><button onclick="location.href = 'Controleur?action=retour'" > <fmt:message key="msg35"/> </button><div id="res"></div>
                            <font color="red"><c:if test="${sessionScope.ErreurDepot <= 0}"> <fmt:message key="msg18"/>  </c:if>       
                            <c:if test="${sessionScope.ErreurDepot > sessionScope.limiteDepot}"> <fmt:message key="msg25"/> ${sessionScope.limiteDepot} $ </c:if>
                            <c:if test="${sessionScope.NumberFormatException != null }"> <fmt:message key="msg34"/>  </c:if>
                                </font>
                            </div>
                        </form>
                        <img src="images/depot.jpg" alt="depot" style="width:60%;">
                    </div>
                </div>
            </body>
    </fmt:bundle>
</html>
