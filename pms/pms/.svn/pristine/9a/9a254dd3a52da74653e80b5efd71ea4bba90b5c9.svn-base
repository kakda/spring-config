(function($) {

	$.fn.blinkme = function(options) {

		var defaults = {
			bordereffect : false,
			bordercolor : 'red',
			backgroundeffect : true,
			backgroundcolor : 'yellow',
			blinkinterval : 400,
			eventstoattach : 'focus',
			eventstodetach : 'blur'
		};
		options = $.extend(defaults, options);
		return this.each(function() {
			var elem = $(this);
			var intervalobj = null;
			var bordercolor = elem.css("border-color");
			var bgcolor = elem.css("backgroundColor");
			elem.bind(options.eventstoattach, function() {
				var blinked = false;
				intervalobj = setInterval(function() {
					if (blinked == true) {
						elem.css({
							'backgroundColor' : bgcolor,
							'border-color' : bordercolor
						});
						blinked = false;
					} else {
						if (options.bordereffect == true) {
							elem.css({
								'border-color' : options.bordercolor
							});
						}
						if (options.backgroundeffect == true) {
							elem.css({
								'backgroundColor' : options.backgroundcolor
							});
						}
						blinked = true;
					}
				}, options.blinkinterval);
			});
			elem.bind(options.eventstodetach, function() {
				if (intervalobj) {
					clearInterval(intervalobj);
					elem.css({
						'backgroundColor' : bgcolor,
						'border-color' : bordercolor
					});
				}
			});
		});
	}

})(jQuery);