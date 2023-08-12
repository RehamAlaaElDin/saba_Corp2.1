    $%IF PRESENTATIONTYPE.LAYOUTCONTROL == "HTML Divs" || PRESENTATIONTYPE.LAYOUTCONTROL == "HTML DispInlineBlock"$
        $%IF PRESENTATIONTYPE.LAYOUTCONTROL == "HTML Divs"$
            <div style="clear:both"></div>
        $%ENDIF$
      </div>
	$%else$
	    </table>
	$%endif$     
    </form>
  $%COMMENT$
  Enable the following variables in order to change the size of the spellchecker results window; these are used in spellchecker-caller.js
  You can use a separate <script> block or you can add them to a JavaScript file already declared in your solution.
  setVariable('$$NAMESPACE$', 'uxp_spellchecker_width', 450);
  setVariable('$$NAMESPACE$', 'uxp_spellchecker_height', 200);
  $%ENDCOMMENT$
$%if PRESENTATIONTYPE != Portlet || IS_RUNPREVIEW == "Y"$
  </body>
</html>
$%endif$

