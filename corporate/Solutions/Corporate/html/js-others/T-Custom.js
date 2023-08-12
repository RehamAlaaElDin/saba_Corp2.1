/*
 * Copyright (c) Temenos India Private Limited
 *
 * This source code is used to achieve the download and print funtionalities based on the session variable value
 *  
 * Access to, alteration, duplication or redistribution of this source code in any form 
 * is not permitted without the prior written authorisation temenos.
 * 
 */

//FIX FOR FIRST RADIO BUTTON IN THE LIST HAVING FOCUS STYLING IN ERROR MODE

$(document).ready(function() {
	// call the function for footer fix
	//fixFooter();
	
	// set background images
	function set_image_bkg(){
		var img_ob = $('.ext-bkg-image'),
			w_width = $(window).width(),
			w_height = $(window).height(),
		img_url = 'url("' + img_ob.find('img').attr('src') + '")';
		img_ob.css({
		'height': w_height + 'px',
		'width': w_width + 'px',
		'background-image': img_url
		});
	}
	set_image_bkg();
	$(window).on('resize',function(){
		//fixFooter(); // call the function for footer fix on resize also
		set_image_bkg();
	});

	$("a").on("click", function(){
		$(".tc-radio").removeClass("ext-tc-radio-input");
	});

	$(window).load(function(){
		$('body').find('input').closest("div").addClass("ext-tc-radio-input");
	});
	
	// Temporary fix to remove column sorting on DataGRid table when not needed
	$('.ext-non-sortable th').on('click',function(e){
		e.stopImmediatePropagation();
	});
	
	// Temporary fix for focusing on first input in ATM/Branch locator
	$("[id$='-gmap']").on("click", function() { 
		$('#EDGE_CONNECT_PHASE').find(':input').filter(':visible:first').blur();
	});
	


});

$(window).load(function () {
	// search in two tables for manage groups in corporate
	function searchTable(inputVal) {
		var table = $('.search-table');
		table.find('tr').each(function (index, row) {
			var allCells = $(row).find('td .search-place');
			if (allCells) {
				var found = false;
				allCells.each(function (index, td) {
					var regExp = new RegExp(inputVal, 'i');
					if (regExp.test($(td).text())) {
						found = true;
						return false;
					}
				});
				if (found == true) $(row).show();
				else $(row).hide();
			}
		});
	};
	$('[id*="_searchGroups"]').keyup(function (event) {
		event.stopImmediatePropagation();
		searchTable(event.target.value);
	});
})

/*function fixFooter() {
    if (!$("html").is(".tc-footer-locked") && $(".tc-footer-container").length > 0) {
      $(".tc-footer-container").css("position", "relative")
                               .css("top", 0 + "px");
      var bottomOfFooter = $(".tc-footer-container")[0].getBoundingClientRect().bottom;                               
      //var bottomOfFooter = $(".tc-footer-container").position().top + $(".tc-footer-container").outerHeight(true);
      var pageHeight = $(window).height();
      if (bottomOfFooter < pageHeight) {
        $(".tc-footer-container").css("position", "relative")
                                 .css("top", (pageHeight - bottomOfFooter ) + "px");
      }
    } else {
      $(".tc-footer-container").css("position", "")
                               .css("top", "");
	}
  }
*/

