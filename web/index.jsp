<%-- 
    Document   : index
    Created on : 2019-09-27, 06:51:59
    Author     : RAM
<jsp:forward page="Authentification?action=identification"/>
 <%  response.sendRedirect("identification.jsp");  %>
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
    <c:set var="loc" value="en_US"/>
    <c:if test="${!(empty param.locale)}">
        <c:set var="loc" value="${param.locale}"/>
    </c:if>
    <fmt:setLocale  value="${sessionScope.langue}"  />
    <jsp:forward page="WEB-INF/jsp/identification.jsp"/>
</body>
</html>
