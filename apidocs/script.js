$(function() {
  // make result of marked for pretty print
  $('pre code[class^="lang-"]').addClass('.prettyprint');
  window.prettyPrint && prettyPrint()
});

$('body').on('click', '.showcode', function () {
  $(this).next().toggle();
  $('body').scrollspy('refresh');
});

$('body').on('shown.bs.collapse hidden.bs.collapse', function () {
  $('body').scrollspy('refresh');
});

var $options_private = $('#options-private');
if (window.localStorage && window.localStorage.getItem('options-private')==='true') {
  $options_private.prop('checked', true);
}
function updatePrivate() {
  if (window.localStorage) {
    window.localStorage.setItem('options-private', $options_private.is(':checked'));
  }
  if ($options_private.is(':checked')) {
    $('.private').show();
  } else {
    $('.private').hide();
  }
  $('body').scrollspy('refresh');
}
$options_private.on('click', updatePrivate);
updatePrivate();

function augmentLabels(labelToBootstrap) {
    var labels = Object.keys(labelToBootstrap);
    for (var idx in labels) {
        var label = labels[idx];
        console.log(label);
        $(".label-" + label).addClass("label-" + labelToBootstrap[label]);
    }
}
augmentLabels({
    property:   'warning',
    optional:   'info',
    static:     'warning',
    abstract:   'warning',
    override:   'warning',
    async:      'warning',
    addable:    'warning',
    excludable: 'warning',
    private:    'warning',
    chainable:  'warning',
});
