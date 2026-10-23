module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-97> : tensor<4x4x10x8xi32>}> : () -> tensor<4x4x10x8xi32>
    %1 = "tosa.const"() <{values = dense<-8.826000e+01> : tensor<8x3x10x3xf32>}> : () -> tensor<8x3x10x3xf32>
    %2 = tosa.abs %0 : (tensor<4x4x10x8xi32>) -> tensor<4x4x10x8xi32>
    %3 = tosa.reduce_max %2 {axis = 2 : i32} : (tensor<4x4x10x8xi32>) -> tensor<4x4x1x8xi32>
    %4 = tosa.maximum %3, %3 : (tensor<4x4x1x8xi32>, tensor<4x4x1x8xi32>) -> tensor<4x4x1x8xi32>
    %5 = tosa.rsqrt %1 : (tensor<8x3x10x3xf32>) -> tensor<8x3x10x3xf32>
    %6 = tosa.sigmoid %5 : (tensor<8x3x10x3xf32>) -> tensor<8x3x10x3xf32>
    %cast = tensor.cast %4 : tensor<4x4x1x8xi32> to tensor<*xi32>
    %cast_0 = tensor.cast %6 : tensor<8x3x10x3xf32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

