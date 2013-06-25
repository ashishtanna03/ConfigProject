<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
    <link href="/css/global.css" rel="stylesheet" type="text/css" media="all" />

    <title>Share Book</title>
    <style>
        #signup-form h1{font-size:1.4em;font-weight:bold;padding-bottom:15px;margin-left:-15px;}
        div#signup-form{padding:20px;}
        #signupform h3{font-size:1.2em;margin-bottom:5px;width:auto;float:left;font-weight:bold;margin-top:3px;}
        #signupform .price-txt{background:#EDEDED;border-radius: 4px 4px 4px 4px;padding: 3px 5px;margin:0px 4px 4px 4px;}
    </style>
</head>
<body style="margin-left:25px;margin-top:25px;">

<div id="signup-form">
    <h1>Contact & Address</h1>
    <form id="shippingform" name="shipping_form" action="/cart/Checkout.action" method="post" autocomplete="off">


        <h3>
            Contact No :<br/>
        </h3>
        <input type="text" name="contactNo" value="<%=request.getParameter("contactNo")%>"/>
        <br/><br/>
        <h3>
            Address :
        </h3>
        <textarea rows="7" cols="50" name="address"  class="area_feed price-txt" value=""><%=request.getParameter("address")%></textarea> <br/><br/>
        <input type="submit" value="Proceed" class="button" />
    </form>

</div>
</body>
</html>