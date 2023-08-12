/*
 * Copyright (c) TEMENOS HEADQUARTERS SA, All rights reserved.
 *
 * This source code is protected by copyright laws and international copyright treaties,
 * as well as other intellectual property laws and treaties.
 *
 * Alteration, duplication or redistribution of this source code in any form
 * is not permitted without the prior written authorisation of TEMENOS HEADQUARTERS SA.
 *
 */

// Standard Range Slider Module Script
var StandardRangeSlider = function ()  {

    /* Slider HTML Containers */
    this.relatedInput   = null; //the input where we put the value for the server submit
    this.sliderParentEl = null; //parent container for slider components
    this.sliderEl       = null; //sliding thumb element
    this.railTrack      = null; //track of the slider
    this.valueEl        = null; //value now container
    this.valueMinEl     = null; //value min container
    this.valueMaxEl     = null; //value max container
    this.fillLower      = null; //completed area element



    /* Slider Data - default values overidden by params */
    this.valueMin       = 0;
    this.valueMax       = 100;
    this.valueNow       = 50;
    this.orientation    = 'horizontal';
    this.step           = 1; //how many to jump
    this.railSize       = 100; //width or height of the slide, depending of the orientation
    this.thumbWidth     = 20;
    this.thumbHeight    = 20;
    this.showValue      = true; //display value above/left of thumb
    this.isDisabled     = false; //state for disabled or enabled,
    this.qlr            = null; // qlr function param from the server

    //others
    this.thumbSizeMultiplier = 1 //we use multiplier because the value in pixels from the server for the thumb height/width is too small(1-10)

    this.keyCode = Object.freeze({
        'left':     37,
        'up':       38,
        'right':    39,
        'down':     40,
        'pageUp':   33,
        'pageDown': 34,
        'end':      35,
        'home':     36
    });
};

