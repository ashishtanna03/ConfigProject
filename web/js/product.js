//update display of the large image
function displayImage(domAAroundImgThumb)
{
    if (domAAroundImgThumb.attr('href'))
    {
        var newSrc = domAAroundImgThumb.attr('href').replace('thickbox','large');
        if ($('#bigpic').attr('src') != newSrc)
        {
            $('#bigpic').fadeIn('fast', function(){
                $(this).attr('src', newSrc).show();
                if (typeof(jqZoomEnabled) != 'undefined' && jqZoomEnabled)
	                $(this).attr('alt', domAAroundImgThumb.attr('href'));
            });
        }
        $('#views_block li a').removeClass('shown');
        $(domAAroundImgThumb).addClass('shown');
    }
}

// Serialscroll exclude option bug ?
function serialScrollFixLock(event, targeted, scrolled, items, position)
{
	serialScrollNbImages = $('#thumbs_list li:visible').length;
	serialScrollNbImagesDisplayed = 3;

	var leftArrow = position == 0 ? true : false;
	var rightArrow = position + serialScrollNbImagesDisplayed >= serialScrollNbImages ? true : false;

	$('a#view_scroll_left').css('cursor', leftArrow ? 'default' : 'pointer').css('display', leftArrow ? 'none' : 'block').fadeTo(0, leftArrow ? 0 : 1);
	$('a#view_scroll_right').css('cursor', rightArrow ? 'default' : 'pointer').fadeTo(0, rightArrow ? 0 : 1).css('display', rightArrow ? 'none' : 'block');
	return true;
}

// Change the current product images regarding the combination selected
function refreshProductImages(id_product_attribute)
{
	$('#thumbs_list_frame').scrollTo('li:eq(0)', 700, {axis:'x'});
	$('#thumbs_list li').hide();
	id_product_attribute = parseInt(id_product_attribute);

	if (typeof(combinationImages) != 'undefined' && typeof(combinationImages[id_product_attribute]) != 'undefined')
	{
		for (var i = 0; i < combinationImages[id_product_attribute].length; i++)
			$('#thumbnail_' + parseInt(combinationImages[id_product_attribute][i])).show();
	}
	if (i > 0)
	{
		var thumb_width = $('#thumbs_list_frame >li').width()+parseInt($('#thumbs_list_frame >li').css('marginRight'));
		$('#thumbs_list_frame').width((parseInt((thumb_width + 10)* i) - 10) + 'px'); //  Bug IE6, needs 3 pixels more ?
	}
	else
	{
		$('#thumbnail_' + idDefaultImage).show();
		displayImage($('#thumbnail_'+ idDefaultImage +' a'));
	}
	$('#thumbs_list').trigger('goto', 0);
	serialScrollFixLock('', '', '', '', 0);// SerialScroll Bug on goto 0 ?
}

//To do after loading HTML
$(document).ready(function()
{
	//init the serialScroll for thumbs
	/*$('#thumbs_list').serialScroll({
		items:'li:visible',
		prev:'a#view_scroll_left',
		next:'a#view_scroll_right',
		axis:'x',
		offset:0,
		start:0,
		stop:true,
		onBefore:serialScrollFixLock,
		duration:700,
		step: 2,
		lazy: true,
		lock: false,
		force:false,
		cycle:false
	});

	$('#thumbs_list').trigger('goto', 1);// SerialScroll Bug on goto 0 ?
	$('#thumbs_list').trigger('goto', 0); */



	//add a link on the span 'view full size' and on the big image
	$('span#view_full_size, div#image-block img').click(function(){
		$('#views_block li a.shown').click();
	});

	//catch the click on the "more infos" button at the top of the page
	$('div#short_description_block p a.button').click(function(){
		$('#more_info_tab_desc').click();
		$.scrollTo( '#more_info_tabs', 1100 );
	});

	$('#review-header').click(function(){
		$.scrollTo( '#review', 1100 );
	});
	
	$('#write-a-review').click(function(){
		$.scrollTo( '#write-comment', 1100 );
	});
	
	$('div#primary_block h1 a').click(function(){
		$('#more_info_tab_about_author').click();
		$.scrollTo( '#more_info_tabs', 1100 );
	});

    $('div#price-tag #tooltip1 a').click(function(){
        $('#more_info_tab_data_sheet').click();
        $.scrollTo( '#more_info_tabs', 1100 );
    });

	$('.thickbox').fancybox({
		'hideOnContentClick': true,
		'transitionIn'	: 'elastic',
		'transitionOut'	: 'elastic'
	});
});
