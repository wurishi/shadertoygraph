import * as Type from './type'

export function createUnitQuad(gl: WebGL2RenderingContext): Type.Drawer {
    const quad = gl.createBuffer()!
    gl.bindBuffer(gl.ARRAY_BUFFER, quad)
    gl.bufferData(
        gl.ARRAY_BUFFER,
        new Float32Array([
            -1.0, -1.0, 1.0, -1.0, -1.0, 1.0, 1.0, -1.0, 1.0, 1.0, -1.0, 1.0,
        ]),
        gl.STATIC_DRAW
    )
    gl.bindBuffer(gl.ARRAY_BUFFER, null)

    return ({ vpos }) => {
        gl.bindBuffer(gl.ARRAY_BUFFER, quad)
        gl.vertexAttribPointer(vpos, 2, gl.FLOAT, false, 0, 0)
        gl.enableVertexAttribArray(vpos)
        gl.drawArrays(gl.TRIANGLES, 0, 6)
        gl.disableVertexAttribArray(vpos)
        gl.bindBuffer(gl.ARRAY_BUFFER, null)
    }
}

export function createFullScreenTriangle(
    gl: WebGL2RenderingContext
): Type.Drawer {
    const tri = gl.createBuffer()!
    gl.bindBuffer(gl.ARRAY_BUFFER, tri)
    gl.bufferData(
        gl.ARRAY_BUFFER,
        new Float32Array([-1.0, -1.0, 3.0, -1.0, -1.0, 3.0]),
        gl.STATIC_DRAW
    )
    gl.bindBuffer(gl.ARRAY_BUFFER, null)

    return ({ vpos }) => {
        gl.bindBuffer(gl.ARRAY_BUFFER, tri)
        gl.vertexAttribPointer(vpos, 2, gl.FLOAT, false, 0, 0)
        gl.enableVertexAttribArray(vpos)
        gl.drawArrays(gl.TRIANGLES, 0, 3)
        gl.disableVertexAttribArray(vpos)
        gl.bindBuffer(gl.ARRAY_BUFFER, null)
    }
}

export function createUnitCubeNor(gl: WebGL2RenderingContext): Type.Drawer {
    const cubePosNor = gl.createBuffer()!
    gl.bindBuffer(gl.ARRAY_BUFFER, cubePosNor)
    gl.bufferData(
        gl.ARRAY_BUFFER,
        new Float32Array([
            -1.0, -1.0, -1.0, -1.0, 0.0, 0.0, -1.0, -1.0, 1.0, -1.0, 0.0, 0.0,
            -1.0, 1.0, -1.0, -1.0, 0.0, 0.0, -1.0, 1.0, 1.0, -1.0, 0.0, 0.0,
            1.0, 1.0, -1.0, 1.0, 0.0, 0.0, 1.0, 1.0, 1.0, 1.0, 0.0, 0.0, 1.0,
            -1.0, -1.0, 1.0, 0.0, 0.0, 1.0, -1.0, 1.0, 1.0, 0.0, 0.0, 1.0, 1.0,
            1.0, 0.0, 1.0, 0.0, 1.0, 1.0, -1.0, 0.0, 1.0, 0.0, -1.0, 1.0, 1.0,
            0.0, 1.0, 0.0, -1.0, 1.0, -1.0, 0.0, 1.0, 0.0, 1.0, -1.0, -1.0, 0.0,
            -1.0, 0.0, 1.0, -1.0, 1.0, 0.0, -1.0, 0.0, -1.0, -1.0, -1.0, 0.0,
            -1.0, 0.0, -1.0, -1.0, 1.0, 0.0, -1.0, 0.0, -1.0, 1.0, 1.0, 0.0,
            0.0, 1.0, -1.0, -1.0, 1.0, 0.0, 0.0, 1.0, 1.0, 1.0, 1.0, 0.0, 0.0,
            1.0, 1.0, -1.0, 1.0, 0.0, 0.0, 1.0, -1.0, -1.0, -1.0, 0.0, 0.0,
            -1.0, -1.0, 1.0, -1.0, 0.0, 0.0, -1.0, 1.0, -1.0, -1.0, 0.0, 0.0,
            -1.0, 1.0, 1.0, -1.0, 0.0, 0.0, -1.0,
        ]),
        gl.STATIC_DRAW
    )
    gl.bindBuffer(gl.ARRAY_BUFFER, null)

    return ({ vposa }) => {
        gl.bindBuffer(gl.ARRAY_BUFFER, cubePosNor)
        gl.vertexAttribPointer(vposa[0], 3, gl.FLOAT, false, 0, 0)
        gl.vertexAttribPointer(vposa[1], 3, gl.FLOAT, false, 0, 0)
        gl.enableVertexAttribArray(vposa[0])
        gl.enableVertexAttribArray(vposa[1])
        gl.drawArrays(gl.TRIANGLE_STRIP, 0, 4)
        gl.drawArrays(gl.TRIANGLE_STRIP, 4, 4)
        gl.drawArrays(gl.TRIANGLE_STRIP, 8, 4)
        gl.drawArrays(gl.TRIANGLE_STRIP, 12, 4)
        gl.drawArrays(gl.TRIANGLE_STRIP, 16, 4)
        gl.drawArrays(gl.TRIANGLE_STRIP, 20, 4)
        gl.disableVertexAttribArray(vposa[0])
        gl.disableVertexAttribArray(vposa[1])
        gl.bindBuffer(gl.ARRAY_BUFFER, null)
    }
}

