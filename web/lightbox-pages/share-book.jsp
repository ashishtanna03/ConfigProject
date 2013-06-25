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
	<h1>Share Book</h1>
		<form id="shareForm" name="shareForm" action="/share/ShareBook.action" method="post" autocomplete="off">
			<h3>
			Rate the Condition of your BOOK : 
			</h3>
			<h3 class="rating-stars">
				<img src="/img/star.png"/>
				<img src="/img/star.png"/>
				<img src="/img/star.png"/>
				<img src="/img/star.png"/>
			</h3>
			<br/>
			<h3>
			Describe The Condition of Your Book :<br/>
			</h3>
			<textarea rows="7" cols="50" name="conditionDescription" class="area_feed price-txt" ></textarea>
			<br/><br/>
			<h3>
			Set Price(Virtual Points) :
			</h3>
			<input type="text" name="sharingPrice" value="" class="price-txt"/><br/>
            <input type="hidden" name="conditionRating" value="4"/>
            <input type="hidden" name="bookId" value="<%=request.getParameter("bookId")%>"/>
			<a class="button2 tooltip" href="javascript:{}" id="share-submit" onclick="shareBook();" title="">SHARE</a>
		</form>
		
	</div>
</body>
</html>