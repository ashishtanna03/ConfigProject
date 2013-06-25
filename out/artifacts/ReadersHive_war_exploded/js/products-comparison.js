$('document').ready(function(){
	reloadProductComparison();
});

reloadProductComparison = function() {
	$('a.cmp_remove').click(function(){
	
		var idProduct = $(this).attr('rel').replace('ajax_id_product_', '');
		
		$.ajax({
  			url: 'products-comparison.php?ajax=1&com.action=remove&id_product=' + idProduct,
 			async: false,
  			success: function(){
  				return true;
    		}
		});	
	});
	
	$('input:checkbox.comparator').click(function(){
	
		var idProduct = $(this).attr('value').replace('comparator_item_', '');
		var checkbox = $(this);
		
		if(checkbox.is(':checked'))
		{
			$.ajax({
	  			url: 'products-comparison.php?ajax=1&com.action=add&id_product=' + idProduct,
	 			async: true,
	  			success: function(data){
	  				if (data == '0')
	  				{
	  					checkbox.attr('checked', false);
		    			alert(max_item);
	  				}
	  			},
	    		error: function(){
	    			checkbox.attr('checked', false);
	    		}
			});	
		}
		else
		{
			$.ajax({
	  			url: 'products-comparison.php?ajax=1&com.action=remove&id_product=' + idProduct,
	 			async: true,
	  			success: function(data){
	  				if (data == '0')
	  					checkbox.attr('checked', true);
	    		},
	    		error: function(){
	    			checkbox.attr('checked', true);
	    		}
			});	
		}
	});
}