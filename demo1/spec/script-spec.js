'use strict';
var publicDir;

publicDir = '/base';

describe('Script spec', function() {
  beforeEach(function(done) {
    jasmine.getFixtures().fixturesPath = publicDir + '/spec';
    loadFixtures('fixture.html');
    return done();
  });
  return it('document.getElementById() should returns DOM element in fixture', function() {
    var $el;
    $el = document.getElementById('canvas');
    return expect(typeof $el.appendChild).toBe('function');
  });
});
