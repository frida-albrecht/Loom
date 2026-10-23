module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-162> : tensor<9x10xi64>}> : () -> tensor<9x10xi64>
    %1 = "tosa.const"() <{values = dense<-1.849400e+02> : tensor<1x5x4xf32>}> : () -> tensor<1x5x4xf32>
    %2 = tosa.reduce_product %0 {axis = 0 : i32} : (tensor<9x10xi64>) -> tensor<1x10xi64>
    %3 = tosa.rsqrt %1 : (tensor<1x5x4xf32>) -> tensor<1x5x4xf32>
    %4 = tosa.rsqrt %3 : (tensor<1x5x4xf32>) -> tensor<1x5x4xf32>
    %5 = tosa.exp %3 : (tensor<1x5x4xf32>) -> tensor<1x5x4xf32>
    %cast = tensor.cast %2 : tensor<1x10xi64> to tensor<*xi64>
    %cast_0 = tensor.cast %4 : tensor<1x5x4xf32> to tensor<*xf32>
    %cast_1 = tensor.cast %5 : tensor<1x5x4xf32> to tensor<*xf32>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    call @printMemrefF32(%cast_1) : (tensor<*xf32>) -> ()
    return
  }
}

