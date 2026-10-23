module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<118> : tensor<1x3x8xi32>}> : () -> tensor<1x3x8xi32>
    %1 = "tosa.const"() <{values = dense<-74> : tensor<1x8x4xi32>}> : () -> tensor<1x8x4xi32>
    %2 = "tosa.const"() <{values = dense<1.344000e+02> : tensor<5x3xf32>}> : () -> tensor<5x3xf32>
    %3 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %4 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %5 = tosa.matmul %0, %1, %3, %4 : (tensor<1x3x8xi32>, tensor<1x8x4xi32>, tensor<1xi32>, tensor<1xi32>) -> tensor<1x3x4xi32>
    %6 = tosa.reciprocal %2 : (tensor<5x3xf32>) -> tensor<5x3xf32>
    %7 = tosa.sigmoid %6 : (tensor<5x3xf32>) -> tensor<5x3xf32>
    %8 = tosa.logical_left_shift %5, %5 : (tensor<1x3x4xi32>, tensor<1x3x4xi32>) -> tensor<1x3x4xi32>
    %9 = tosa.identity %7 : (tensor<5x3xf32>) -> tensor<5x3xf32>
    %10 = tosa.floor %9 : (tensor<5x3xf32>) -> tensor<5x3xf32>
    %cast = tensor.cast %8 : tensor<1x3x4xi32> to tensor<*xi32>
    %cast_0 = tensor.cast %10 : tensor<5x3xf32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

