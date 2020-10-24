This theme is a simple bootstrap 3 extension theme for the Divseek Canada project.


![Sample Screenshot](screenshot.png)

## packages

We're using back-ported Bootstrap 4 cards from this [`npm` library ](https://github.com/martinbean/bootstrap-3-card).  This means Run 
`npm install`!

## compiling


This theme is compiled with sass and compass.

```bash
gem install compass
compass watch
```

Changes in `/scss` will be compiled into `/css`.

Note- change the environment variable in `config.rb` from development to production when finalized!

# Static pages

Static pages are in `misc/`.  These pages such as `front_page.php` or the about page are in here.