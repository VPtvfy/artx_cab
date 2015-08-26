<html>
<body>
<div>
<form>
<input type='text' name='keyword'></input>
</form>
</div>
<?
ob_start();
error_reporting (E_ALL);
ini_set('display_errors',true);

require_once ('_cfg.inc.php');
require_once ('_lib/rdbms/mysqli_lib.inc.php');
require_once ('_lib/xml/xslt.inc.php');
require_once ('_lib/session/frontend.inc.php');

$_FRONT_END['keyword']='';

$_PAGE='index';
$PageElement=array();
session::start();
echo '<hr>$_REQUEST<br>';
var_dump($_REQUEST);
echo '<hr>$_SESSION<br>';
var_dump($_SESSION['FRONT_END']);
echo '<hr>$_FRONT_END<br>';
var_dump($_FRONT_END);
echo '<br>';
echo '<br>';
echo '<hr>$_SESSION::diff()<br>';
var_dump(session::diff());
echo '<hr>$_SESSION::diff(keyword)<br>';
var_dump(session::diff('keyword'));
session::close();
?>
</body>
</html>