/**
| Initialize slider
| @sliderEl = DomObj element on wich the slider is initialized
| @params = Object {
    relatedInput:   DomObj
    valueMin:       Number
    valueMax:       Number
    valueNow:       Number
    orientation:    String, @values 'horizontal' || 'vertical'
    step:           Int,
    thumbRailSize:  Int,
    thumbWidth:     Int,
    thumbHeight:    Int,
    showValue:      Boolean,
    isDisabled:     Boolean,
    qlr:            Function,
}
*/
StandardRangeSlider.prototype.init = function (sliderParentEl, params) {
    //retrieve the html structure;
    this.sliderParentEl = sliderParentEl;
    this.railTrack      = this.sliderParentEl.querySelector('.rail');
    this.sliderEl       = this.railTrack.querySelector('.thumb');
    this.valueEl        = this.sliderEl.querySelector('.value');
    this.valueMinEl     = this.sliderParentEl.querySelector('.value-min');
    this.valueMaxEl     = this.sliderParentEl.querySelector('.value-max');
    this.fillLower      = this.sliderParentEl.querySelector('.fill-lower');
    
    //accessibility controls
    this.accControls    = this.sliderParentEl.querySelector('.slider-acc-controls');
    this.increaseBtn    = this.sliderParentEl.querySelector('.increase-btn');
    this.decreaseBtn    = this.sliderParentEl.querySelector('.decrease-btn');
    this.inputValue     = this.sliderParentEl.querySelector('.slider-input-value');

    if (params.relatedInput) {
        this.relatedInput = params.relatedInput;
    }
    if (params.valueMin) {
        this.valueMin = params.valueMin;
    }
    if (params.valueMax) {
        this.valueMax = params.valueMax;
    }
    if (params.valueNow) {
        this.valueNow = params.valueNow;
    }
    if (params.orientation) {
        this.orientation = params.orientation;
    }
    if (params.step) {
        this.step = params.step;
    }
    if (params.railSize) {
        this.railSize = params.railSize;
    }
    if (params.isDisabled) {
        this.isDisabled = params.isDisabled;
    }
    if (params.thumbWidth) {
        this.thumbWidth = params.thumbWidth * this.thumbSizeMultiplier;
    }
    if (params.thumbHeight) {
        this.thumbHeight = params.thumbHeight * this.thumbSizeMultiplier;
    }
    if (params.qlr) {
        this.qlr = params.qlr;
    }
    if (params.showValue && params.showValue == 'N') {
        this.showValue = false
    }
    if (params.showAccControls !== 'Y') {
        this.accControls.style.display = 'none';
    }

    /**
     |RENDER SETTINGS
    */
    //orientation and rail size
    if (this.orientation === 'vertical') {
        this.sliderParentEl.classList.add('vertical');
        this.railTrack.style.height = this.railSize + 'px';
    } else {
        this.sliderParentEl.classList.add('horizontal');
        this.railTrack.style.width = this.railSize + 'px';
    }

    //hide current moving value
    if ( ! this.showValue ) {
        this.valueEl.style.display = 'none';
    }

    //min & max value
    this.valueMinEl.innerHTML = this.valueMin;
    this.valueMaxEl.innerHTML = this.valueMax;

    //set ARIA attributes
    this.sliderEl.setAttribute('aria-orientation',  this.orientation);
    this.sliderEl.setAttribute('aria-valuemin',     this.valueMin);
    this.sliderEl.setAttribute('aria-valuemax',     this.valueMax);
    this.sliderEl.setAttribute('aria-valuenow',     this.valueNow);

    //tab-index
    if (this.sliderEl.tabIndex != 0 && !params.readOnly) {
        this.sliderEl.tabIndex = 0;
    }

    this.sliderEl.style.width = this.thumbWidth + 'px';
    this.sliderEl.style.height = this.thumbHeight + 'px';

    if (this.orientation === 'vertical') {
        this.sliderEl.style.left = (this.thumbWidth / -2) + 1 + 'px';
    } else {
        this.sliderEl.style.top = (this.thumbHeight / -2) + 1 + 'px';
    }

    this.moveStandardRangeSliderTo(this.valueNow);
    if (this.isDisabled) {//no more interaction if is disabled
        this.sliderParentEl.style.display = "none";
        this.relatedInput.style.display = "block";
        return false;
    }

    this.sliderEl.addEventListener('keydown',    this.handleKeyDown.bind(this));
    // add onmousedown, move, and onmouseup
    this.sliderEl.addEventListener('mousedown',  this.handleMouseDown.bind(this));

    this.sliderEl.addEventListener('focus',      this.handleFocus.bind(this));
    this.sliderEl.addEventListener('blur',       this.handleBlur.bind(this));

    var self = this;
    this.increaseBtn.addEventListener('mousedown', function(){
        self.moveStandardRangeSliderTo(self.valueNow + self.step);
    });
    this.decreaseBtn.addEventListener('mousedown', function(){
        self.moveStandardRangeSliderTo(self.valueNow - self.step);
    });
    this.inputValue.addEventListener('change', function(){
        self.moveStandardRangeSliderTo(this.value);
    })

    //position value-min/value-max containers
    this.valueMinEl.style.left  = -this.valueMinEl.getBoundingClientRect().width - 10 + 'px';
    this.valueMaxEl.style.right = -this.valueMaxEl.getBoundingClientRect().width - 10 + 'px';

    //dynamic width value for input
    var railWidth        = this.railTrack.getBoundingClientRect().width,
        increaseBtnWidth = this.increaseBtn.getBoundingClientRect().width,
        decreaseBtnWidth = this.decreaseBtn.getBoundingClientRect().width,
        inputValueWidth  = railWidth - increaseBtnWidth - decreaseBtnWidth -5;

    this.inputValue.style.width = inputValueWidth + 'px';
};

