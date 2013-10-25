<html>
<head>
	<link href="/css/global.css" rel="stylesheet" type="text/css" media="all" />

    <script type="text/javascript">
        function validateNumber(evt) {
            var theEvent = evt || window.event;
            var key = theEvent.keyCode || theEvent.which;
            key = String.fromCharCode( key );
            var regex = /[0-9]|\./;
            if( !regex.test(key) && theEvent.keyCode!=8) {
                theEvent.returnValue = false;
                if(theEvent.preventDefault) theEvent.preventDefault();
            }
        }
    </script>

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
	<h1 style="text-align: center;">Share Book</h1>
		<form id="shareForm" name="shareForm" action="/share/ShareBook.action" method="post" autocomplete="off">
			<h3>
			Rate the Condition of your BOOK : 
			</h3>
            <select id="book-condition">
                <option value="1">As New</option>
                <option value="2" selected="true">Good</option>
                <option value="3">Torn, But Readable</option>
                <option value="4">Poor</option>
            </select>
			<br/><br/>
			<h3>
			Describe The Condition of Your Book :<br/>
			</h3>
			<textarea rows="7" cols="50" name="conditionDescription" class="area_feed price-txt" ></textarea>
			<br/><br/>
			<h3>
			Set Price(Virtual Points) :
			</h3>
			<input type="text" name="sharingPrice" value="" class="price-txt" onkeypress="validateNumber(event);" /><b>&nbsp;&lt;<%=request.getParameter("mrp")%>&nbsp;(MRP)</b><br/>
            <br/>

            <h3>
                Confirm your Address :<br/>
            </h3>
            <textarea rows="4" cols="35" name="userAddress" class="area_feed price-txt" ><%=request.getParameter("address")%></textarea>
            <br/>
            <br/>
            <h3>Pincode : </h3>
            <input type="text" name="userPostalCode" maxlength="6" onkeypress="validateNumber(event);" value="<%=request.getParameter("pincode")%>" />
            <br/>
            <br/>
            <h3>Your Contact No. : </h3><b>+91&nbsp;-&nbsp;<%=request.getParameter("contact")%></b>
            <br/>
            <br/>
            <input type="hidden" name="bookMrp" value="<%=request.getParameter("mrp")%>"/>
            <input type="hidden" name="bookId" value="<%=request.getParameter("bookId")%>"/>
			<a class="button2 tooltip" href="javascript:{}" id="share-submit" onclick="shareBook();" title="">SHARE</a>
		</form>
		
	</div>
</body>
</html>