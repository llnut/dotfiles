compile-scss:
	mkdir -p resources/css
	sass resources/scss/style.scss resources/css/style.css

minify-scss:
	csso -i resources/css/style.css -o resources/css/style.min.css

.PHONY: compile-scss minify-scss