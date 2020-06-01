/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


function initRequest() {
    if (window.XMLHttpRequest) {
        if (navigator.userAgent.indexOf('MSIE') != -1) {
            isIE = true;
        }
        return new XMLHttpRequest();
    } else if (window.ActiveXobject) {
        isIE = true;
        return new ActiveXObject("Microsoft.XMLHTTP");
    }
}
var requete;
function changeLanguage()
{
    requete = new XMLHttpRequest();
    url = "changeLaguage";
    requete.open("POST", url, true);
    requete.onreadystatechange = afficher;
    requete.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
    requete.send(null);
}

function afficher() {
    if ((requete.readyState == 4) && (requete.status == 200))
        window.location.reload();
}
            