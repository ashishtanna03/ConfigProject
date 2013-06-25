<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sx" uri="/struts-dojo-tags" %>
<div id="header">
    <a id="header_logo" href="/index.jsp" title="BOOKS STORE">
        <img class="logo" src="/img/logo.png" alt="BOOKS STORE" />
    </a>
    <div id="header_right">
        <br/>
        <br/>

        <div class="clearblock"></div>
        <div id="header_cart">
            <a href="/cart/ViewCart.action" title="Your Shopping Cart">Cart :</a>
            <span class="ajax_cart_quantity">
                (Empty)
            </span>
        </div>

        <!-- /Block user information module HEADER --><!-- Block search module TOP -->
        <div class="clearblock"></div>
        <div id="search_block_top">
            <form method="POST" action="/search/LoadSearchResults.action" id="searchbox" name="searchForm" accept-charset="UTF-8" >
                <sx:autocompleter cssClass="search_query" id="search_query_top" name="searchQuery" list="suggestions" href="/list/GenerateList.action"
                                  loadOnTextChange="true" searchType="substring" showDownArrow="false" autoComplete="false" loadMinimumCount="1" resultsLimit="5" />
                <input type="hidden" name="pageNo" value="0" />
                <input type="hidden" name="maxResults" value="7" />
                <input type="hidden" name="newRequest" value="true" />
                <input type="hidden" name="filterGenre" value="" />
                <input type="hidden" name="filterLanguage" value="" />
                <input type="hidden" name="filterPriceRange" value="5" />
                <a href="javascript:document.searchForm.submit();"><img src="/img/search-button2.png" /></a>
            </form>
        </div>
        <!-- /Block search module TOP --><!-- TM Categories -->
        <div class="clearblock"></div>

        <script type="text/javascript">
            $(document).ready(function() {
                isLoggedIn(function(verify) {
                            if(verify==true){
                                getLoggedInInfo();
                            }
                        }
                );
            $('.jspDrag').hide();
            $('.jspScrollable').mouseenter(function () {
                $(this).find('.jspDrag').stop(true, true).fadeIn('slow');
            });

            $('.jspScrollable').mouseleave(function () {
                $(this).find('.jspDrag').stop(true, true).fadeOut('slow');
            });

            });
        </script>

        <div id="tmcategories">
            <ul id="cat" class="sf-menu">
                <li class="">
                    <a href="/index.jsp" >Home</a>
                </li>
                <li class="">
                    <a href="/how-it-works.jsp" >How It Works</a>
                </li>
                <li class="">
                    <a href="/about-us.jsp" >About Us</a>
                </li>
                <li class="">
                    <a href="/faq.jsp" >F.A.Q.</a>
                </li>
                <li class=" last">
                    <a href="/contact.jsp" >Contact Us</a>
                </li>
            </ul>
        </div>
        <!-- /TM Categories -->
    </div>
</div>