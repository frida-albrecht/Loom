module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<15> : tensor<10x8x1x5xi32>}> : () -> tensor<10x8x1x5xi32>
    %1 = "tosa.const"() <{values = dense<-4.078000e+01> : tensor<10xf32>}> : () -> tensor<10xf32>
    %2 = tosa.reverse %0 {axis = 3 : i32} : (tensor<10x8x1x5xi32>) -> tensor<10x8x1x5xi32>
    %3 = tosa.tanh %1 : (tensor<10xf32>) -> tensor<10xf32>
    %4 = tosa.reduce_max %2 {axis = 0 : i32} : (tensor<10x8x1x5xi32>) -> tensor<1x8x1x5xi32>
    %5 = tosa.rsqrt %3 : (tensor<10xf32>) -> tensor<10xf32>
    %6 = tosa.logical_left_shift %4, %4 : (tensor<1x8x1x5xi32>, tensor<1x8x1x5xi32>) -> tensor<1x8x1x5xi32>
    %7 = tosa.pow %5, %3 : (tensor<10xf32>, tensor<10xf32>) -> tensor<10xf32>
    %cast = tensor.cast %6 : tensor<1x8x1x5xi32> to tensor<*xi32>
    %cast_0 = tensor.cast %7 : tensor<10xf32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

