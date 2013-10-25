<%@ page contentType="text/html;charset=UTF-8" language="java" session="true" %>
<%@taglib prefix="s" uri="/struts-tags" %>
<%@taglib prefix="sx" uri="/struts-dojo-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
    <title>Edit Profile - ReadersHive</title>
    <meta name="description" content="Use our form to contact us"/>
    <meta name="keywords" content="contact, form, e-mail"/>
    <meta http-equiv="Content-Type" content="application/xhtml+xml; charset=utf-8"/>
    <meta name="generator" content="PrestaShop"/>
    <meta name="robots" content="index,follow"/>

    <link rel="shortcut icon" type="image/x-icon" href="/img/favicon.ico"/>
    <link href='http://fonts.googleapis.com/css?family=Open+Sans:400,600,700' rel='stylesheet' type='text/css' />
    <link href="/css/edit-prof.css" rel="stylesheet" type="text/css" media="screen"/>
    <link href="/css/global.css" rel="stylesheet" type="text/css" media="all"/>


    <!-- Javascript files -->
    <script type="text/javascript" src="/js/jquery-1.7.2.min.js"></script>
    <script type="text/javascript" src="/js/jquery/jquery.easing.1.3.js"></script>
    <sx:head />
    <script type="text/javascript" src="/js/edit-prof.js"></script>

    <!--Chosen Plugin for multi select-->
    <link href="/js/chosen/chosen.min.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="/js/chosen/chosen.jquery.min.js"></script>
    <script type="text/javascript">
        var contactNo;
        $(document).ready(function() {
            $(".user-fav-genres").chosen({max_selected_options: 3});
            contactNo = $("#contact-no");
            contactNo.tooltipster({content:'',trigger:'custom',position:'right'});
        });
    </script>

</head>
<body id="contact-form">
<!--[if lt IE 7]>
<div style='clear:both;height:59px;padding:0 15px 0 15px;position:relative;z-index:10000;text-align:center;'><a
        href="http://www.microsoft.com/windows/internet-explorer/default.aspx?ocid=ie6_countdown_bannercode"><img
        src="http://www.theie6countdown.com/images/upgrade.jpg" border="0" height="42" width="820"
        alt="You are using an outdated browser. For a faster, safer browsing experience, upgrade for free today."/></a>
</div><![endif]-->
<div id="wrapper1">
<div id="wrapper2">
<div id="wrapper3">

<!--Top Panel-->
<s:include value="/top-panel.jsp"/>

<div id="wrapper4">
<!-- Header -->
<jsp:include page="/header.jsp" flush="true"/>

<div id="columns">
<!-- Left -->
<div id="left_column" class="column">

<%--<!--edit-prof js-->

<script type="text/javascript">

    $(document).ready(function () {
        var counter = 2;
        $("#addButton").click(function () {

            if (counter > 10) {
                alert("Only 10 textboxes allow");
                return false;
            }
            /*
             var newTextBoxDiv = $(document.createElement('div')).attr("id", 'TextBoxDiv' + counter);
             newTextBoxDiv.appendTo("#TextBoxesGroup");
             newTextBoxDiv.after('<label>Textbox #' + counter + ' : </label>' + '<input type="text" name="textbox' + counter + '" id="textbox' + counter + '" value="" />');
             */

            var $Div = $('<div id="TextBoxDiv' + counter + '"></div>')
            $Div.append('<p class="text">' + '<label><b>Add Book </b>' + ' : </label>' + '<input type="text" name="textbox' + counter + '" id="textbox' + counter + '" value="" />' + '</p>');
            $('#TextBoxesGroup').append($Div);
            //alert("wel2");
            counter++;
        });

        $("#removeButton").click(function () {
            if (counter == 1) {
                alert("No more textbox to remove");
                return false;
            }
            counter--;
            $("#TextBoxDiv" + counter).remove();
        });

    });
</script>
<!--/edit prof current & shelve -->--%>
<!-- Center -->
<div id="center_column" class="center_column">

