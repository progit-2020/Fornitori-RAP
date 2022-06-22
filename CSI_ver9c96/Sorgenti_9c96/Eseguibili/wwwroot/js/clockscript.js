// This object will hold the digit elements
var digits = {};
// Map digits to their names (this will be an array)
var digit_to_name = 'zero one two three four five six seven eight nine'.split(' ');
var clock;

function impostaOrologio(fixIE8){
	
	// Cache some selectors
	var fix = '';
	if (fixIE8){
		fix ='IE8';
	}
	clock = $('#clock'),
		alarm = clock.find('.alarm'),
		ampm = clock.find('.ampm');

	
	// Positions for the hours, minutes, and seconds
	var positions = [
		'h1', 'h2', ':', 'm1', 'm2', ':', 's1', 's2'
	];

	// Generate the digits with the needed markup,
	// and add them to the clock

	var digit_holder = clock.find('.digits');

	for( d = 0; d < positions.length; d++ ) {	

		if(positions[d] == ':'){
			digit_holder.append('<div class="dots">');
		}
		else{
			
			var pos = $('<div>');

			for(var i=1; i<8; i++){
				var cl='d' + i + ' d' + i + fix;
				pos.append('<span class="' + cl + '"></span>');
			}

			// Set the digits as key:value pairs in the digits object
			digits[positions[d]] = pos;

			// Add the digit elements to the page
			digit_holder.append(pos);
		}

	}

	// Add the weekday names

	var weekday_names = 'LUN MAR MER GIO VEN SAB DOM'.split(' '),
		weekday_holder = clock.find('.weekdays');

	for( d = 0; d < weekday_names.length; d++ ) {		
		weekday_holder.append('<span id="_wday' + d +'" >' + weekday_names[d] + '</span>');
	}
	aggiornaOrologio();
}

function aggiornaOrologio(){

		// formato hhmmssd
		// hh is for the hours in 24-hour format,
		// mm - minutes, ss-seconds (all with leading zeroes),
		// d is for day of week 
		
		var now = document.getElementById("LBLORACORRENTE").innerHTML;

		digits['h1'].attr('class', digit_to_name[now[0]]);
		digits['h2'].attr('class', digit_to_name[now[1]]);
		digits['m1'].attr('class', digit_to_name[now[2]]);
		digits['m2'].attr('class', digit_to_name[now[3]]);
		digits['s1'].attr('class', digit_to_name[now[4]]);
		digits['s2'].attr('class', digit_to_name[now[5]]);

		// The library returns Sunday as the first day of the week.
		// Stupid, I know. Lets shift all the days one position down, 
		// and make Sunday last

		var dow = now[6];
		dow--;
		
		// Sunday!
		if(dow < 0){
			// Make it last
			dow = 6;
		}
		var weekdays = clock.find('.weekdays span');

		// Mark the active day of the week
		weekdays.removeClass('active').eq(dow);
		$('#_wday' +dow).addClass('active');

		// Set the am/pm text:
		//ampm.text(now[7]+now[8]);
		ampm.text('');
	}