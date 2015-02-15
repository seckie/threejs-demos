'use strict'

initMesh = (scene, config, dataset) ->
  objects = {}

  triangleGeometry = new THREE.Geometry()
  triangleGeometry.vertices.push(new THREE.Vector3(0.0, 1.0, 0.0))
  triangleGeometry.vertices.push(new THREE.Vector3(-1.0, -1.0, 0.0))
  triangleGeometry.vertices.push(new THREE.Vector3(1.0, -1.0, 0.0))
  triangleGeometry.faces.push(new THREE.Face3(0, 1, 2))
  triangleGeometry.faces[0].vertexColors[0] = new THREE.Color(0xff0000)
  triangleGeometry.faces[0].vertexColors[1] = new THREE.Color(0x00ff00)
  triangleGeometry.faces[0].vertexColors[2] = new THREE.Color(0x0000ff)

  triangleMaterial = new THREE.MeshBasicMaterial(
    vertexColors: THREE.VertexColors
    side: THREE.DoubleSide
  )
  triangleMesh = new THREE.Mesh(triangleGeometry, triangleMaterial)
  triangleMesh.position.set(-1.5, 0.0, 4.0)
  scene.add(triangleMesh)
  objects.triangle = triangleMesh


  squareGeometry = new THREE.Geometry()
  squareGeometry.vertices.push( new THREE.Vector3(-1.0, 1.0, 0.0))
  squareGeometry.vertices.push( new THREE.Vector3(1.0, 1.0, 0.0))
  squareGeometry.vertices.push( new THREE.Vector3(1.0, -1.0, 0,0))
  squareGeometry.vertices.push( new THREE.Vector3(-1.0, -1.0, 0.0))
  squareGeometry.faces.push(new THREE.Face3(0, 1, 2))
  squareGeometry.faces.push(new THREE.Face3(0, 2, 3))

  squareMaterial = new THREE.MeshBasicMaterial(
    color: 0x8080ff
    side: THREE.DoubleSide
  )
  squareMesh = new THREE.Mesh(squareGeometry, squareMaterial)
  squareMesh.position.set(1.5, 0.0, 4.0)
  scene.add(squareMesh)
  objects.square = squareMesh

  return objects


init = (scene, config, dataset) ->
  return initMesh(scene, config, dataset)

module.exports = init
