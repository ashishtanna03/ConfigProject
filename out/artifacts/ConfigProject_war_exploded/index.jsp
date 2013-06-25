<%--
  Created by IntelliJ IDEA.
  User: Ashish
  Date: 2/9/13
  Time: 5:54 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Welcome</title>
</head>
<body>
    <h1>Welcome</h1>
    <form>
        UserName : <input type="text" name="j_username" id="j_username" /><br/>
        Password : <input type="text" name="j_password" id="j_password"/><br/>
        <input type="button" value="Login!" onclick="sendReq()"/>
    </form>

<script type="text/javascript">
    function sendReq(){

     alert(document.getElementById('j_username').value);
     alert('sending req');
     var req=new XMLHttpRequest();
     req.open('POST','j_spring_security_check?j_username='+document.getElementById('j_username').value+'&j_password='+document.getElementById('j_password').value,false);

    req.send();
    if(req.readyState==4){
        var res=req.response;
        alert(res);

    }

    }
</script>



</body>
</html>