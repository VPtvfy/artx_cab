<?xml version="1.0" encoding="utf-8"?><!-- DWXMLSource="../catalog.xml" -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:template name="find_form">
    <div id="location_div">
     <ul>
       <li><input checked="" name="city" id="allcity" onclick="changeLocation(&quot;http://localhost/spravo4nik&quot;, &quot;city|&quot;)" type="radio">
           <label for="allcity"><span>Искать во всех городах</span></label>
          </input>
      </li>
       <li><input name="city" id="city0" onclick="changeLocation(&quot;http://localhost/spravo4nik&quot;, &quot;city|Павлодар&quot;)" value="Павлодар" type="radio">
           <label for="city0"><span>Искать только в г. Павлодар</span></label>
          </input>
      </li>
       <li><input name="city" id="city1" onclick="changeLocation(&quot;http://localhost/spravo4nik&quot;, &quot;city|Семей&quot;)" value="Семей" type="radio">
           <label for="city1"><span>Искать только в г. Семей</span></label>
          </input>
      </li>
       <li><input name="city" id="city2" onclick="changeLocation(&quot;http://localhost/spravo4nik&quot;, &quot;city|Усть-Каменогорск&quot;)" value="Усть-Каменогорск" type="radio">
           <label for="city2"><span>Искать только в г. Усть-Каменогорск</span></label>
           </input>
      </li>
    </ul>
  </div>


<!--script type="text/javascript">
$(document).ready(function() {
		//$("#location_div").hide();
		//$("#choose_location").click(function(event){
			/*if ($("#location_div").is(":visible") ) {
				$("#choose_arrow").attr("src", "http://localhost/spravo4nik/templates/artex/images/lang-arrow.png");
				//$("#location_div").slideUp();
			}
			else {*/
				//event.stopPropagation();
				//$("#choose_arrow").attr("src", "http://localhost/spravo4nik/templates/artex/images/up-lang-arrow.png");

				// get values for locations
				$.ajax({
					type		: "GET",
					cache		: false,
					url		: "http://localhost/spravo4nik/include/get_locations.php",
					data		: null,
					success: function(data) {

						var split_loc=data.split("|");
						var no = split_loc.length;
						
						var crt_loc = "";						
						var cl="";
						if(crt_loc=="") cl=" checked ";
						var content ="<ul><li><input type='radio' "+cl+" name='city' id='allcity' onclick='changeLocation(\"http://localhost/spravo4nik\", \"city|\")'><label for='allcity'><span>Искать во всех городах</span></label></li>";
						//						
						for (var j=0;j<no;j++) {
							
							var cl="";
							if(crt_loc==split_loc[j].trim()) cl=" checked ";
							//content += "<li><a href='javascript:;'"+cl+" onclick='changeLocation(\"http://localhost/spravo4nik\", \"city|"+split_loc[j]+"\")'>"+split_loc[j]+"</a></li>";
							content += "<li><input type='radio' "+cl+"name='city' id='city"+j+"' onclick='changeLocation(\"http://localhost/spravo4nik\", \"city|"+split_loc[j].trim()+"\")' value='"+split_loc[j].trim()+"'><label for='city"+j+"'><span>Искать только в г. "+split_loc[j]+"</span></label></li>";
							
					
							
							
							//if( j>0 && j%10==0 && j!=no-1) content+= "</ul><div class=\"clearfix\"></div><ul>";
						}
						content +="</ul>";

						$("#location_div").html(content);
					
						//$("#location_div").css({ top: $("#choose_location").position().top+20, left: 		$("#choose_location").position().left});
						//$("#location_div").slideDown();

					} // end data
				});// end ajax
			//} // end else
		//});
		/*$(document).click(function(){
			$("#choose_arrow").attr("src", "http://localhost/spravo4nik/templates/artex/images/lang-arrow.png");
			$("#location_div").slideUp();
		});*/
	
	
});

</script-->
<form name="qsearch" id="qsearch" method="post" action="http://localhost/spravo4nik/listings.php" onsubmit="return !window.xjs &amp;&amp; checksizesearch()">
			<div id="search_for">ЧТО БУДЕМ ИСКАТЬ:</div>
                          <input id="qs_keyword" autocomplete="off" name="qs_keyword" value="" placeholder="Артекс или 209098" size="35" type="text"/>
 			  <input name="order" value="date_added" type="hidden"/>
			  <input name="order_way" value="desc" type="hidden"/>
			  <input name="Search" id="Search" value="" type="submit"/>
</form>
<div id="bg-search2"></div>

			<!--script type="text/javascript">
			$(document).ready(function() {
				$("#qs_keyword").focus(function(){
					var thisVal = $(this).val();
					if(thisVal.length > 2){
						$('.quick_search_loading').css('display','block');
						$('#search_tooltip_wrap').css('display','block');
						$.get('./altz_search.php?a=gt&k='+thisVal, function(data){
							//console.log('data');
							if(data){
								$('.quick_search_loading').css('display','none');
								$('.quick_search_results').html(data);
							}
						});
					};
				});
				$("#qs_keyword").blur(function(){
					$(this).stop().animate({display: 'none'},400, function(){
						$('#search_tooltip_wrap').css('display','none');
						$('.quick_search_loading').css('display','none');
					});
				});
				$("#qs_keyword").keyup(function(){
					//console.log('keyup');
					var thisVal = $(this).val();
					$('.quick_search_loading').css('display','block');
					if(thisVal.length > 2){
						$('#search_tooltip_wrap').css('display','block');
						$.get('./altz_search.php?a=gt&k='+thisVal, function(data){
							//console.log('data');
							if(data){
								$('.quick_search_loading').css('display','none');
								$('.quick_search_results').html(data);
							}
						});
					} else {
						$('#search_tooltip_wrap').css('display','none');
						$('.quick_search_loading').css('display','none');
						$('.quick_search_results').html('');
					}
				});
			});
			</script-->
		
		