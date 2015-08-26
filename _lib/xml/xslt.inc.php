<?
class xslt extends XsltProcessor{
public  function __construct(){
        $this->document = new DomDocument('1.0','UTF-8');
        $this->stylesheet = new DomDocument('1.0','UTF-8');}

public  function Process($stylesheet,&$docdata){

        if (gettype($stylesheet)=='object' and get_class($stylesheet)=='DOMDocument'){
            $this->stylesheet=$stylesheet;}
        else {
            $this->stylesheet->load($stylesheet);}

        switch (gettype($docdata)){
               case 'array':  $this->loadArray($docdata);break;
               case 'string': $this->loadJSON ($docdata);break;
               case 'object': $this->document=$docdata;  break;
            default: return(false);}

        // create the XSLT processor and import the stylesheet
        parent::importStylesheet($this->stylesheet);
        // transform the xml document
        return parent::transformToXML($this->document);}

private function LoadJSON(&$NodeJSON){
        $NodeArray=json_decode($NodeJSON);
        return xslt::_LoadArray($this->document,$NodeArray);}

private function LoadArray(&$NodeArray){
        return xslt::_LoadArray($this->document,$NodeArray);}

private static function _LoadArray(&$XMLDoc,&$NodeArray){
        if(is_array($NodeArray)){
          foreach ($NodeArray as $name=>$Node){
                  if (is_numeric($name)){//Nothing to create - go into 
                      xslt::_LoadArray($XMLDoc,$Node);}
                  elseif (!is_array($Node)){//Create sibling
                      $XMLDoc->appendChild(new DomElement($name,htmlspecialchars(trim($Node))));}
                  elseif(!empty($Node)){//Create child          
                      $XMLChild=$XMLDoc->appendChild( new DomElement($name));
                      xslt::_LoadArray($XMLChild,$Node);}}}
        return ($XMLDoc);}
}
?>
