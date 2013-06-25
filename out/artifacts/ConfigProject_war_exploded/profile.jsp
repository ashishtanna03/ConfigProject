<%--
  Created by IntelliJ IDEA.
  User: Ashish
  Date: 2/9/13
  Time: 7:09 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="s" uri="/struts-tags" %>
<html>
<head>
    <title>Profile</title>
</head>
<body>
    UserName : <s:property value="%{#session['user'].userName}" />
    Phone No. : <s:property value="%{#session['user'].userPhNo}" />
</body>
</html>