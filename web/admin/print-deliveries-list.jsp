<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
<head>
    <title>List of Book Deliveries</title>
    <style>
        body {
            width:210mm;
            /*height:297mm;*/
            margin:0 auto;
        }
        hr {
            border-top: 1px dashed black;
            float:left;
            width:100%;
            margin-bottom:4mm;
        }
        table.main {
            border-collapse:collapse;
            text-align:center;
            margin: 0 10mm 8mm;
        }
        table.main tr {
            min-height:30mm;
        }
        table.main td, table.main th {
            border: 1px solid black;
        }
        td.order-no {width:5mm;}
        p.name {width:40mm;}
        p.address {width:70mm;}
        td.pincode {width:15mm;}
        div.signature {width:50mm;min-height:20mm;}

        /*too apply to the first element of class main2*/
        .main2 {
            page-break-before:always;
        }
        .main2 ~ .main2 {
            page-break-before:avoid;
        }

        table.main2 {
            margin: 3mm 5mm;
            page-break-inside:avoid;
        }
        table.main2 td, table.main2 th {
            padding: 10px 0;
        }
        table.main2 td.address {
            width:102mm;
        }
        td.left {text-align:left;padding-left:10px!important;}
        .right {text-align:right;padding-right:10px!important;}
    </style>

</head>

<body>
<h3 style="float:left;margin-left:10mm;">List of Deliveries of Books - ReadersHive.com</h3>
<h3 style="float:right;margin:0 10mm 0 0;" id="todays-date"></h3>

<script type="text/javascript">
    var today = new Date();
    var dd = today.getDate();
    var mm = today.getMonth()+1; //January is 0!

    var yyyy = today.getFullYear();
    if(dd<10){dd='0'+dd} if(mm<10){mm='0'+mm} today = 'Date : '+dd+'/'+mm+'/'+yyyy;
    document.getElementById('todays-date').innerHTML=today;
</script>

<br/>

<s:set var="previousPincode" value="%{999999}"/>

<s:iterator value="deliveryOrders">
    <s:if test="%{#previousPincode!=pincode}">

        <s:set var="previousPincode" value="pincode"/>
        </table>
        <table class="main">
            <tr>
                <th>Order. No.</th>
                <th>Name</th>
                <th>Address</th>
                <th>Pincode</th>
                <th>Signature</th>
            </tr>
            <tr>
                <td class="order-no"><s:property value="orderId"/>.</td>
                <td>
                    <p class="name">
                        <s:property value="userInfoByBuyerId.firstName"/> <s:property value="userInfoByBuyerId.lastName"/>
                    </p>
                </td>
                <td>
                    <p class="address">
                        <s:property value="userInfoByBuyerId.userAddress"/>
                    </p>
                </td>
                <td class="pincode">
                    <s:property value="pincode"/>
                </td>
                <td>
                    <div class="signature">
                        &nbsp;
                    </div>
                </td>
            </tr>
    </s:if>

    <s:else>
        <tr>
            <td class="order-no"><s:property value="orderId"/>.</td>
            <td>
                <p class="name">
                    <s:property value="userInfoByBuyerId.firstName"/> <s:property value="userInfoByBuyerId.lastName"/>
                </p>
            </td>
            <td>
                <p class="address">
                    <s:property value="shippingAddress"/>
                </p>
            </td>
            <td class="pincode">
                <s:property value="pincode"/>
            </td>
            <td>
                <div class="signature">
                    &nbsp;
                </div>
            </td>
        </tr>
    </s:else>
</s:iterator>

</table>

<br/>

<s:iterator value="deliveryOrders">
    <table class="main main2">
        <tr>
            <th colspan="4" style="font-size:30px;font-weight:bold;">Invoice - ReadersHive.com</th>
        </tr>
        <tr>
            <td colspan="2" class="left">
                <b>Invoice No. :</b> <s:property value="orderId" />
            </td>
            <td colspan="2" class="right">
                <b>Invoice Date :</b> <s:date name="printDate" format="dd/MM/yyyy" />
            </td>
        </tr>
        <tr>
            <td colspan="2" class="left address">
                <p>
                    <b>Deliver To : </b><br/>
                    <s:property value="userInfoByBuyerId.firstName"/> <s:property value="userInfoByBuyerId.lastName"/>&nbsp;,
                    <br/>
                    <s:property value="shippingAddress" />
                </p>
            </td>
            <td colspan="2" class="left address">
                <p>
                    <b>From : </b><br/>
                    JUSDIAS Office ,<br/>
                    D/204, Regency Tower, Near Mansi Circle, Vastrapur, Ahmedabad-380015
                </p>
            </td>
        </tr>
        <tr>
            <th style="width:30mm;">
                Book ID
            </th>
            <th colspan="3">
                Book Name
            </th>
        </tr>
        <s:iterator value="borrowBooksesByOrderId">
        <tr>
            <td>
                <s:property value="bookInfoByBookId.bookId"/>
            </td>
            <td colspan="3">
                <s:property value="bookInfoByBookId.bookTitle"/>
            </td>
        </tr>
        </s:iterator>
        <tr>
            <th colspan="3" class="right">
                Shipping Charges :
            </th>
            <td style="width:30mm;">
                <s:property value="%{(borrowBooksesByOrderId.size()*20)+20}"/> Rs.
            </td>
        </tr>
    </table>

    <hr/>

</s:iterator>


</body>

</html>