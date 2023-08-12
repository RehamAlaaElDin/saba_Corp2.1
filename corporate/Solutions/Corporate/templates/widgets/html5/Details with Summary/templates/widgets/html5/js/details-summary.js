/**
| Accessibility functionality for UXP DetailsSummary widget
| @param element: node element
| @example: var DS_element = new DetailsSummary (document.getElementById('detailsSummaryElID'));
                DS_element.init();
*/

var  DetailsSummary = function(element) {
    this.element = element
}

DetailsSummary.prototype = {
    init: function() {
        //Make sure HTML5 <details> is supported
        if( this.element.tagName.toLowerCase().indexOf('details') ==  -1 ){
            return false;
        }

        this.element.addEventListener('toggle', this.handleClick.bind(this));
        this.setAriaExpanded();
    },

    handleClick: function(event) {
        this.setAriaExpanded();
    },

    setAriaExpanded: function() {
        this.element.setAttribute('aria-expanded', this.element.open)
    }
}