<h1>My Account</h1>
<a href="/user/UserProfile.action" id="view-pro" class="button_small">See My Profile</a>

<div class="mainContainer">
<div class="htmltabs">
<!-- The tabs -->
<ul class="tabs">
    <li class="tab1">
        <a class="tab1 tab">
            Profile
        </a>
    </li>
    <li class="tab2">
        <a class="tab2 tab">
            Settings
        </a>
    </li>
    <%--<li class="tab3">
        <a class="tab3 tab">
            Currently Reading & Shelves
        </a>
    </li>--%>


</ul>
<!-- tab 1 -->
<div class="tab1 tabsContent">
    <div>
        <form class="std">
            <fieldset>
                <h3>Personal Settings</h3>

                <p class="text">
                    <label for="first-name"><b>First Name :</b></label>
                    <input type="text" id="first-name" name="f-name" value="<s:property value="user.firstName"/>"/>
                </p>

                <p class="text">
                    <label for="last-name"><b>Last Name :</b></label>
                    <input type="text" id="last-name" name="l-name" value="<s:property value="user.lastName"/>"/>
                </p>

                <p id="settings-gender" class="radio">
                    <label><b>Gender :</b></label>
                        <input name="gender" type="radio" value="M">&nbsp;Male</input>
                        <input name="gender" type="radio" value="F">&nbsp;Female</input>

                    <script type="text/javascript">
                        var userGender = "<s:property value="user.userGender"/>";
                        if(userGender =="M"){
                            document.getElementsByName("gender")[0].checked=true;
                        }else{
                            document.getElementsByName("gender")[1].checked=true;
                        }
                    </script>

                </p>
                <p class="text">
                    <label><b>BirthDate :</b></label>
                    <sx:datetimepicker id="birth-date" name="userBirthdate" displayFormat="dd/MM/yyyy" value="user.userBirthdate" />
                </p>

                <p class="text">
                    <label for="city-name"><b>City :</b></label>
                    <%--<input type="text" id="city-name" name="city_name" value="<s:property value="user.userCity"/>"/>--%>
                    <select name="city-name" id="city-name">

                        <option value=""></option>
                        <option value="Ahmedabad">Ahmedabad</option>
                        <option value="Vadodra">Vadodra</option>
                        <option value="Surat">Surat</option>
                        <option value="Jamnagar">Jamnagar</option>
                        <script type="text/javascript">
                            $("#city-name option[value='<s:property value="user.userCity"/>']").attr("selected", true);
                        </script>
                    </select>
                </p>

                <p class="text">
                    <label for="postal-code"><b>Postal Code :</b></label>
                    <input type="text" id="postal-code" name="p-code" maxlength="6" value="<s:property value="user.userPostalCode"/>"/>
                </p>

                <p class="text">
                    <label for="occuname"><b>Occupation :</b></label>
                    <%--<input type="text" id="occuname" name="o-name" value="<s:property value="user.userOccupation"/>"/>--%>
                    <select name="o-name" id="occuname">
                        <option value=""></option>
                        <option value="Student">Student</option>
                        <option value="Own a Business">Own a Business</option>
                        <option value="Working Full Time(Job)">Working Full Time(Job)</option>
                        <option value="Other">Other</option>
                        <script type="text/javascript">
                            $("#occuname option[value='<s:property value="user.userOccupation"/>']").attr("selected", true);
                        </script>
                    </select>
                </p>

                <p class="text">
                    <label><b>Favourite Genres (Max. 3):</b></label>
                    <s:select list="genresList" listKey="genreId" listValue="genreName" data-placeholder="Choose a Favourite Genre..."
                              id="userFavGenres" name="userFavGenres" cssClass="user-fav-genres" value="%{user.userFavGenresesByUserId.{genresByGenreId.genreId}}" multiple="true" size="3"
                              cssStyle="width: 300px;"
                            />
                    <%--<input type="text" id="favgen" name="f-genre"
                           value='<s:iterator value="user.userFavGenresesByUserId" status="iteratorStatus"><s:property value="genresByGenreId.genreName"/><s:if test="#iteratorStatus.last!=true">,</s:if></s:iterator>'
                            />--%>
                </p>

                <p class="text">
                    <label for="web-blo"><b>Website/Blog:</b></label>
                    <input type="text" id="web-blo" name="w-b" value="<s:property value="user.userWebsite"/>"/>
                </p>

                <%--<p class="text">
                    <label for="contact-no"><b>Contact No :</b></label>
                    <input type="text" id="contact-no" name="contact-no"value="<s:property value="user.userContact"/>"/>
                </p>--%>

                <p class="textarea">
                    <label for="user-add"><b>Address :</b></label>
                    <textarea id="user-add" name="abt_me" rows="5" cols="50"><s:property value="user.userAddress"/></textarea>
                </p>

                <p class="submit">
                    <a name="savechange" href="javascript:{}" id="save-changes" class="button_small" onclick="saveProfileChanges();" title="">Save Changes</a>
                    <%--<input type="submit" name="cancel" id="cancel-changes" value="Cancel" class="button_small"/>--%>
                </p>

        </form>
    </div>
