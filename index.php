<?
ob_start();
error_reporting (E_ALL);
ini_set('display_errors',true);

require_once ('_cfg.inc.php');
require_once ('_lib/rdbms/mysqli_lib.inc.php');
require_once ('_lib/xml/xslt.inc.php');
require_once ('_lib/session/frontend.inc.php');

$_FRONT_END['item']=0;
$_FRONT_END['town']=0;
$_FRONT_END['keyword']='';

$_FRONT_END['user']='guest';

$_PAGE='index';
$_SYNC=array();
$PageElement=array();

session::start();

$hDB1= new sqlLink("localhost","root","root","artex_all");
#$hDB1= new sqlLink("95.59.26.103","moderator","9ab97e0958c6c98c44319b8d06b29c94","cabinet");
#$hDB1= new sqlLink("46.101.227.162","root","digitaloceandbpwd","cabinet");

 //Catalog
 if (session::diff('alpha','item')){
    if (session::exists('alpha')){
         $hDB1->query($_CFG['SQL']['get_catalog_by_alpha'],$_FRONT_END);
         $PageElement=array_merge_recursive($PageElement,$hDB1->fetch_assoc('catalog','item'));
         $_SYNC[]=array('alpha'=>'true');}

    if (session::exists('item')){
       $hDB1->query($_CFG['SQL']['get_catalog_by_pid'],$_FRONT_END);
       $PageElement=array_merge_recursive($PageElement,$hDB1->fetch_assoc('catalog','item'));
       $_SYNC[]=array('items'=>'true');}}

 //Firm
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
    $_SYNC=array('index'=>'true');}

 if (session::exists('new_firm') and session::set('new_firm_name')){
 //New firm
    if($_FRONT_END['new_firm_name']!=''){
       $hDB1->query($_CFG['SQL']['create_firm'],$_FRONT_END);
       $_FRONT_END['new_firm_id']=$hDB1->fetch_first()['firm_id'];
       $hDB1->query($_CFG['SQL']['get_firm_div'],$_FRONT_END);
       $PageElement=array_merge_recursive($PageElement,$hDB1->fetch_assoc('firms','item'));
       $hDB1->query($_CFG['SQL']['get_firm_address'],$_FRONT_END);
       $PageElement=array_merge_recursive($PageElement,$hDB1->fetch_assoc('firms','address'));
       $hDB1->query($_CFG['SQL']['get_firm_phone'],$_FRONT_END);
       $PageElement=array_merge_recursive($PageElement,$hDB1->fetch_assoc('firms','phone'));
       $_SYNC[]=array('new_firm'=>'true');}}

 if (session::exists('new_firm_item') and session::set('new_firm_id','new_firm_item_name')){
    if($_FRONT_END['new_firm_id']>0 and $_FRONT_END['new_firm_item_name']!=''){
       $hDB1->query($_CFG['SQL']['create_firm_div'],$_FRONT_END);
       $hDB1->query($_CFG['SQL']['get_firm_div'],$_FRONT_END);
       $PageElement=array_merge_recursive($PageElement,$hDB1->fetch_assoc('firms','item'));
       $_SYNC[]=array('new_firm_item'=>'true');}}


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
