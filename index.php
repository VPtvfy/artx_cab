<?
ob_start();
error_reporting (E_ALL);
ini_set('display_errors',true);

require_once ('_cfg.inc.php');
require_once ('lib/rdbms/mysqli_lib.inc.php');
//require_once ('lib/xml/serialize.inc.php');
require_once ('lib/xml/xslt.inc.php');
require_once ('lib/session/index.inc.php');
//require_once ('lib/session/sqlite.inc.php');

$_FRONT_END=array(); //$_ client state
$_FRONT_END['event']='index';
$_FRONT_END['town']=0;
$_FRONT_END['item']=0;
$_FRONT_END['user']='guest';
$_FRONT_END['keyword']='';

$_PAGE='index';
$PageElement=array();
session::start();

// First key of REQUEST is
if (isset($_REQUEST) and is_array($_REQUEST)){
          $_FRONT_END['event']=key($_REQUEST);}

$hDB1= new sqlLink("localhost","root","root","artex_all");

    switch ($_FRONT_END['event']){
      case 'town':
            break;
      case 'login':
            $_FRONT_END['login_status']='failed';
            if(isset($_REQUEST['login']) and isset($_REQUEST['passwd'])){
               $hDB1->query($_CFG['SQL']['login'],$_REQUEST);
               if(isset($hDB1->fetch_assoc('users','user')['users'][0])){
                 $_FRONT_END['user_id']=$_REQUEST['login'];
                 $_FRONT_END['login_status']='success';};}
            break;
      case 'alpha':
            $_FRONT_END['item']=0;
            $hDB1->query($_CFG['SQL']['get_catalog_by_alpha'],$_FRONT_END);
            $PageElement=array_merge_recursive($PageElement,$hDB1->fetch_assoc('catalog','item'));
            break;
      case 'item':
            $hDB1->query($_CFG['SQL']['get_catalog_by_pid'],$_FRONT_END);
            $PageElement=array_merge_recursive($PageElement,$hDB1->fetch_assoc('catalog','item'));
            break;
      case 'find':
            if($_FRONT_END['item']>0 or mb_strlen($_FRONT_END['keyword'])>3){
               $_FRONT_END['keyword']=trim(preg_replace('/[^A-ZА-Я0-9]/i',' ',$_FRONT_END['keyword']));
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
            break;
      case 'new_firm':
            if(isset($_FRONT_END['new_firm_name'])){
               $hDB1->query($_CFG['SQL']['create_firm'],$_FRONT_END);
               $_FRONT_END['new_firm_id']=$hDB1->fetch_first()['new_firm_id'];
               $hDB1->query($_CFG['SQL']['get_firm_div'],$_FRONT_END);
               $PageElement=array_merge_recursive($PageElement,$hDB1->fetch_assoc('firm','item'));
               $hDB1->query($_CFG['SQL']['get_firm_address'],$_FRONT_END);
               $PageElement=array_merge_recursive($PageElement,$hDB1->fetch_assoc('firm','address'));
               $hDB1->query($_CFG['SQL']['get_firm_phone'],$_FRONT_END);
               $PageElement=array_merge_recursive($PageElement,$hDB1->fetch_assoc('firm','phone'));}
            break;
      case 'new_firm_item':
            if(isset($_FRONT_END['new_firm_id']) and isset($_FRONT_END['new_firm_item'])){
               $hDB1->query($_CFG['SQL']['create_firm_div'],$_FRONT_END);
               $PageElement=array_merge_recursive($PageElement,$hDB1->fetch_assoc('firm','item'));}
            break;
      case 'new_firm_address':
           if(isset($_FRONT_END['new_firm_id']) and isset($_FRONT_END['new_firm_address'])){
               $hDB1->query($_CFG['SQL']['create_firm_address'],$_FRONT_END);
               $PageElement=array_merge_recursive($PageElement,$hDB1->fetch_assoc('firm','address'));}
            break;
      case 'new_firm_phone':
            if(isset($_FRONT_END['new_firm_id']) and isset($_FRONT_END['new_firm_phone'])){
               $hDB1->query($_CFG['SQL']['create_firm_phone'],$_FRONT_END);
               $PageElement=array_merge_recursive($PageElement,$hDB1->fetch_assoc('firm','phone'));}
            break;
      default:
             $_FRONT_END['event']='index';
             //Towns
             $hDB1->query($_CFG['SQL']['get_town']);
             $PageElement=array_merge_recursive($PageElement,$hDB1->fetch_assoc('towns','town'));
             //Alphaindex
             $hDB1->query($_CFG['SQL']['get_alpha'],$_FRONT_END);
             $PageElement=array_merge_recursive($PageElement,$hDB1->fetch_assoc('catalog','alpha'));
             //Catalog
             if (isset($_FRONT_END['alpha']) and $_FRONT_END['alpha']!=''){
               $hDB1->query($_CFG['SQL']['get_catalog_by_alpha'],$_FRONT_END);}
             else{
               $hDB1->query($_CFG['SQL']['get_catalog_by_pid'],$_FRONT_END);}
             $PageElement=array_merge_recursive($PageElement,$hDB1->fetch_assoc('catalog','item'));
             break;}
session::close();

$PageData=array();
$PageData{'state'}=$_FRONT_END;
$PageData{'nodes'}=$PageElement;

$XSLT = new XSLT();
echo $XSLT->Process($_CFG['XSL_PATH'].$_PAGE.'.xsl',$PageData);

//var_dump('<pre>_FRONT_END<hr>',$_FRONT_END,'</pre>');
echo '<hr><pre>';
print_r($hDB1->querylog);
print_r($PageData{'state'});
echo '</pre>';
?>
