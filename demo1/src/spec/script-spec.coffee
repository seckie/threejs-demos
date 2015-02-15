'use strict'

publicDir = '/base'

describe 'Script spec', () ->
  beforeEach((done) ->
    jasmine.getFixtures().fixturesPath = publicDir + '/spec'
    loadFixtures('fixture.html')
    done()
  )
  it('document.getElementById() should returns DOM element in fixture', () ->
    $el = document.getElementById('canvas')
    expect(typeof $el.appendChild).toBe('function')
  )