</div>
<!-- end of t1 -->
<!-- tab 2 -->
<div class="tab2 tabsContent">
    <div>
        <form class="std">
            <fieldset>
                <h3>Change Password</h3>

                <p class="password">
                    <label for="old_pwd"><b>Old Password :</b></label>
                    <input type="password" id="old_pwd" name="old-pwd" value=""/>
                </p>

                <p class="password">
                    <label for="new_pwd"><b>New Password :</b></label>
                    <input type="password" id="new_pwd" name="new-pwd" value=""/>
                </p>

                <p class="password">
                    <label for="conf_pwd"><b>Confirm Password :</b></label>
                    <input type="password" id="conf_pwd" name="conf-pwd" value=""/>
                </p>

                <p class="submit">
                    <a href="javascript:{}" class="button_small tooltip" onclick="changePassword();">Change Password</a>
                </p>

                <%--<h3>Privacy Settings</h3>

                <p class="radio">
                    <label><b>Who Can View My Profile ??</b></label><br/><br/>
                    <input type="radio" id="anyone" name="viewprof" value=""/><b>Anyone can see</b><br/>
                    <input type="radio" id="anyone" name="viewprof" value=""/><b>Readershive Members</b><br/>
                    <input type="radio" id="anyone" name="viewprof" value=""/><b>Only Friends</b>
                </p>

                <p class="radio">
                    <label for="reqbk"><b>Who Can Request For Book ??</b></label><br/><br/>
                    <input type="radio" id="anyone1" name="reqbk" value=""/><b>Readershive Members</b><br/>
                    <input type="radio" id="anyone1" name="reqbk" value=""/><b>Only Friends</b><br/>

                </p>

                <p class="radio">
                    <label for="recbk"><b>Who Can Recommand a Book ??</b></label><br/><br/>
                    <input type="radio" id="anyone2" name="recbk" value=""/><b>Readershive Members</b><br/>
                    <input type="radio" id="anyone2" name="recbk" value=""/><b>Only Friends</b><br/>

                </p>--%>

                <script type="text/javascript">
                    function contactOnFocus() {
                        contactNo.tooltipster('update','Note : You have to verify your<br/>Mobile No. (Not Landline) to complete<br/>registration. So, enter Mobile<br/>No. from which you can<br/>give us a Miss call to verify.<br/>(Verification is mandatory and its<br/>Free. Call will be disconnected<br/>automatically.)');
                        contactNo.tooltipster('show');
                    }
                    function contactOnBlur() {
                        contactNo.tooltipster('hide');
                    }
                    function changeContactNo() {

                        contactNo.tooltipster('hide');
                        if(contactNo.val()==null || $.trim(contactNo.val())=="" || contactNo.val()=="Contact No.") {
                            contactNo.tooltipster('update','Contact No. can\'t<br/>be empty.'); contactNo.tooltipster('show'); return;
                        } else if(contactNo.val().length!=10) {
                            contactNo.tooltipster('update','Contact No. must be<br/> valid & of 10 digits.'); contactNo.tooltipster('show'); return;
                        }

                        var missCallReq;
                        var missCallRes;
                        if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
                            missCallReq = new XMLHttpRequest();
                        }
                        else {// code for IE6, IE5
                            missCallReq = new ActiveXObject("Microsoft.XMLHTTP");
                        }

                        missCallReq.onreadystatechange = function () {
                            if (missCallReq.readyState == 4 && missCallReq.status == 200) {

                                missCallRes=eval(missCallReq.response);

                                if(missCallRes.APIStatus=="Success") {
                                    var contactVerify = $("#contact-verification");
                                    var contactVerifyUrl = "/lightbox-pages/contact-verification.jsp?lightbox[width]=330&lightbox[height]=290"+
                                            "&sessionId="+missCallRes.SessionId+
                                            "&verificationNode="+missCallRes.VerificationNode+
                                            "&action=/user/ChangeContactNo.action"+
                                            "&contactNo="+contactNo.val();
                                    contactVerify.attr("href", contactVerifyUrl);
                                    contactVerify[0].click();
                                } else {
                                    var submitButton = $("#change-contact");
                                    submitButton.tooltipster({content:'',timer:2000,trigger:'custom',position:'bottom'});
                                    submitButton.tooltipster('update','An Error occurred.<br/>Try again later.'); submitButton.tooltipster('show');
                                }

                            }
                        };

                        var missCallUrl = "http://jusdias.com/readershive/dial2verify_misscall_request.php?contactNo="+contactNo.val();

                        missCallReq.open('GET', missCallUrl, true);
                        missCallReq.send();
                    }
                </script>

                <h3>Change Contact No.</h3>

                <p class="text">
                    <label for="contact-no"><b>Contact No :</b></label>
                    <input type="text" id="contact-no" name="contact-no" maxlength="10" onkeypress="validateContactNumber(event);" onfocus="contactOnFocus();" onblur="contactOnBlur();" value="<s:property value="user.userContact"/>"/>
                </p>

                <p class="submit">
                    <a href="javascript:{}" id="change-contact" class="button_small tooltip" onclick="changeContactNo();" >Change Contact No.</a>
                </p>

            </fieldset>
        </form>

    </div>
