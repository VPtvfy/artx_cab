/*!
 *
 * Copyright 2005, 2014 Max Zeman
 * Released under the MIT license
 *
 * Date: 2015-07-28
 */
$(
function(){
         $('body').on('submit',"form",
                      function(event){
                                       url=$(this).serialize();
                                       target=$(this).attr("target");
                                       if (target.substr(0,1)=='#'){
                                           $.ajax({data: url, success: function(html){$(target).html(html);}});
                                           event.preventDefault();}
                                     });

         $('body').on('click',"a[href!='#']",
                      function(event){
                                       url=$(this).attr("href");
                                       target=$(this).attr("target");
                                       if (target.substr(0,1)=='#'){
                                           $.ajax({data: url, success: function(html){$(target).html(html);}});
                                           event.preventDefault();}
                                      });

         $('body').on('click',"a[href='#']",
                      function(event){
                                      event.preventDefault();
                                     });

         $('body').on('change','input[type="radio"]',
                      function(event){
                                       url=$(this).attr("name")+'='+$(this).attr("value");
                                       $.ajax({data: url});
                                      });

         $('body').on('keyup.autocomplete','input[type="text"]',
                       function(event){
                                data=$(this).attr("name");
                                $(this).autocomplete({source: "_predict.php?"+data});
                                      });

         $('body').on('click',"#logo_tools_login a",
                      function(event){
                                      $("#login_form").dialog("open");
                                      event.preventDefault();
                                     });

          $("#login_form").dialog({autoOpen: false,
                                     height: 200,
                                      width: 220,
                                       show: {effect: "slide", duration: 500},
                                       hide: {effect: "slide", duration: 500},
                                   position:({my:"left top", at:"left top",  of:window}),
                                      modal: true});

         $('body').on('click',"#logo_tools_firm a",
          function(event){
                           $("#new_firm_form").dialog("open");
                           event.preventDefault();
                         });
          $("#new_firm_form").dialog({autoOpen: false,
                                     height: 600,
                                      width: 600,
                                       show: {effect: "slide", duration: 500},
                                       hide: {effect: "slide", duration: 500},
                                   position:({my:"center top", at:"center top",  of:window}),
                                      modal: true});

         $("#quick_search_keyword").focus();

         }
);
