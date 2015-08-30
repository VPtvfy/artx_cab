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
         parser=new DOMParser();
         xmlDoc=parser.parseFromString('<response>'+response+'</response>',"text/xml");
         xmlDoc=xmlDoc.getElementsByTagName('response')[0];
         for (i=0;i<xmlDoc.childNodes.length;i++){
              target=xmlDoc.childNodes[i].id;
              if (typeof(target) !== 'undefined'){
                  document.getElementById(target).innerHTML='Loading';
                  document.getElementById(target).innerHTML=xmlDoc.childNodes[i].innerHTML;}}}
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

         $('body').on('change','input[type="radio"]',
                      function(event){
                                       url=$(this).attr("name")+'='+$(this).attr("value");
                                       $.ajax({data: url, 
                                            success: function(html){router(html);}});
                                      });

         $('body').on('keyup.autocomplete','input[type="text"]',
                       function(event){
                                data=$(this).attr("name");
                                $(this).autocomplete({source: "_predict.php?"+data,
                                              deferRequestBy:500});
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

          $("#new_firm").dialog({autoOpen: false,
                                     height: 600,
                                      width: 900,
                                       show: {effect: "slide", duration: 200},
                                       hide: {effect: "slide", duration: 100},
                                   position:({my:"center top", at:"center top",  of:window}),
                                      modal: true});

         $("#quick_search_keyword").focus();

         }
);
