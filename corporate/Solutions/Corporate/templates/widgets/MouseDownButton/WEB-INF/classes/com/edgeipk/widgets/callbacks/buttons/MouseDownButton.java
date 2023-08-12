package com.edgeipk.widgets.callbacks.buttons;

import com.acquire.intelligentforms.FormSession;
import com.acquire.intelligentforms.entities.presentation.PresentationObject;
import com.acquire.intelligentforms.presentation.engine.elements.IWidgetCallBack;
import com.acquire.intelligentforms.presentation.util.StringBuilderAdapter;

public class MouseDownButton implements IWidgetCallBack
{
    /* (non-Javadoc)
     * @see com.acquire.intelligentforms.presentation.engine.elements.IWidgetCallBack#updateContent(com.acquire.intelligentforms.FormSession, com.acquire.intelligentforms.entities.presentation.PresentationObject, com.acquire.intelligentforms.presentation.util.StringBuilderAdapter, int)
     */
    @Override
    public void updateContent( FormSession p_formSession, PresentationObject p_presObject, StringBuilderAdapter p_result, int p_startLocation )
    {
        while (p_result.indexOf("onclick", p_startLocation) > 0)
        {
            int start = p_result.indexOf("onclick", p_startLocation);
            p_result.replace(start, start + "onclick".length(), "onmousedown");
            p_startLocation = start + 1;
        }
    }

}
