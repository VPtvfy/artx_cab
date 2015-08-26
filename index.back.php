<?
ob_start();
error_reporting (E_ALL);
ini_set('display_errors',true);

require_once ('_cfg.inc.php');
require_once ('lib/rdbms/mysqli_lib.inc.php');
require_once ('lib/xml/xslt.inc.php');
require_once ('lib/session/frontend.inc.php');

$_FRONT_END=array(); //$_ client state
$_FRONT_END['event']='index';
$_FRONT_END['town']=0;
$_FRONT_END['item']=0;
$_FRONT_END['user']='guest';
$_FRONT_END['keyword']='';
$_FRONT_END['new_firm_id']=0;
$_FRONT_END['new_firm_name']='';
$_FRONT_END['new_firm_item_name']='';
$_FRONT_END['new_firm_item_name']='';

$_PAGE='index';
$PageElement=array();
session::start();

$hDB1= new sqlLink("localhost","root","root","artex_all");

    switch ($_FRONT_END['event']){
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
      case 'town':
      case 'find':
            $hDB1->query($_CFG['SQL']['get_catalog_by_pid'],$_FRONT_END);
            $PageElement=array_merge_recursive($PageElement,$hDB1->fetch_assoc('catalog','item'));
            if($_FRONT_END['item']>0 or mb_strlen($_FRONT_END['keyword'])>3){
//               $_FRONT_END['keyword']=trim(preg_replace('/[^qwertyuiopasdfghjklzxcvbnmйцукенгшщзхъфывапролджэячсмитьбю0123456789]/i',' ',$_FRONT_END['keyword']));
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
               $_FRONT_END['new_firm_id']=$hDB1->fetch_first()['firm_id'];
               $hDB1->query($_CFG['SQL']['get_firm_div'],$_FRONT_END);
               $PageElement=array_merge_recursive($PageElement,$hDB1->fetch_assoc('firms','item'));
               $hDB1->query($_CFG['SQL']['get_firm_address'],$_FRONT_END);
               $PageElement=array_merge_recursive($PageElement,$hDB1->fetch_assoc('firms','address'));
               $hDB1->query($_CFG['SQL']['get_firm_phone'],$_FRONT_END);
               $PageElement=array_merge_recursive($PageElement,$hDB1->fetch_assoc('firms','phone'));}
            break;
      case 'new_firm_item':
            if(isset($_FRONT_END['new_firm_id']) and isset($_FRONT_END['new_firm_item_name'])){
               $hDB1->query($_CFG['SQL']['create_firm_div'],$_FRONT_END);
               $hDB1->query($_CFG['SQL']['get_firm_div'],$_FRONT_END);
               $PageElement=array_merge_recursive($PageElement,$hDB1->fetch_assoc('firms','item'));}
            break;
      case 'new_firm_address':
           if(isset($_FRONT_END['new_firm_id']) and isset($_FRONT_END['new_firm_address'])){
               $hDB1->query($_CFG['SQL']['create_firm_address'],$_FRONT_END);
               $hDB1->query($_CFG['SQL']['get_firm_address'],$_FRONT_END);
               $PageElement=array_merge_recursive($PageElement,$hDB1->fetch_assoc('firms','address'));}
            break;
      case 'new_firm_phone':
            if(isset($_FRONT_END['new_firm_id']) and isset($_FRONT_END['new_firm_phone'])){
               $hDB1->query($_CFG['SQL']['create_firm_phone'],$_FRONT_END);
               $hDB1->query($_CFG['SQL']['get_firm_phone'],$_FRONT_END);
               $PageElement=array_merge_recursive($PageElement,$hDB1->fetch_assoc('firms','phone'));}
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
             break;}
session::close();

$PageData=array();
$PageData{'state'}=$_FRONT_END;
$PageData{'nodes'}=$PageElement;

$XSLT = new XSLT();
echo $XSLT->Process($_CFG['XSL_PATH'].$_PAGE.'.xsl',$PageData);
echo '<pre>';var_dump($_FRONT_END,$hDB1->querylog);echo '</pre>';
?>