function closeAllPopup() {
	$(".ui-dialog-content").dialog("close");
}
	function downloadDoc(ContextPathDownload){
		try{
			openWindow=window.open(ContextPathDownload+'/ServerFileRetrievalServlet?serverFilePathSessionAttrName=DOC_FILEPATH&contentType=application/octet-stream&','toolbar=0,location=0,left=100,top=100,width=800,height=800');
			openWindow.focus(); 
		}
		catch (e){
			alert("Either popup blocker is enabled or file cannot be downloaded for viewing at this moment."); 
		}
	}
	function downloadTemplate(ContextPathDownload){
		try{
			openWindow=window.open(ContextPathDownload+'/ServerFileRetrievalServlet?serverFilePathSessionAttrName=DOC_FILEPATH&contentType=application/octet-stream&printPdfFlag=DownloadFile','toolbar=0,location=0,left=100,top=100,width=800,height=800');
			openWindow.focus(); 
		}
		catch (e){
			alert("Either popup blocker is enabled or file cannot be downloaded for viewing at this moment."); 
		}
	}
	function printDoc(ContextPathPrint){
		var getAcrobatInfo = function(){
			var getBrowserName = function() {
				return this.name = this.name || function() {
					var userAgent = navigator ? navigator.userAgent.toLowerCase() : "other";
					if(userAgent.indexOf("chrome") > -1){
						return "chrome";
					} else if(userAgent.indexOf("safari") > -1){
						return "safari";
					} else if(userAgent.indexOf("msie") > -1 || navigator.appVersion.indexOf('Trident/') > 0){
						return "ie";
					} else if(userAgent.indexOf("firefox") > -1){
						return "firefox";
					} else {
						//return "ie";
						return userAgent;
					}
				}();
			};
			var getActiveXObject = function(name) {
				try{ 
					return new ActiveXObject(name); 
				} catch(e) {}
			};
			var getNavigatorPlugin = function(name) {
				for(key in navigator.plugins) {
					var plugin = navigator.plugins[key];
					if(plugin.name == name) return plugin;
				}
			};
			var getPDFPlugin = function() {
				return this.plugin = this.plugin || function() {
					if(getBrowserName() == 'ie') {
						// load the activeX control
						// AcroPDF.PDF is used by version 7 and later
						// PDF.PdfCtrl is used by version 6 and earlier
						return getActiveXObject('AcroPDF.PDF') || getActiveXObject('PDF.PdfCtrl');
					} else {
						return getNavigatorPlugin('Adobe Acrobat') || getNavigatorPlugin('Chrome PDF Viewer') || getNavigatorPlugin('WebKit built-in PDF');
					}
				}();
			};
			var isAcrobatInstalled = function() {
				return !!getPDFPlugin();
			};
			var getAcrobatVersion = function() {
				try {
					var plugin = getPDFPlugin();
					if(getBrowserName() == 'ie') {
						var versions = plugin.GetVersions().split(',');
						var latest = versions[0].split('=');
						return parseFloat(latest[1]);
					}
					if(plugin.version) return parseInt(plugin.version);
						return plugin.name
					}
					catch(e) {
						return null;
					}
				}
				// The returned object
				return {
					browser: getBrowserName(),
					acrobat: isAcrobatInstalled() ? 'installed' : false,
					acrobatVersion: getAcrobatVersion()
				};
		};
		var info = getAcrobatInfo();
		//alert(info.browser+ " " + info.acrobat + " " + info.acrobatVersion);
		if(((info.browser == "ie") || (info.browser == "safari")) && (info.acrobat == false)){
			alert("Please install pdf reader to preview the content in "+info.browser);
		}
		else{
			try{
				openWindow=window.open(ContextPathPrint+'/ServerFileRetrievalServlet?serverFilePathSessionAttrName=DOC_FILEPATH&contentType=application/pdf&printPdfFlag=PRINT','','toolbar=0,location=0,left=100,top=100,width=800,height=800'); 
				openWindow.focus(); 
			}catch (e){
				alert("Either popup blocker is enabled or file cannot be downloaded for viewing at this moment."); 
			}
		}
	}

function closeSimplePopup(argObj) {
	var $btn = $('#' + argObj.id);
	var $target = $btn.closest('.ext-simple-popup');
	$target.removeClass('opened').fadeOut();
	$('.tc-screenMask').removeClass('ext-force-screen-mask');
}
function openSimplePopup(argObj){
	var $btn = $('#' + argObj.id);
	var $container = $btn.closest('.ext-simple-popup-container');
	var $target = $container.find('.ext-simple-popup');
	$('.tc-screenMask').addClass('ext-force-screen-mask');
	$target.addClass('opened').fadeIn();
}


function findTable(p_comp, p_stopAtID){
  var p = p_comp;
  while ( p != null) {
    if ( p_stopAtID && p_stopAtID != "" && p_stopAtID == p_id ) {
      p = null;
      break;
    }	
    if ( (p.nodeName == "TABLE") || (p.id && p.id.indexOf("TBL_") >= 0 && getRowPart(p.id).length == 0 ) )
      break;
    p = p.parentNode;
  }
  return(p);
}

