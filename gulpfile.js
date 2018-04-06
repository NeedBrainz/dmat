var gulp = require('gulp'),
  postcss = require('gulp-postcss'),
  tailwindcss = require('tailwindcss'),
  browserSync = require('browser-sync').create(),
  purgecss = require('gulp-purgecss');

var
  dest         = '.tmp/',   // The "hot" build folder used by Middleman's external pipeline
  css_source   = ['css/*.css'],
  css_dest     = dest+'css/';

// Custom extractor for purgeCSS, to avoid stripping classes with `:` prefixes
class TailwindExtractor {
  static extract(content) {
    return content.match(/[A-z0-9-:\/]+/g) || [];
  }
}

gulp.task('postcss', function() {
  const plugins = [
    require('postcss-import')(),
    tailwindcss('./tailwind.js'),
    require('autoprefixer')(),
    require('postcss-calc')(),
    require('postcss-color-function')(),
    require('postcss-custom-properties')(),
    require('postcss-discard-comments')(),
    require('postcss-custom-media')(),
    require('cssnano')({zindex: false}),
  ];
  const replace = require('gulp-replace');
  const options = {};
  return gulp.src(css_source)
    .pipe(postcss(plugins, options))
    .pipe(replace('!important', ''))
    .pipe(gulp.dest(css_dest));
});

gulp.task('purgecss', gulp.series(function(done){
  gulp.src(css_dest+'*.css')
  .pipe(
    purgecss({
      content: ['source/**/*.erb'],
      extractors: [
          {
            extractor: TailwindExtractor,
            extensions: ["erb"]
          }
        ]
    })
  )
  .pipe(gulp.dest(dest+'css/'))
  done();
}));

gulp.task('build', gulp.series('postcss', 'purgecss'));

gulp.task('serve', gulp.series('postcss', 'purgecss', function(done){
  browserSync.init({
      proxy: "http://localhost:4567",
      reloadDelay: 1500
  });

  gulp.watch(['css/**/*.css', 'source/**/*.{erb,html,haml}'], gulp.series('postcss', 'purgecss', function(done){
      browserSync.reload();
      done();
  }));
}));