/**
| Move Thumb to specified value
*/
StandardRangeSlider.prototype.moveStandardRangeSliderTo = function (value) {

    if (value > this.valueMax) {
        value = this.valueMax;
    }
    
    if (value < this.valueMin) {
        value = this.valueMin;
    }

    //handle control buttons state
    if (value >= this.valueMax) {
        this.increaseBtn.disabled = "disabled";
    } else {
        this.increaseBtn.disabled = ""
    }
    
    if (value <= this.valueMin) {
        this.decreaseBtn.disabled = "disabled";
    } else {
        this.decreaseBtn.disabled = "";
    }

    this.valueNow = value;
    this.inputValue.value = value;

    this.sliderEl.setAttribute('aria-valuenow', this.valueNow);

    if (this.orientation === 'vertical') {
        var pos = Math.round( ((this.valueMax - this.valueNow) * this.railSize ) / (this.valueMax - this.valueMin) ) - (this.thumbHeight / 2);
        this.sliderEl.style.top = pos + 'px';
        this.fillLower.style.height = this.railSize - pos + 'px';
    } else {

        var pos = Math.round(
            ((this.valueNow - this.valueMin) * this.railSize) / (this.valueMax - this.valueMin)
          ) - (this.thumbWidth / 2);
        this.sliderEl.style.left = pos + 'px';
        this.fillLower.style.width = this.railSize - (this.railSize - pos) + (this.thumbWidth / 2) + 'px';
    }

    if (this.valueEl) {
        this.valueEl.innerHTML = this.valueNow.toString();
    }
    if (this.relatedInput) {
        this.relatedInput.value = this.valueNow;
    }

};

/**
| KeyDown Action Manager
*/
StandardRangeSlider.prototype.handleKeyDown = function (event) {

    var flag = false;
    switch (event.keyCode) {
        case this.keyCode.left:
        case this.keyCode.down:
            this.moveStandardRangeSliderTo(this.valueNow - this.step);
            flag = true;
            break;

        case this.keyCode.right:
        case this.keyCode.up:
            this.moveStandardRangeSliderTo(this.valueNow + this.step);
            flag = true;
            break;

        case this.keyCode.home:
            this.moveStandardRangeSliderTo(this.valueMin);
            flag = true;
            break;

        case this.keyCode.end:
            this.moveStandardRangeSliderTo(this.valueMax);
            flag = true;
            break;

        default:
            break;
    }

    if (flag) {
        event.preventDefault();
        event.stopPropagation();
    }
};

/**
 | "focus" class add or remove on thumb and rail
*/
StandardRangeSlider.prototype.handleFocus = function (event) {
    this.sliderEl.classList.add('focus');
    this.railTrack.classList.add('focus');
};

/**
| Slider focus out handler
*/
StandardRangeSlider.prototype.handleBlur = function (event) {
    this.sliderEl.classList.remove('focus');
    this.railTrack.classList.remove('focus');
    this.qlr();
};

/**
| Mouse down event with move and release dependencies
*/
StandardRangeSlider.prototype.handleMouseDown = function (event) {
    var self = this;
    var handleMouseMove = function (event) {
        var computedValue = 0; //
        if (self.orientation === 'vertical') {
            var railY = self.railTrack.getBoundingClientRect().y || self.railTrack.getBoundingClientRect().top;
            var diffY = event.pageY - railY - window.scrollY;
            computedValue = self.valueMax - parseInt(((self.valueMax - self.valueMin) * diffY) / self.railSize);
        } else {
            var railX = self.railTrack.getBoundingClientRect().x || self.railTrack.getBoundingClientRect().left;
            var diffX = event.pageX - railX - window.scrollX;
            computedValue = self.valueMin + parseInt(((self.valueMax - self.valueMin ) * diffX) / self.railSize);
        }
        if ( computedValue % self.step  == 0 ) {
            self.moveStandardRangeSliderTo(computedValue);
        }
        event.preventDefault();
        event.stopPropagation();
    };

    var handleMouseUp = function (event) {
        document.removeEventListener('mousemove', handleMouseMove);
        document.removeEventListener('mouseup', handleMouseUp);
        self.qlr();
    };

    // bind a mousemove event handler to move pointer
    document.addEventListener('mousemove', handleMouseMove);

    // bind a mouseup event handler to stop tracking mouse movements
    document.addEventListener('mouseup', handleMouseUp);

    event.preventDefault();
    event.stopPropagation();

    // Set focus to the clicked handle
    this.sliderEl.focus();
};