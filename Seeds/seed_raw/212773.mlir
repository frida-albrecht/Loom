module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-176> : tensor<4x2x5xi64>}> : () -> tensor<4x2x5xi64>
    %1 = "tosa.const"() <{values = dense<1.001000e+01> : tensor<4xf32>}> : () -> tensor<4xf32>
    %2 = tosa.reduce_min %0 {axis = 0 : i32} : (tensor<4x2x5xi64>) -> tensor<1x2x5xi64>
    %3 = tosa.exp %1 : (tensor<4xf32>) -> tensor<4xf32>
    %4 = tosa.reduce_product %3 {axis = 0 : i32} : (tensor<4xf32>) -> tensor<1xf32>
    %cast = tensor.cast %2 : tensor<1x2x5xi64> to tensor<*xi64>
    %cast_0 = tensor.cast %4 : tensor<1xf32> to tensor<*xf32>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

