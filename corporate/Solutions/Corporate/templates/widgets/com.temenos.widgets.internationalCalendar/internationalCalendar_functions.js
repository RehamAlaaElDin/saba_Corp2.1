;(function ($) {

window.com=window.com || {};
window.com.temenos = window.com.temenos || {};
window.com.temenos.widgets = window.com.temenos.widgets || {};
window.com.temenos.widgets.internationalCalendar = {

	hiddenElement:undefined,
	$el:undefined,
	$icon:undefined,
	settings: {
		elementId: undefined,
		hiddenElement: undefined,
		calendarType: "persian",
		dateFormat: "dd/mm/yyyy",
		timeFormat: "",
		calendarTimePicker : true,
		calendarLanguage: "",
		showTimePart: "",
		showIcon: "",
		serverDateFormat: "dd/mm/yyyy",
		serverTimeFormat: "",
		serverSeparatorFormat: "T",
		calendarImage: "",
		locale: "",
		minDate: "",
		maxDate: "",
		weekendDays: "",
		weekDaysCheckmark: "",
		preValidHook:null,
		hiddenFieldValueHook:null,
		legalHolidaysCheckmark: "",
		language: "",
		legalHolidays: ""
	},

	setInputValue: function(value) {
		var isWeekend, isHoliday;

		if (this.settings.weekDaysCheckmark) { isWeekend = this.checkWeekend(value, this.settings.weekendDays); }
		if (this.settings.legalHolidaysCheckmark) { isHoliday = this.checkHoliday(value, this.settings.legalHolidays); }

		if (!isHoliday && !isWeekend) {
				var dp = this.$el.data("datepicker");
				dp.date = value;
				dp.selectDate(value);
		}
	},

	localizeWeeksAndMonths:function(weeksString, weeksSmallString, monthsString, monthsSmallString) {

		if (!weeksString && !weeksSmallString && !monthsString && !monthsSmallString){
		return false;
		}

		var weeksArray = [];
		if (weeksString.length) {
			var weeksArray = weeksString.split(',').map(function(value){
				return value.trim();
			});
		}

		var weeksSmallArray = [];
		if (weeksSmallString.length) {
			var weeksSmallArray = weeksSmallString.split(',').map(function(value){
				return value.trim();
			});
		}

		var monthsArray = [];
		if (monthsString.length) {
			var monthsArray = monthsString.split(',').map(function(value){
				return value.trim();
			});
		}

		var monthsSmallArray = [];
		if (monthsSmallString.length) {
			var monthsSmallArray = monthsSmallString.split(',').map(function(value){
				return value.trim();
			});
		}

		return {
		days: weeksArray,
		daysShort:  weeksSmallArray,
		daysMin:  weeksSmallArray,
		months: monthsArray,
		monthsShort: monthsSmallArray
		};
	},

	convertToDate:function(ideDate){
		return fecha.parse(ideDate,"DD/MM/YYYY");
	},

	checkWeekend: function (date, weekendDays) {
		var isWeekendDay = weekendDays.filter(function(item) {
			return date.getDay() == item;
		}).length > 0;

		if (isWeekendDay) return true;
		return false;
	},

	checkHoliday: function (date, legalHolidays) {
		if (legalHolidays) {
			legalHolidays = legalHolidays.split(",");
			var isHoliday = legalHolidays.filter(function(item){
				return new Date(fecha.parse(item, 'DD/MM/YYYY')).setHours(0,0,0,0) == new Date(date).setHours(0,0,0,0) }
			).length > 0;		}

		if (isHoliday) return true;
		return false;
	},

	convertToFechaFormat: function (dateFormat, delimiter, timeFormat, showTimePart) {
		dateFormat = dateFormat.replace(/m/g, "M");

		if (showTimePart) {
			timeFormat = timeFormat.replace(/h/g, "H");
			timeFormat = timeFormat.replace(/i/g, "m");
		} else {
			timeFormat = "";
		}

		if (timeFormat.length == 0) { delimiter = "" };

		var format = dateFormat + delimiter + timeFormat;
		format = format.replace(/y/g, "Y");
		format = format.replace(/d/g, "D");

		return format;
	},

	convertToCalendarFormat: function (dateFormat, timeFormat, delimiter) {
		delimiter = (delimiter != undefined) ? delimiter : " ";
		if (dateFormat.indexOf('MMM') != -1) {
			dateFormat = dateFormat.replace('MMM', "M");
		} else if (dateFormat.indexOf('M') != -1) {
			dateFormat = dateFormat.replace(/M/g, "m");
		}

		if (dateFormat.indexOf('dddd') != -1) {
			dateFormat = dateFormat.replace('dddd', "DD");
		} else if (dateFormat.indexOf('ddd') != -1) {
			dateFormat = dateFormat.replace('ddd', "D");
		} else if (dateFormat.indexOf('D') != -1) {
			dateFormat = dateFormat.replace(/D/g, "d");
		}

		if (timeFormat.indexOf('HH') != -1) {
			timeFormat = timeFormat.replace('HH', "hh");
		}
		if (timeFormat.indexOf('m') != -1) {
			timeFormat = timeFormat.replace(/m/g, "i");
		}
		if (timeFormat.indexOf('a') != -1) {
			timeFormat = timeFormat.replace("a", "aa");
		}

		dateFormat = dateFormat.replace(/Y/g, "y");

		var format = dateFormat + delimiter + timeFormat;

		return format;
	},

	createIcon:function(){
		if (this.settings.calendarImage.length > 0 && this.settings.showIcon == 'True' && this.$el.parent().find("img").length <= 0) {
		    this.$icon = $("<img class='-ec-calendar-image-' src='" + this.settings.calendarImage + "' title='calendar_image' onerror='this.style.display=\"none\"'/>");
			this.$el.after(this.$icon);
		}
	},

	onClickIcon: function (event) {
    this.$el.focus();
	return false;
	},

	delegateEvents: function () {
		if (this.$icon) { this.$icon.on("mouseup", this.onClickIcon.bind(this)); }
		this.$el.on("change", this.onChangeCalendar.bind(this));
	},

	initCalendar: function () {
		var that = this;

		switch (this.settings.calendarType) {
			case "gregorian":
				direction = "ltr";
				digitType = "WesternArabic";
				break;
			case "persian":
				direction = "rtl";
				digitType = "EasternArabic";
				break;
			default:
				direction = "ltr";
				digitType = "WesternArabic";
		}

		this.$el.datepicker({
				calendarType: this.settings.calendarType,
				timeFormat: this.convertToCalendarFormat("", this.settings.timeFormat, ""),
				dateFormat: this.convertToCalendarFormat(this.settings.dateFormat, "", ""),
				serverDateFormat: this.settings.serverDateFormat,
				serverSeparatorFormat: this.settings.serverSeparatorFormat,
				serverTimeFormat: this.settings.serverTimeFormat,
				classes: this.settings.hiddenElementId,
				timepicker: this.settings.calendarTimePicker,
				direction: typeof $.fn.datepicker.language[this.settings.locale] === "undefined" ? direction : $.fn.datepicker.language[this.settings.locale]["textDirection"],
				digitType: typeof $.fn.datepicker.language[this.settings.locale] === "undefined" ? digitType : $.fn.datepicker.language[this.settings.locale]["digitType"],
				minDate: this.settings.minDate,
				maxDate: this.settings.maxDate,
				language: this.settings.language || this.settings.calendarLanguage || this.settings.locale ? $.extend(true, {}, $.fn.datepicker.language[this.settings.calendarLanguage] || {}, $.fn.datepicker.language[this.settings.locale],this.settings.language) : false,
				onHide: function(dp, animationCompleted){
					if (animationCompleted) {
						that.$el.trigger("change");
					}
				},
				obj: this,
				onRenderCell: function (date, cellType) {
					var cellObj = {disabled: false};

					if (cellType == 'day') {
							if (that.checkWeekend(date, that.settings.weekendDays)) {
								cellObj.classes='-ec-weekend-';
								if (that.settings.weekDaysCheckmark) {
									cellObj["disabled"] = true;
								}
							}
							if (that.checkHoliday(date, that.settings.legalHolidays)) {
								cellObj.classes='-ec-holiday-';
								if (that.settings.legalHolidaysCheckmark) {
									cellObj["disabled"] = true;
								}
							}
					}

					return cellObj;
				}
			});

			this.createIcon();
			this.delegateEvents();
	},

	getCurentValue:  function () {
		return fecha.parse(this.hiddenElement.value,this.convertToFechaFormat(this.settings.serverDateFormat, this.settings.serverSeparatorFormat, this.settings.serverTimeFormat, this.settings.showTimePart));
	},

	onChangeCalendar: function () {
		var inputDate;
		var fullFormat = this.settings.showTimePart ? this.convertToFechaFormat(this.settings.dateFormat, " ", this.settings.timeFormat, this.settings.showTimePart) : this.convertToFechaFormat(this.settings.dateFormat, "", "", this.settings.showTimePart);
//Pre-validation
		var preValue = this.$el.val();
		if (typeof this.settings.preValidHook == "function") {		
			preValue = this.settings.preValidHook(preValue,this.settings.calendarType);
		}
		
		switch (this.settings.calendarType) {
				case "persian":
						inputDate = fecha.parse(preValue, fullFormat, this.$el.datepicker("getI18SettingInFechaFormat"), jDate);
						break;
				default:
						inputDate = fecha.parse(preValue, fullFormat, this.$el.datepicker("getI18SettingInFechaFormat"));
		}

		if (inputDate) {
			this.setInputValue(inputDate);
		}

		var dateObj = (this.settings.calendarType == "persian") ? inputDate._date : inputDate;

		if (dateObj) {
			this.setNormalizedFormat(dateObj);
		}
		this.hiddenElement.value = dateObj ? fecha.format(dateObj,this.convertToFechaFormat(this.settings.serverDateFormat, this.settings.serverSeparatorFormat, this.settings.serverTimeFormat, this.settings.showTimePart),{}):preValue;
//Hidden field value
		if (typeof this.settings.hiddenFieldValueHook == "function") {			
			var hiddenFieldValue = this.hiddenElement.value;
			this.settings.hiddenFieldValueHook(hiddenFieldValue);
		}
		this.hiddenElement.onchange();
	},
	setNormalizedFormat: function(dateObj) {
		this.$el.attr("data-normalized-format", fecha.format(dateObj, this.convertToFechaFormat(this.settings.serverDateFormat, this.settings.serverSeparatorFormat, this.settings.serverTimeFormat, this.settings.showTimePart), {}));
	},
	getCalendar: function(widgetCalendarSettings) {
		this.settings = $.extend({},this.settings,widgetCalendarSettings);
		this.settings.weekendDays = this.settings.weekendDays.split(",");
		var that = this;

		this.$el = $(document.getElementById(this.settings.elementId));
		this.hiddenElement = document.getElementById(this.settings.hiddenElementId);

		// custom language for weeks and months

		var currentValue = this.getCurentValue();
		if (currentValue){
			currentValue = (this.settings.calendarType == "persian") ? new jDate(currentValue) : currentValue;
		}

		this.initCalendar();

		if (currentValue) {
			that.setInputValue(currentValue);		
			var dateObj = (this.settings.calendarType == "persian") ? currentValue._date : currentValue;		
			if (dateObj) {
				this.setNormalizedFormat(dateObj);
			}
		}
	}
}
})(jQuery);