export function createUnitCube(gl: WebGL2RenderingContext): Type.Drawer {
    const cubePos = gl.createBuffer()!
    gl.bindBuffer(gl.ARRAY_BUFFER, cubePos)
    gl.bufferData(
        gl.ARRAY_BUFFER,
        new Float32Array([
            -1.0, -1.0, -1.0, -1.0, -1.0, 1.0, -1.0, 1.0, -1.0, -1.0, 1.0, 1.0,
            1.0, 1.0, -1.0, 1.0, 1.0, 1.0, 1.0, -1.0, -1.0, 1.0, -1.0, 1.0, 1.0,
            1.0, 1.0, 1.0, 1.0, -1.0, -1.0, 1.0, 1.0, -1.0, 1.0, -1.0, 1.0,
            -1.0, -1.0, 1.0, -1.0, 1.0, -1.0, -1.0, -1.0, -1.0, -1.0, 1.0, -1.0,
            1.0, 1.0, -1.0, -1.0, 1.0, 1.0, 1.0, 1.0, 1.0, -1.0, 1.0, -1.0,
            -1.0, -1.0, -1.0, 1.0, -1.0, 1.0, -1.0, -1.0, 1.0, 1.0, -1.0,
        ]),
        gl.STATIC_DRAW
    )
    gl.bindBuffer(gl.ARRAY_BUFFER, null)

    return ({ vpos }) => {
        gl.bindBuffer(gl.ARRAY_BUFFER, cubePos)
        gl.vertexAttribPointer(vpos, 3, gl.FLOAT, false, 0, 0)
        gl.enableVertexAttribArray(vpos)
        gl.drawArrays(gl.TRIANGLE_STRIP, 0, 4)
        gl.drawArrays(gl.TRIANGLE_STRIP, 4, 4)
        gl.drawArrays(gl.TRIANGLE_STRIP, 8, 4)
        gl.drawArrays(gl.TRIANGLE_STRIP, 12, 4)
        gl.drawArrays(gl.TRIANGLE_STRIP, 16, 4)
        gl.drawArrays(gl.TRIANGLE_STRIP, 20, 4)
        gl.disableVertexAttribArray(vpos)
        gl.bindBuffer(gl.ARRAY_BUFFER, null)
    }
}
