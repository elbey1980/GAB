<%-- 
    Document   : identification
    Created on : 2019-09-26, 09:28:59
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
            <style type="text/css">
                body {
                    background : url("images/identification.jpg");
                }
            </style>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1">
            <link rel="stylesheet" type="text/css" href="css/css1">
            <title><fmt:message key="newTitle"/></title>
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
            <h1><fmt:message key="newTitle"/></h1>
            <a href="javascript:changeLanguage()" class="text-block2"><b><fmt:message key="msg36"/></b></a> 
            <div class="img1">
                <form action="Authentification?action=identification&langue=${loc}" class="container" method="post">
                    <h4><fmt:message key="msg"/></h4>
                    <h4 ><font color="red"><c:if test="${requestScope.checkPassword != null }"> <fmt:message key="msg33"/>  </c:if> </font></h4>       
                    <label for="text" ><b><fmt:message key="accountNumber"/></b></label>
                    <input type="text" placeholder="<fmt:message key="placeholder1"/>" name="numcompte" maxlength="6" required>
                    <label for="text"><b><fmt:message key="pin"/></b></label>
                    <input type="password" placeholder="<fmt:message key="placeholder2"/>" name="pin" maxlength="4" required>
                    <button type="submit" class="btn" ><fmt:message key="submit"/></button>
                </form>
            </div>
        </body>
    </fmt:bundle>
</html>