function fixTableV2SearchInput() {
    $("input[type=search]").addClass("tc-form-control ext-form-control col-full-xs tc-default-input tc-rounded-1 quick-filter").attr("placeholder","Quick search");
	$( "label:contains('Filter')" ).css( "color", "#FFF" )
}

function fixPopupAjax() {
	$(".tc-popup").on("click", function(e) {
		e.stopPropagation();
	})
}

//Mini Statements fix
    var isMiniStatement = false;
    var miniStatementButton = "";
    function beforeAjaxButtonActionService(controllerName, ns, context, btn, disableInput, buttonId) {
      
        //check to see if getMiniStatements....
        var $button =  $("#" + buttonId);
        if ( $button.is(".getMiniStatement") ) {
            console.log("mini statement clicked");
			Hi.addHook('postProcessResponse', moveTable);
            if (miniStatementButton == "" || miniStatementButton == "remove" || buttonId != miniStatementButton) {
                miniStatementButton = buttonId;
            } else {
                $("#" + buttonId + "_miniStatementrow").addClass("Remove").fadeOut();
                miniStatementButton = "remove";
            }
            isMiniStatement = true;
			
        }
        return true;
    }

    function afterAjaxButtonActionService(p_service, p_element, p_innerOrOuter, p_text, p_actionFlag, p_actionData, p_ajaxCaller, p_dElement, ns) {
        if (isMiniStatement && p_element.indexOf("Mini") >= 0 || p_element.indexOf("MINI_STATEMENT_MOVABLE_TABLE") >= 0) {
            if (miniStatementButton == "remove") {
                return false;
            }
			$(".Remove").removeClass('Remove');
			var miniStatementId =  miniStatementButton + "_miniStatement";
			showTransactionTable();
            //calling again in case table has been regenerated removing mini statement row...
            // createMiniStatementRow();
            
            /* return {
                continueAfterHook: true,
                element: miniStatementId,
                dElement: $("#" + miniStatementId)[0]
            }; */
        }
        else {
            return true;
        }
    }

/*     function postProcessAjaxButtonActionService(p_service, p_element, p_innerOrOuter, p_text, p_actionFlag, p_actionData, p_ajaxCaller, p_dElement, ns) {
        if (isMiniStatement && p_element.indexOf("_miniStatement") >= 0 || p_element.indexOf("MINI_STATEMENT_MOVABLE_TABLE") >= 0) {
            isMiniStatement = false;
			$(".ministatementrow > td > div, .ministatementrow > td > div > div").css("display","block");
            $(".ministatementrow").animate({
                opacity: 1
            }, 1000)
        }
    } */



    function createMiniStatementRow() {
        var miniStatementId = miniStatementButton + "_miniStatement";
        var miniStatementRow = miniStatementId + "row";
        var $button = $("#" + miniStatementButton);

        if ( $("#" + miniStatementRow).length == 0) {
            console.log("creating new row for results " + miniStatementId);
            $button.closest("tr").after("<tr id='" +  miniStatementRow + "' class='ministatementrow' style='opacity: 0;'><td colspan='10'><div id='" + miniStatementId + "' class='ministatementrowhook' style=''></div></td></tr>");
            return true;
        } 
        return false;
    }
	
	function moveTable(){
		createMiniStatementRow();
		var minitable = $("div[id$='5DE5CF97EF1A268A130731']");
		//if(minitable.length <=0) {minitable = $("div[id*='MINI_STATEMENT_MOVABLE_TABLE']");}
		var container = $(".ministatementrowhook");
		minitable.appendTo(container);
		$( "div[id$='_miniStatement']" ).find( ".col-hidden" ).removeClass('col-hidden');
		 $(".ministatementrow").css('background-color','#FDFDFD').animate({
                opacity: 1
            }, 100) 
	}
	
	function hideTransactionTable() {
		$('.ministatementrow').addClass("Remove").fadeOut();
		miniStatementButton = "";
		isMiniStatement = false;
	}
	function showTransactionTable() {
		$('.ministatementrow').show();
	}
 //END OF Mini Statements fix 


Hi.addHook('postProcessResponse', fixTableV2SearchInput);
Hi.addHook('postProcessResponse', fixPopupAjax);

