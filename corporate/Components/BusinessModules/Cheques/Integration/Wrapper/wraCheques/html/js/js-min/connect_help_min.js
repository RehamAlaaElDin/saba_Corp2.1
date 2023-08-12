var HELP_POPUP={activeHelpTrigger:null,helpPopupFocusables:[],focusElIndex:0};function showHelp(f,d,e,c,a){if(!this["beforeHelpRequest"]||beforeHelpRequest(f,d,e,c)){var b=c+"helpservletcontroller?QUESTION="+f+"&namespace="+d+"&controllername="+e;var h=calcWinPopupTop(300,window.event?window.event:a);var g=calcWinPopupLeft(600,window.event?window.event:a);window.open(b,"helpwin","toolbar=no,directories=no,status=yes,scrollbars=yes,resizeable=yes,resize=yes,menubar=no,height=300,width=600,top="+h+",left="+g)}if(this["afterHelpRequest"]){afterHelpRequest(f,d,e,c)}}function calcWinPopupTop(b,a){var c=0;b=parseFloat(b);if((a.screenY+b)>screen.height){c=screen.height-(b+30)}else{c=a.screenY}return c}function calcWinPopupLeft(b,a){var c=0;b=parseFloat(b);if((a.screenX+b)>screen.width){c=screen.width-(b+30)}else{c=a.screenX}if(c<0){c=0}return c}function calcPopupPosition(b,i,j,a){var c=(document.body.parentNode.scrollLeft!=null&&navigator.userAgent.indexOf("AppleWebKit")==-1)?document.body.parentNode.scrollLeft:window.scrollX,k=calcBrowserWidth(),g=(document.body.parentNode.scrollTop!=null&&navigator.userAgent.indexOf("AppleWebKit")==-1)?document.body.parentNode.scrollTop:window.scrollY,e=a.getBoundingClientRect().y||a.getBoundingClientRect().top,f=a.getBoundingClientRect().x||a.getBoundingClientRect().left,d=f+c,h=e+g;b=parseFloat(b);i=parseFloat(i);if(f+b>c+k){d=d-b-20;if(d<0){d=0}}else{d+=20}if(e-i<0){h=h+20}else{h=h-i}return{x:d,y:h}}function calcBrowserWidth(){return getPageSize()[0]}function calcBrowserHeight(){return getPageSize()[1]}function getPageSize(){var e,a,d,b;if(window.innerHeight&&window.scrollMaxY){e=window.innerWidth+window.scrollMaxX;a=window.innerHeight+window.scrollMaxY}else{if(document.body.scrollHeight>document.body.offsetHeight){e=document.body.scrollWidth;a=document.body.scrollHeight}else{e=document.body.offsetWidth;a=document.body.offsetHeight}}var c,f;if(self.innerHeight){if(document.documentElement.clientWidth){c=document.documentElement.clientWidth}else{c=self.innerWidth}f=self.innerHeight}else{if(document.documentElement&&document.documentElement.clientHeight){c=document.documentElement.clientWidth;f=document.documentElement.clientHeight}else{if(document.body){c=document.body.clientWidth;f=document.body.clientHeight}}}if(a>f){d=f}else{d=a}if(e>c){b=e}else{b=c}return[b,d]}var helpTimeout;function showAjaxHelp(c,d,e,i,b,g,f){if(!this["beforeHelpRequest"]||beforeHelpRequest(c,d,e,i,b)){var a=f!=null&&f.length>0;if(a){setVariable(e,"currentHelpTarget",f);removeHelpContent()}else{if(window.event){g=window.event}if(g){var h=new Object();if(window.event){h.clientX=window.event.clientX;h.clientY=window.event.clientY}else{h.clientX=g.clientX;h.clientY=g.clientY}setVariable(e,"clickEvt",h)}}ajaxHelp(c,d,e,i,b)}if(this["afterHelpRequest"]){afterHelpRequest(c,d,e,i,b)}}function hideHelpContent(){if(helpTimeout){clearTimeout(helpTimeout);helpTimeout=null}var a=document.getElementById("helpContent"),b=false;if(a!==null){a.addEventListener("mouseenter",function(){b=true},false);a.addEventListener("mouseleave",function(){a.style.display="none";HELP_POPUP.activeHelpTrigger.focus()},false);setTimeout(function(){if(!b){a.style.display="none";HELP_POPUP.activeHelpTrigger.focus()}},600)}}function removeHelpContent(){var a=document.getElementById("helpContent");if(a!=null){a.parentNode.removeChild(a)}}function handleHelpTabNavigation(){if(HELP_POPUP.focusElIndex+1>=HELP_POPUP.helpPopupFocusables.length){HELP_POPUP.focusElIndex=0}else{HELP_POPUP.focusElIndex+=1}HELP_POPUP.helpPopupFocusables[HELP_POPUP.focusElIndex].focus()}function helpDivHandleKeyDown(a,b){a.preventDefault();switch(a.keyCode){case 27:case 13:closeHelpDiv(b);break;case 9:handleHelpTabNavigation();break;default:break}}function closeHelpDiv(a){a.innerHTML="";HELP_POPUP.activeHelpTrigger.focus()}function createHelpDivContainer(){var a={"aria-live":"polite"};var b=createFloatingDiv("helpDiv",document.body,a);b.addEventListener("keydown",function(c){helpDivHandleKeyDown(c,this)});return b}document.addEventListener("DOMContentLoaded",createHelpDivContainer);function createHelpDiv(b,k,i){var c=getVariable(i,"currentHelpTarget"),e=getVariable(i,"clickEvt"),l;if(c!=null){var d=document.getElementById(c);d.innerHTML=k+d.innerHTML;d.style.display="";l=document.getElementById("helpContent");l.style.width=d.clientWidth+"px";l.style.height=d.clientHeight+"px";return}l=document.getElementById("helpDiv");if(l==null){l=createHelpDivContainer()}l.innerHTML=k;l.style.position="absolute";var j=l.firstChild.offsetWidth;var f=l.firstChild.offsetHeight;var g=calcPopupPosition(j,f,e,b);l.style.left=""+g.x+"px";l.style.top=""+g.y+"px";l.style.display="";HELP_POPUP.helpPopupFocusables=l.querySelectorAll('[tabindex="0"]');HELP_POPUP.focusElIndex=0;HELP_POPUP.activeHelpTrigger=b;if(HELP_POPUP.helpPopupFocusables.length){HELP_POPUP.helpPopupFocusables[HELP_POPUP.focusElIndex].focus()}var a=l.getElementsByClassName("HelpCloseIcon")[0];a.addEventListener("click",function(){closeHelpDiv(l)})}function clickHelpButton(b){if(b&&b.length>0){var a=document.getElementById(b);if(a&&a.onclick){a.onclick()}}}function ecBrowser(){var b,c,a;this.isIE=false;this.isNS=false;this.version=null;b=navigator.userAgent;c="MSIE";if((a=b.indexOf(c))>=0){this.isIE=true;this.version=parseFloat(b.substr(a+c.length));return}c="Netscape6/";if((a=b.indexOf(c))>=0){this.isNS=true;this.version=parseFloat(b.substr(a+c.length));return}c="Gecko";if((b.indexOf(c))>=0){this.isNS=true;this.version=6.1;return}}var brwsr=new ecBrowser();var dragObj=new Object();dragObj.zIndex=0;function dragStart(b,d){var a,c;if(d){dragObj.elNode=document.getElementById(d)}else{if(brwsr.isIE){dragObj.elNode=window.event.srcElement}if(brwsr.isNS){dragObj.elNode=b.target}if(dragObj.elNode.nodeType==3){dragObj.elNode=dragObj.elNode.parentNode}}if(brwsr.isIE){a=window.event.clientX+document.documentElement.scrollLeft+document.body.scrollLeft;c=window.event.clientY+document.documentElement.scrollTop+document.body.scrollTop}if(brwsr.isNS){a=b.clientX+window.scrollX;c=b.clientY+window.scrollY}dragObj.cursorStartX=a;dragObj.cursorStartY=c;dragObj.elStartLeft=parseInt(dragObj.elNode.style.left,10);dragObj.elStartTop=parseInt(dragObj.elNode.style.top,10);if(isNaN(dragObj.elStartLeft)){dragObj.elStartLeft=0}if(isNaN(dragObj.elStartTop)){dragObj.elStartTop=0}if(brwsr.isIE){document.attachEvent("onmousemove",dragGo);document.attachEvent("onmouseup",dragStop);window.event.cancelBubble=true;window.event.returnValue=false}if(brwsr.isNS){document.addEventListener("mousemove",dragGo,true);document.addEventListener("mouseup",dragStop,true);b.preventDefault()}}function dragGo(b){var a,c;if(brwsr.isIE){a=window.event.clientX+document.documentElement.scrollLeft+document.body.scrollLeft;c=window.event.clientY+document.documentElement.scrollTop+document.body.scrollTop}if(brwsr.isNS){a=b.clientX+window.scrollX;c=b.clientY+window.scrollY}dragObj.elNode.style.left=(dragObj.elStartLeft+a-dragObj.cursorStartX)+"px";dragObj.elNode.style.top=(dragObj.elStartTop+c-dragObj.cursorStartY)+"px";if(brwsr.isIE){window.event.cancelBubble=true;window.event.returnValue=false}if(brwsr.isNS){b.preventDefault()}}function dragStop(a){if(brwsr.isIE){document.detachEvent("onmousemove",dragGo);document.detachEvent("onmouseup",dragStop)}if(brwsr.isNS){document.removeEventListener("mousemove",dragGo,true);document.removeEventListener("mouseup",dragStop,true)}};