</div>
<!-- end of t2 -->
<%--<!-- tab 3 -->
<div class="tab3 tabsContent">
    <div>
        <form action="edit-profile2.htm" method="post" class="std" enctype="multipart/form-data">
            <fieldset>
                <h3>Currently Reading</h3>

                <p class="text">
                    <label><b>Book Name:</b></label>
                    <input type="text" id="cr_name" name="cr-name" value="Loosing my Virginity"/>
                </p>

                <h3>Shelves</h3>

                <p class="text">
                    <label><b>Shelf Name:</b></label>
                    <input type="text" id="sh_name" name="sh-name" value=""/>
                </p>

                <div id='TextBoxesGroup'>
                    <div id="TextBoxDiv1">
                        <p class="text">
                            <label><b>Add Book: </b></label><input type='text' id='textbox1'/>
                        </p>
                    </div>
                </div>
                <p class="submit">
                    <input type='button' value='Add' id='addButton' class="button_small"/>
                    <input type='button' value='Remove' id='removeButton' class="button_small"/>
                </p>

                <p class="submit">
                    <input type="submit" name="savechange" id="save-changes3" value="Save Changes"
                           class="button_small"/>
                    <input type="submit" name="cancel" id="cancel-changes3" value="Cancel" class="button_small"/>
                </p>
            </fieldset>
        </form>
    </div>
</div>
<!-- end of t3 -->--%>


</div>
<!-- tabbed ends here-->
</div>
<!-- mainContainer ends here-->

</div>
<div class="clearblock"></div>
</div>
</div>
</div>

    <!-- Footer -->
    <s:include value="footer.jsp" />

</div>
</div>
</div>

<script type="text/javascript" src="/js/ga.js"></script>

</body>
</html>
