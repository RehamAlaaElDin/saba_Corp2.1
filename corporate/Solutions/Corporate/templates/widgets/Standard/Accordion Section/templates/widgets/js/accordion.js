/**
| Standard Accordion Module - vanilla js
| @params  == { accordionId: String, activeTabId: String, slideEffect: String}
*/

var StandardAccordion = function( params ){

    //acordion element
    this.accordion = document.getElementById( params.accordionId );

    //active tab passed from the server
    this.activeTabId = params.activeTabId;

    //has slide effect, passed from the server
    this.hasSlideEffect = params.hasSlideEffect;

    //allow multiple panes to be open in the same time
    this.allowMultiple = false;

    //allow last open pane to be closed
    this.allowToggle = true;

    //list of clickable accordion buttons
    this.triggers = [];

    //content
    this.panels = [];
}

StandardAccordion.prototype = {

    keyCode: Object.freeze({
        'TAB': 9,
        'RETURN': 13,
        'ESC': 27,
        'SPACE': 32,
        'PAGEUP': 33,
        'PAGEDOWN': 34,
        'END': 35,
        'HOME': 36,
        'LEFT': 37,
        'UP': 38,
        'RIGHT': 39,
        'DOWN': 40
    }),

    init: function () {
        var accordion = this.accordion;

        //debugger;

        //gather accordion elements in property sets
        this.triggers = accordion.querySelectorAll('.accordion-trigger');
        this.panels = accordion.querySelectorAll('.accordion-panel');

        //handle keydown
        accordion.addEventListener('keydown', this.handleKeydown.bind(this));

        //handle clicks
        for (var index = 0; index < this.triggers.length; index++){
            this.triggers[index].addEventListener('click', this.handleClickOnTrigger.bind(this));
        }


        //check if Slide Effect is active and apply 'animate' class and a max-height for animation effect

        for (var index = 0; index < this.panels.length; index++){
            if( this.hasSlideEffect === "Y" ){
                this.panels[index].style.maxHeight = this.panels[index].offsetHeight + 100 + 'px'; //add an extra max of 100px for possible scrolling issues
                this.panels[index].classList.add('animate');
            }
            this.panels[index].setAttribute('hidden', true);
        }

        //activate required tab
        if (document.getElementById( this.activeTabId )) {
            document.getElementById( this.activeTabId ).click();
        }
    },

    //click behavior on the accordion trigger buttons
    handleClickOnTrigger: function (event) {

        var target = event.target,
            //panel = target.parentElement.nextElementSibling,

            // Check if the current toggle is expanded.
            isExpanded = target.getAttribute('aria-expanded') == 'true',
            active = this.accordion.querySelector('[aria-expanded="true"]')
        ;

        // without allowMultiple, close the open accordion
        if(!this.allowMultiple && active && active !== target){

            // Set the expanded state on the triggering element
            active.setAttribute('aria-expanded', 'false');
            // Hide the accordion sections, using aria-controls to specify the desired section
            document.getElementById(active.getAttribute('aria-controls')).setAttribute('hidden', '');

            // When toggling is not allowed, clean up disabled state
            if(!this.allowToggle){
                active.removeAttribute('aria-disabled');
            }
        }

        if (!isExpanded) {
            target.setAttribute('aria-expanded', true);
            document.getElementById(target.getAttribute('aria-controls')).removeAttribute('hidden');

            if(!this.allowToggle){
                target.setAttribute('aria-disabled', 'true');
            }
        } else if (this.allowToggle && isExpanded ) {
            target.setAttribute('aria-expanded', 'false');
            document.getElementById(target.getAttribute('aria-controls')).setAttribute('hidden', '');
        }

    },

    // Bind keyboard behaviors on the main accordion container
    handleKeydown: function (event) {


        var target = event.target,
            key = event.keyCode.toString(),
            ctrlModifier = (event.ctrlKey && key.match(/33|34/));
        ;


        if (target.classList.contains('accordion-trigger')) {

            if (key.match(/38|40/) || ctrlModifier) { // UP and DOWN keydown
                var index = Object.values(this.triggers).indexOf(target),
                    direction = (key.match(/34|40/)) ? 1 : -1,
                    length = this.triggers.length,
                    newIndex = (index + length + direction) % length;

                this.triggers[newIndex].focus();
                event.preventDefault();
            }
        }

    }
}