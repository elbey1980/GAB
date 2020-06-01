<%-- 
    Document   : Parametres
    Created on : 2019-10-02, 18:39:55
    Author     : RAM
&& requestScope.anip != null
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
            <title><fmt:message key="msg32"/></title>
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
                <div id="5">
                    <form action="Controleur?action=Parametres" method="post" >
                        <div>
                            <h1 class="l1" align="center" ><fmt:message key="msg32"/></h1>
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
                            <label for="mail"><fmt:message key="msg29"/></label>
                            <input type="ANIP" placeholder="<fmt:message key="msg29"/>"  name="ANIP" maxlength="4"  required>
                        </div>
                        <div>
                            <label for="msg"><fmt:message key="msg30"/></label>   
                            <input type="password" placeholder="<fmt:message key="msg30"/>" class="p1" name="NNIP" maxlength="4" required>
                        </div>
                        <div>
                            <label for="msg"><fmt:message key="msg31"/></label>   
                            <input type="password" placeholder="<fmt:message key="msg31"/>" class="p1" name="CNIP" maxlength="4" required>
                        </div>
                        <div class="button">
                            <button type="submit"> <fmt:message key="msg38"/> </button><button onclick="location.href = 'Controleur?action=retour'" > <fmt:message key="msg35"/> </button>
                            <font color="red">
                            <c:choose>
                                <c:when test="${requestScope.anip != sessionScope.nip && requestScope.anip != null }"><fmt:message key="msg20"/></c:when>
                                <c:when test="${requestScope.nnip != requestScope.cnip && requestScope.nnip != null && requestScope.cnip!=null }"><fmt:message key="msg21"/></c:when>
                                <c:when test="${requestScope.nnip == requestScope.cnip && requestScope.anip == sessionScope.nip && requestScope.anip == requestScope.nnip &&  requestScope.nnip != null && requestScope.cnip!=null && requestScope.anip!=null }"><font color="green"><fmt:message key="msg22"/></font> </c:when> 
                                <c:otherwise></c:otherwise>
                            </c:choose>
                            </font>  
                        </div>
                    </form>
                    <img src="images/nip.jpg" alt="nip" style="width:60%;">
                </div>
            </div>
        </body>
    </fmt:bundle>
</html>
