<?
ob_start();
error_reporting (E_ALL);
ini_set('display_errors',true);

require_once ('_cfg.inc.php');
require_once ('_lib/rdbms/mysqli_lib.inc.php');
require_once ('_lib/xml/xslt.inc.php');
require_once ('_lib/session/frontend.inc.php');

$_FRONT_END['town']='';
$_FRONT_END['keyword']='';

$_PAGE='index';
$PageElement=array();
session::start();

/*echo '<pre><hr>$_REQUEST<br>';
print_r($_REQUEST);

echo '<hr>$_SESSION<br>';
print_r($_SESSION['FRONT_END']);

echo '<hr>$_FRONT_END<br>';
print_r($_FRONT_END);
echo '<br></pre>';*/
?>
<html>
<body>
<div>
<form>
<input type='text' name='keyword' value='<?echo $_FRONT_END['keyword'];?>'></input><?if(session::exists('keyword')){echo "E";}if(session::set('keyword')){echo "S";}if(session::diff('keyword')){echo "D";}?>
<input type='text' name='town'    value='<?echo $_FRONT_END['town'];?>'></input><?if(session::exists('town')){echo "E";}if(session::set('town')){echo "S";}if(session::diff('town')){echo "D";}?>
<input type='text' name='alpha'   value='<?echo $_FRONT_END['alpha'];?>'></input><?if(session::exists('alpha')){echo "E";}if(session::set('alpha')){echo "S";}if(session::diff('alpha')){echo "D";}?>
<input type='submit'></input>
</form>
</div>
</body>
</html>
<?session::close();?>