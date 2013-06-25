<%--
  Created by IntelliJ IDEA.
  User: Ashish
  Date: 2/9/13
  Time: 6:59 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="s" uri="/struts-tags" %>
<html>
<head>
    <title>Success</title>
</head>
<body>
    <h1>Success</h1>
    <s:set var="user" value="user" scope="session"/>

    <a href="profile.jsp">Profile</a>
    <a href="j_spring_security_logout">Logout</a>
</body>
</html>