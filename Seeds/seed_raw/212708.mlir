module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<146> : tensor<4x2xi32>}> : () -> tensor<4x2xi32>
    %1 = "tosa.const"() <{values = dense<1.485500e+02> : tensor<6x1x1x10xf32>}> : () -> tensor<6x1x1x10xf32>
    %2 = tosa.abs %0 : (tensor<4x2xi32>) -> tensor<4x2xi32>
    %3 = tosa.log %1 : (tensor<6x1x1x10xf32>) -> tensor<6x1x1x10xf32>
    %4 = tosa.reduce_max %3 {axis = 2 : i32} : (tensor<6x1x1x10xf32>) -> tensor<6x1x1x10xf32>
    %cast = tensor.cast %2 : tensor<4x2xi32> to tensor<*xi32>
    %cast_0 = tensor.cast %4 : tensor<6x1x1x10xf32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

