module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-48> : tensor<8x3x1xi32>}> : () -> tensor<8x3x1xi32>
    %1 = "tosa.const"() <{values = dense<-98> : tensor<8x1x1xi32>}> : () -> tensor<8x1x1xi32>
    %2 = "tosa.const"() <{values = dense<8.126000e+01> : tensor<8xf32>}> : () -> tensor<8xf32>
    %3 = tosa.maximum %0, %1 : (tensor<8x3x1xi32>, tensor<8x1x1xi32>) -> tensor<8x3x1xi32>
    %4 = tosa.ceil %2 : (tensor<8xf32>) -> tensor<8xf32>
    %5 = tosa.reduce_min %4 {axis = 0 : i32} : (tensor<8xf32>) -> tensor<1xf32>
    %6 = tosa.identity %5 : (tensor<1xf32>) -> tensor<1xf32>
    %cast = tensor.cast %3 : tensor<8x3x1xi32> to tensor<*xi32>
    %cast_0 = tensor.cast %6 : tensor<1xf32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

