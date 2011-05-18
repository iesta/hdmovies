// js client side for hdmovie webapp using Sammy & jquery
(function($) {

	var clearPage = function(){
		$('#main').html('');
	}

	// 1 we set some routes ans actions      
	var app = $.sammy('#main', function() {
		this.use('Template');

		this.get('#/', function(context) {
			context.log("HDMovie app loaded");
			clearPage();
			$('#message').html("HDMovie app loaded");
		});

		this.get('#/movies', function(context) {
			clearPage();
			this.load('../movies.json').then(function(json) {
				
				$.each(json.movies, function(i,movie) {
					context.render('templates/movies.template', {movie: movie}).appendTo(context.$element());
				});
				
			});
		});
		
		this.get('#/movie/:id', function(context) {
		        this.movie = this.movies[this.params['id']];
		        if (!this.movie) { return this.notFound(); }
		        this.partial('templates/movie.template');
      	});

		this.get('#/test', function(context) {
			clearPage();
			context.log('Test works');
			$('#message').html("Test loaded");
		});
	});


	// 2 we call a route
	$(function() {
		app.run('#/');
	});


	})(jQuery);