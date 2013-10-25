<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
<head>
	<title>List of Book Pick Ups</title>
	<style>
		body {
			width:210mm;
			/*height:297mm;*/
			margin:0 auto;
		}
		table.main {
			float:left;
			border-collapse:collapse;
			text-align:center;
			margin: 0 5mm 8mm;
		}
		table.main tr {
			min-height:30mm;
		}
		table.main td, table.main th {
			border: 1px solid black;
		}
		td.order-no {width:5mm;}
		td.name {width:52mm;text-align:left;padding-left:2mm;}
		td.book-info {width:60mm;text-align:left;padding-left:2mm;}
		td.pincode {width:15mm;}
		div.signature {width:50mm;min-height:20mm;}
	</style>
</head>

<body>
	<h3 style="float:left;margin-left:10mm;">List of Pick-ups of Books - ReadersHive.com</h3>
	<h3 style="float:right;margin:0 10mm 0 0;" id="todays-date"></h3>
	
	<script type="text/javascript">
		var today = new Date();
		var dd = today.getDate();
		var mm = today.getMonth()+1; //January is 0!

		var yyyy = today.getFullYear();
		if(dd<10){dd='0'+dd} if(mm<10){mm='0'+mm} today = 'Date : '+dd+'/'+mm+'/'+yyyy;
		document.getElementById('todays-date').innerHTML=today;
	</script>

    <s:set var="previousPincode" value="%{999999}"/>

    <s:iterator value="pickUpOrders">

    <s:if test="%{#previousPincode!=lendByLendId.userInfoByUserId.userPostalCode}">

    <s:set var="previousPincode" value="%{lendByLendId.userInfoByUserId.userPostalCode}"/>
    </table>

    <br/><br/>

	<table class="main">
		<tr>
			<th>Order. No.</th>
			<th>Name & Address</th>
			<th>Book Info.</th>
			<th>Pincode</th>
			<th>Signature</th>
		</tr>

        <tr>
            <td class="order-no"><s:property value="orderInfoByOrderId.orderId" />.</td>
            <td class="name">
                <p>
                    <b>Name : </b><s:property value="lendByLendId.userInfoByUserId.firstName"/> <s:property value="lendByLendId.userInfoByUserId.lastName"/><br/>
                    <b>Mob. No. : </b><s:property value="lendByLendId.userInfoByUserId.userContact"/><br/>
                    <b>Address : </b><s:property value="lendByLendId.userInfoByUserId.userAddress"/>
                </p>
            </td>
            <td class="book-info">
                <p>
                    <b>Name : </b><s:property value="bookInfoByBookId.bookTitle"/>
                    <br/>
                    <b>Author(s) : </b>

                    <s:iterator value="bookInfoByBookId.bookAuthorsesByBookId" status="authorIteratorStatus">
                        <s:property value="authorInfoByAuthorId.authorName"/>
                        <s:if test="#authorIteratorStatus.last!=true">,</s:if>
                    </s:iterator>

                    <br/>

                    <b>Publisher : </b><s:property value="bookInfoByBookId.publisherInfoByPublisherId.publisherName" />
                </p>
            </td>
            <td class="pincode"><s:property value="lendByLendId.userInfoByUserId.userPostalCode"/></td>
            <td>
                <div class="signature">
                    &nbsp;
                </div>
            </td>
        </tr>
        </s:if>

        <s:else>
            <tr>
                <td class="order-no"><s:property value="orderInfoByOrderId.orderId" />.</td>
                <td class="name">
                    <p>
                        <b>Name : </b><s:property value="lendByLendId.userInfoByUserId.firstName"/> <s:property value="lendByLendId.userInfoByUserId.lastName"/><br/>
                        <b>Address : </b><s:property value="lendByLendId.userInfoByUserId.userAddress"/>
                    </p>
                </td>
                <td class="book-info">
                    <p>
                        <b>Name : </b><s:property value="bookInfoByBookId.bookTitle"/>
                        <br/>
                        <b>Author(s) : </b>

                        <s:iterator value="bookInfoByBookId.bookAuthorsesByBookId" status="authorIteratorStatus">
                            <s:property value="authorInfoByAuthorId.authorName"/>
                            <s:if test="#authorIteratorStatus.last!=true">,</s:if>
                        </s:iterator>

                        <br/>

                        <b>Publisher : </b><s:property value="bookInfoByBookId.publisherInfoByPublisherId.publisherName" />
                    </p>
                </td>
                <td class="pincode"><s:property value="lendByLendId.userInfoByUserId.userPostalCode"/></td>
                <td>
                    <div class="signature">
                        &nbsp;
                    </div>
                </td>
            </tr>
        </s:else>

    </s:iterator>
    </table>
</body>

</html>