<?
ob_start();
error_reporting (E_ALL);
ini_set('display_errors',true);

require_once ('_cfg.inc.php');
require_once ('_lib/rdbms/mysqli_lib.inc.php');
require_once ('_lib/xml/xslt.inc.php');
require_once ('_lib/session/frontend.inc.php');

$_FRONT_END['alpha']='';
$_FRONT_END['item']=0;
$_FRONT_END['town']=0;
$_FRONT_END['keyword']='';

$_FRONT_END['user']='guest';

$_PAGE='index';
$_SYNC=array();
$PageElement=array();

session::start();

//$hDB1= new sqlLink("localhost","root","digitaloceandbpwd","cabinet");
$hDB1= new sqlLink("localhost","root","root","artex_all");

//Categories
 if (session::diff('alpha','item')){
    if (session::exists('alpha')){
       $_FRONT_END['item']=-1;
       $hDB1->query($_CFG['SQL']['get_catalog_by_alpha'],$_FRONT_END);
       $PageElement=array_merge_recursive($PageElement,$hDB1->fetch_assoc('catalog','item'));
       $_SYNC[]=array('alpha'=>'true');}

    if (session::exists('item')){
       $_FRONT_END['alpha']='';
       $hDB1->query($_CFG['SQL']['get_catalog_by_pid'],$_FRONT_END);
       $PageElement=array_merge_recursive($PageElement,$hDB1->fetch_assoc('catalog','item'));
       $_SYNC[]=array('items'=>'true');}}

//Firms
 if (session::diff('keyword','item','town')){
    if($_FRONT_END['item']>0 or mb_strlen($_FRONT_END['keyword'])>3){
       $_FRONT_END['keyword']=trim(preg_replace('/( +)+/',' ',$_FRONT_END['keyword']));
       $_FRONT_END['query_str']=substr(join('|',explode(' ',' '.$_FRONT_END['keyword'])),1);
       $hDB1->query($_CFG['SQL']['find'],$_FRONT_END);
       $hDB1->query($_CFG['SQL']['find_firm'],$_FRONT_END);
       $PageElement=array_merge_recursive($PageElement,$hDB1->fetch_assoc('firms','firm'));
       $hDB1->query($_CFG['SQL']['find_item'],$_FRONT_END);
       $PageElement=array_merge_recursive($PageElement,$hDB1->fetch_assoc('firms','item'));
       $hDB1->query($_CFG['SQL']['find_address'],$_FRONT_END);
       $PageElement=array_merge_recursive($PageElement,$hDB1->fetch_assoc('firms','address'));
       $hDB1->query($_CFG['SQL']['find_phone'],$_FRONT_END);
       $PageElement=array_merge_recursive($PageElement,$hDB1->fetch_assoc('firms','phone'));}
       $_SYNC[]=array('firms'=>'true');}

 if (session::diff()){
//Towns
    $hDB1->query($_CFG['SQL']['get_town']);
    $PageElement=array_merge_recursive($PageElement,$hDB1->fetch_assoc('towns','town'));
//Alphaindex
    $hDB1->query($_CFG['SQL']['get_alpha'],$_FRONT_END);
    $PageElement=array_merge_recursive($PageElement,$hDB1->fetch_assoc('catalog','alpha'));
//Categories
    $hDB1->query($_CFG['SQL']['get_catalog_by_pid'],$_FRONT_END);
    $PageElement=array_merge_recursive($PageElement,$hDB1->fetch_assoc('catalog','item'));
    $_SYNC=array('index'=>'true');}
 
// Tools --------------------------------------------------------------------------------------------------

 if (session::exists('firm') and session::set('firm_name')){
//New firm
    if($_FRONT_END['firm_name']!=''){
       $hDB1->query($_CFG['SQL']['create_firm'],$_FRONT_END);
       $_FRONT_END['firm_id']=$hDB1->fetch_first()['firm_id'];
       $hDB1->query($_CFG['SQL']['get_firm_div'],$_FRONT_END);
       $PageElement=array_merge_recursive($PageElement,$hDB1->fetch_assoc('firms','item'));
       $hDB1->query($_CFG['SQL']['get_firm_address'],$_FRONT_END);
       $PageElement=array_merge_recursive($PageElement,$hDB1->fetch_assoc('firms','address'));
       $hDB1->query($_CFG['SQL']['get_firm_phone'],$_FRONT_END);
       $PageElement=array_merge_recursive($PageElement,$hDB1->fetch_assoc('firms','phone'));
       $_SYNC[]=array('edit_firm'=>'true');}}

 if (session::set('firm_id') and session::set('item_id')){
       $hDB1->query($_CFG['SQL']['get_firm_div'],$_FRONT_END);
       $PageElement=array_merge_recursive($PageElement,$hDB1->fetch_assoc('firms','item'));
       $_SYNC[]=array('edit_firm_items'=>'true');}



 if (session::exists('export') and session::set('export_town_id')){
//Export
    if($_FRONT_END['export_town_id']>0){ 
    $_['town_id']=$_FRONT_END['export_town_id'];
    $hDB1->query($_CFG['SQL']['get_catalog_by_town'],$_);
    $PageElement=array_merge_recursive($PageElement,$hDB1->fetch_assoc('catalog','item'));
    $_SYNC[]=array('export_form_items'=>'true');}}

 if (session::exists('export') and session::diff('export_town_id','export_item_id')){
    if($_FRONT_END['export_town_id']>0 and $_FRONT_END['export_item_id']>0){ 
//Export
       $hDB1->query($_CFG['SQL']['export_firm'],$_FRONT_END);
       $hDB1->query($_CFG['SQL']['find_firm'],$_FRONT_END);
       $PageElement=array_merge_recursive($PageElement,$hDB1->fetch_assoc('firms','firm'));
       $hDB1->query($_CFG['SQL']['find_local_address'],$_FRONT_END);
       $PageElement=array_merge_recursive($PageElement,$hDB1->fetch_assoc('firms','address'));
       $hDB1->query($_CFG['SQL']['find_phone'],$_FRONT_END);
       $PageElement=array_merge_recursive($PageElement,$hDB1->fetch_assoc('firms','phone'));
       $_SYNC[]=array('export'=>'true');}}

session::close();

$PageData=array();
$PageData{'sync'}=$_SYNC;
$PageData{'state'}=$_FRONT_END;
$PageData{'nodes'}=$PageElement;

$XSLT = new XSLT();
echo $XSLT->Process($_CFG['XSL_PATH'].$_PAGE.'.xsl',$PageData);

$_hdebug = fopen("debug.html", "w+");
fwrite ($_hdebug,sprintf('<html><head><meta http-equiv="Content-Type" content="text/html; charset=utf-8"></head><body><pre>%s<hr>%s<hr>%s</pre></body><html>',var_export($_FRONT_END,true),var_export($hDB1->querylog,true),var_export($PageData,true)));
fclose($_hdebug);
?>
