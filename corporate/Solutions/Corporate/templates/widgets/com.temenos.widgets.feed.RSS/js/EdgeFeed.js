
(function ($) {
		var globalValue = [];
		var globalContainer = [];
    $.fn.stories = function (options) {

        var defaultValues = {
            FeedUrl: "",
            MaxCount: 5,
            ShowDesc: true,
            ShowPubDate: true,
            DescCharacterLimit: 0,
            TitleLinkTarget: "_blank"
        };

        var settings = $.extend(defaultValues, options, settings);
				globalValue.push(settings);
        var id = $(this).attr("id");
        var feedContainer = $("#" + id);
				globalContainer.push(feedContainer);
        feedContainer.empty().append('<img src="./templates/widgets/com.temenos.widgets.feed.RSS/image/loading.gif" />');

				YUI.add("feedModule", function(Y) {
            Y.SomeSettings = {
                widgetSettings: globalValue,
                feedHolder: globalContainer
            }
        });
    };



				YUI().use('yql', 'feedModule', function(Y){

					var tempQuery = '';

					for (var index = 0; index < Y.SomeSettings.widgetSettings.length; index ++) {
							tempQuery += "select * from rss(0," + Y.SomeSettings.widgetSettings[index].MaxCount + ") where url = '" + Y.SomeSettings.widgetSettings[index].FeedUrl + "';"
					}

					var query = 'SELECT * FROM yql.query.multi WHERE queries="' + tempQuery + '"';

					var q = Y.YQL(query, function(r){
							//r now contains the result of the YQL Query as a JSON

							for (feedNr = 0; feedNr < r.query.results.results.length; feedNr++) {
								var feed = r.query.results.results[feedNr].item // get feed as array of entries
								var feedmarkup = '<div class="edgeFeed">';
								for (var i=0; i<feed.length; i++){
									feedmarkup += '<div class="entryTitle">'
									feedmarkup += '<a href="' + feed[i].link.replace(/"/g, '\\"') + '">';
									feedmarkup += feed[i].title.replace(/"/g, '\\"') + '</a>'; // title and link

									if (Y.SomeSettings.widgetSettings.ShowPubDate) {
											feedmarkup += '<p>' + new Date(feed[i].pubDate).toDateString() + '</p>'; // title and link
									}

									if (Y.SomeSettings.widgetSettings.ShowDesc) {
											feedmarkup += '<p maxlength="' + Y.SomeSettings.widgetSettings.DescCharacterLimit + '">' + feed[i].description.replace(/"/g, '\"') + '</p>';
									}

									feedmarkup += '</div>';
								}
								feedmarkup += '</div>';

								Y.SomeSettings.feedHolder[feedNr][0].innerHTML = feedmarkup;
							}
					});
    });

})(jQuery);
