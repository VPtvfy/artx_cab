/*!
 *
 * Copyright 2005, 2014 Max Zeman
 * Released under the MIT license
 *
 * Date: 2015-07-28
 */

if (document.location.search+document.location.hash!=''){
    document.location.replace(document.location.protocol+'//'+document.location.host+document.location.pathname);}

function router(response){
         htmlDoc=$.parseHTML(response);
         $.each(htmlDoc,function( i, el ){
                target=el.id;
                if (typeof(target) !== 'undefined'){
                    document.getElementById(target).innerHTML=el.innerHTML;}});}
$(
function(){
         $('body').on('submit',"form",
                      function(event){
                                       url=$(this).serialize();
//                                       target=$(this).attr("target");
                                       $.ajax({data: url, 
                                            success: function(html){router(html);}});
                                       event.preventDefault();
                                     });

         $('body').on('click',"a[href!='#']",
                      function(event){
                                       url=$(this).attr("href");
//                                       target=$(this).attr("target");
                                       $.ajax({data: url, 
                                            success: function(html){router(html);}});
                                       event.preventDefault();
                                      });

         $('body').on('click',"a[href='#']",
                      function(event){
                                      event.preventDefault();
                                     });

         $('body').on('change','input[type="button"]',
                      function(event){
                                       data=$(this).parents('form:first').serialize();
                                       $.ajax({data: data, 
                                            success: function(html){router(html);}});

                                      });
         $('body').on('change','input[type="checkbox"]',
                      function(event){
                                       data=$(this).parents('form:first').serialize();
                                       $.ajax({data: data, 
                                            success: function(html){router(html);}});
                                      });

         $('body').on('change','input[type="image"]',
                      function(event){
                                       data=$(this).parents('form:first').serialize();
                                       $.ajax({data: data, 
                                            success: function(html){router(html);}});
                                      });

         $('body').on('change','input[type="radio"]',
                      function(event){
                                       data=$(this).parents('form:first').serialize();
                                       $.ajax({data: data, 
                                            success: function(html){router(html);}});
                                      });

         $('body').on('change','input[type="submit"]',
                      function(event){
                                       data=$(this).parents('form:first').serialize();
                                       $.ajax({data: data, 
                                            success: function(html){router(html);}});
                                      });

         $('body').on('change','select',
                      function(event){
                                       data=$(this).parents('form:first').serialize();
                                       $.ajax({data: data, 
                                            success: function(html){router(html);}});
                                      });

         $('body').on('keyup.autocomplete','input[type="text"]',
                      function(event){
                                     data=$(this).parents('form:first').serialize();
                                     $(this).autocomplete({source: "_predict.php?"+data, deferRequestBy:500});
                                     });

         $('body').on('click',"#logo_tools_login a",
                      function(event){
                                      $("#login_form").dialog("open");
                                      event.preventDefault();
                                     });

          $("#login_form").dialog({autoOpen: false,
                                     height: 200,
                                      width: 220,
                                       show: {effect: "slide", duration: 200},
                                       hide: {effect: "slide", duration: 100},
                                   position:({my:"left top", at:"left top",  of:window}),
                                      modal: true});

         $('body').on('click',"#logo_tools_firm a",
          function(event){
                           $("#new_firm").dialog("open");
                           event.preventDefault();
                         });

          $('#new_firm').dialog({autoOpen: false,
                                     height: 600,
                                      width: 900,
                                       show: {effect: "slide", duration: 200},
                                       hide: {effect: "slide", duration: 100},
                                   position:({my:"center top", at:"center top",  of:window}),
                                      modal: true});

         $('fieldset div div').selectable();

         $('#quick_search_keyword').focus();

         }
);
