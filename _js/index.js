/*!
 *
 * Copyright 2005, 2014 Max Zeman
 * Released under the MIT license
 *
 * Date: 2015-07-28
 */

if (document.location.search+document.location.hash!=''){
    document.location.replace(document.location.protocol+'//'+document.location.host+document.location.pathname);}


$(document).ajaxSuccess(function(event, xhr, settings) {
            htmlDoc=$.parseHTML(xhr.responseText,true);
            $.each(htmlDoc,function( i, element ){
                   target=element.id;
                   tagname=element.tagName;
                   if (target!==''){
                       document.getElementById(target).innerHTML=element.innerHTML;}
                   else
                   if (tagname.toUpperCase() === String('SCRIPT')){
                       $.globalEval(element.innerHTML);}})
             });

$(
function(){
         $('body').on('click',"a[href='#']",
                      function(event){
                                     event.preventDefault();
                                     });

         $('body').on('click',"a[href='##']",
                      function(event){
                                     url=$(this).attr("href");
                                     $.ajax({data: url});
                                     event.preventDefault();
                                     });

         $('body').on('click','form a',
                      function(event){
                                     url=$(this).parents('form:first').serialize();
                                     url=url+'&'+$(this).attr("href");
                                     $.ajax({data: url});
                                     event.preventDefault();
                                     });

         $('body').on('click','input[type="button"]',
                      function(event){
                                     url=$(this).parents('form:first').serialize();
                                     url=url+'&'+$(this).attr("name");
                                     $.ajax({data: url});
                                     event.preventDefault();
                                     });

         $('body').on('click','input[type="submit"]',
                      function(event){
                                     url=$(this).parents('form:first').serialize();
                                     url=url+'&'+$(this).attr("name");
                                     $.ajax({data: url});
                                     event.preventDefault();
                                     });

         $('body').on('submit',"form",
                      function(event){
                                     url=$(this).serialize();
                                     $.ajax({data: url});
                                     event.preventDefault();
                                     });

         $('body').on('change','input[type="checkbox"]',
                      function(event){
                                     url=$(this).parents('form:first').serialize();
                                     $.ajax({data: url});
                                     });

         $('body').on('change','input[type="radio"]',
                      function(event){
                                     url=$(this).parents('form:first').serialize();
                                     $.ajax({data: url});
                                     });

         $('body').on('change','input[type="image"]',
                      function(event){
                                     url=$(this).parents('form:first').serialize();
                                     $.ajax({data: url});
                                     });

         $('body').on('change','input[type="submit"]',
                      function(event){
                                     url=$(this).parents('form:first').serialize();
                                     $.ajax({data: url});
                                     });

         $('body').on('change','select',
                      function(event){
                                     url=$(this).parents('form:first').serialize();
                                     $.ajax({data: url});
                                     });

         $('body').on('keyup.autocomplete','input[type="text"]',
                      function(event){
                                     url=$(this).parents('form:first').serialize();
                                     $(this).autocomplete({source: "_predict.php?"+url, deferRequestBy:500});
                                     });





         $('body').on('click',"#logo_tools_login a",
                      function(event){
                                     $("#login_form").dialog("open");
                                     event.preventDefault();
                                     });

          $("#login_form").dialog({autoOpen: false,
                                       show: {effect: "slide", direction: "up", duration: 200},
                                       hide: {effect: "slide", direction: "up", duration: 100},
                                   position: ({my:"right top", at:"right top",  of:window}),
                                      modal: true});

         $('body').on('click',"#logo_tools_firm a",
          function(event){
                           $("#edit_firm").dialog("open");
                           event.preventDefault();
                         });

         $('body').on('click',"#logo_tools_export a",
          function(event){
                           $("#export").dialog("open");
                           event.preventDefault();
                         });

          $("#edit_firm").dialog({autoOpen: false,
                                   height: 600,
                                    width: 900,
                                     show: {effect: "slide", duration: 200},
                                     hide: {effect: "slide", duration: 100},
                                 position: ({my:"right top", at:"right top",  of:"event"}),
                                    modal: true});

          $("#export").dialog({autoOpen: false,
                                 height: 600,
                                  width: 900,
                                   show: {effect: "slide", duration: 200},
                                   hide: {effect: "slide", duration: 100},
                               position: ({my:"right top", at:"right top",  of:"event"}),
                                  modal: true});

         $("#quick_search_keyword").focus(); 
         }
);
